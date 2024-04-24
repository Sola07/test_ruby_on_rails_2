module Purchasers
  class CreateService
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
      Purchaser.find_or_create_by(
      last_name: params["Nom"],
      first_name: params["Prenom"],
      email: params["Email"],
      address: params["Adresse"],
      zipcode: params["Code postal"],
      country: params["Pays"],
      age: params["Age"],
      gender: params["Sexe"]
    )
    end
  end
end
