class Purchaser < ApplicationRecord
  has_many :bookings
  validates :email, presence: true, uniqueness: true
end
