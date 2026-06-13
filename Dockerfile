# syntax=docker/dockerfile:1
ARG RUBY_VERSION=3.3.6
FROM ruby:$RUBY_VERSION-slim AS base

WORKDIR /rails

# Install system dependencies
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    curl \
    libjemalloc2 \
    libvips \
    postgresql-client \
    build-essential \
    git \
    libpq-dev \
    libyaml-dev \
    pkg-config && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Environment
ENV RAILS_ENV="production" \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="development test" \
    LD_PRELOAD="/usr/local/lib/libjemalloc.so"

# Jemalloc setup
RUN ln -s /usr/lib/$(uname -m)-linux-gnu/libjemalloc.so.2 /usr/local/lib/libjemalloc.so

# -------------------------
# BUILD STAGE
# -------------------------
FROM base AS build

WORKDIR /rails

COPY Gemfile Gemfile.lock ./

RUN bundle install

COPY . .

RUN bundle exec bootsnap precompile --gemfile || true

# -------------------------
# FINAL STAGE
# -------------------------
FROM base

WORKDIR /rails

# Create non-root user
RUN groupadd --system --gid 1000 rails && \
    useradd rails --uid 1000 --gid 1000 --create-home --shell /bin/bash

USER rails:rails

# Copy app + gems
COPY --chown=rails:rails --from=build /usr/local/bundle /usr/local/bundle
COPY --chown=rails:rails --from=build /rails /rails

# Ensure bin is executable
RUN chmod +x bin/* || true

# ENTRYPOINT (keep if exists and working)
ENTRYPOINT ["/rails/bin/docker-entrypoint"]

# Render listens on dynamic port
EXPOSE 3000

# ✅ FIXED START COMMAND (IMPORTANT)
CMD ["bash", "-c", "bundle exec rails server -b 0.0.0.0 -p $PORT"]