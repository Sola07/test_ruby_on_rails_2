class Show < ApplicationRecord
  has_many :events
  has_many :bookings
end
