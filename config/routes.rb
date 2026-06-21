Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  # Auth
  post "/register", to: "auth#register"
  post "/login", to: "auth#login"
  get "/me", to: "auth#me"

  # Masjid Routes
  post "/createmasjid", to: "masjids#create"
  get "/getallmasjids", to: "masjids#index"
  get "/getmasjidbyid/:id", to: "masjids#show"
  put "/updatemasjid/:id", to: "masjids#update"
  patch "/updatemasjid/:id", to: "masjids#update"
  delete "/deletemasjid/:id", to: "masjids#destroy"
end