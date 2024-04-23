class Booking < ApplicationRecord
  belongs_to :event
  belongs_to :pricing
  belongs_to :purchaser
  belongs_to :show
  belongs_to :user_file
end
