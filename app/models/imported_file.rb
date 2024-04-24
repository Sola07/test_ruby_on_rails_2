class ImportedFile < ApplicationRecord
  has_many :bookings
  has_many :shows
  has_many :events, through: :shows
end
