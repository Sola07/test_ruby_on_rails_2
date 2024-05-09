module Purchasers
  class CreateService < ApplicationService
    def initialize(params)
      @params = params
    end

    def call
      purchaser.save!
      return purchaser
    end

    private
    attr_reader :params

    def purchaser
      @purchaser ||= find_or_create_purchaser
    end

    def find_or_create_purchaser
      purchaser = ::Purchaser.find_or_initialize_by(email: params["Email"]) do |new_purchaser|
        new_purchaser.last_name = params["Nom"]
        new_purchaser.first_name = params["Prenom"]
        new_purchaser.email = params["Email"]
        new_purchaser.address = params["Adresse"]
        new_purchaser.zipcode = params["Code postal"]
        new_purchaser.country = params["Pays"]
        new_purchaser.age = params["Age"]
        new_purchaser.gender = params["Sexe"]
      end
      purchaser
    end
  end
end
