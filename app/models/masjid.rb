class Masjid < ApplicationRecord
  belongs_to :imam,
             class_name: "User",
             foreign_key: :imam_id

  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships

  has_one :namaz_schedule, dependent: :destroy

  validates :name, presence: true
  validates :address, presence: true

  validate :imam_must_be_imam

  private

  def imam_must_be_imam
    return if imam&.imam?

    errors.add(:imam, "must have imam role")
  end
end