module Shop
  module Stripe
    class ElementsComponent
      class SepaDebitElementComponent < ElementComponent
        FLOW = "none"
        COUNTRIES = %w[FR DE ES BE NL LU IT PT AT IE FI]
        CURRENCIES = %w[eur]

        def initialize(billing_address:)
          @billing_address = billing_address
        end

        private

        attr_reader :billing_address

        def render?
          COUNTRIES.include?(billing_address.country.alpha2.upcase)
        end
      end
    end
  end
end