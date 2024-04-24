module Pricings
  class CreateService
    def initialize(params)
      @params = params
    end

    def call
      pricing.save!
      return pricing
    end

    private
    attr_reader :params

    def pricing
      @pricing ||= Pricing.new(
        amount: params["Prix"],
        product_type: params["Type de produit"]
      )
    end
  end
end
