module Shop
  module Stripe
    class ElementsComponent
      class IdealBankElementComponent < ElementComponent
        FLOW = "redirect"
        COUNTRIES = %w[NL]
        CURRENCIES = %w[eur]

        def initialize(billing_address:)
          @billing_address = billing_address
        end

        private

        attr_reader :billing_address

        def render?
          COUNTRIES.include?(billing_address.country.alpha2.upcase)
        end

        def style
          super
            .merge({ padding: "9px" })
        end
      end
    end
  end
end