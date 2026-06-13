class User < ApplicationRecord
  has_secure_password

  enum :role, {
    namazi: 0,
    imam: 1,
    intazamiya: 2
  }

  has_many :memberships
  has_many :masjids, through: :memberships
end