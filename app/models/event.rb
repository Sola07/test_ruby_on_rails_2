class Event < ApplicationRecord
  belongs_to :show
  has_many :bookings
  has_many :purchasers, through: :bookings
  has_many :pricings, through: :bookings
end
