class Show < ApplicationRecord
  has_many :events
  has_many :bookings
  has_many :pricings, through: :bookings
  has_many :purchasers, through: :bookings
  belongs_to :imported_file

  def unique_purchasers
    total_purchasers = 0
    events.each do |event|
      total_purchasers += event.purchasers.distinct.count
    end
    return total_purchasers
  end

  def average_price_per_event
    total_price = 0
    total_events = events.count
    events.each do |event|
      total_price += event.pricings.average(:amount).to_f
    end

    if total_events > 0
      average_price = total_price / total_events
      return average_price.round(2)
    else
      return 0
    end
  end

  def average_purchasers_age
    total_age = 0
    total_purchasers = 0
    purchasers.each do |purchaser|
      if purchaser.age.present?
       total_age += purchaser.age
       total_purchasers += 1
      end
    end
    if total_purchasers > 0
      average_purchasers_age = total_age / total_purchasers
      return average_purchasers_age
    else
      return "Non renseigné"
    end
  end
end
