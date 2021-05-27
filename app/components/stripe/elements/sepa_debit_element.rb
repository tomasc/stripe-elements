# frozen_string_literal: true

module Stripe
  module Elements
    class SepaDebitElement < Element
      include Stripe::Elements::CountryApplicability
      include Stripe::Elements::CurrencyApplicability

      # FLOW = "none"

      def applicable_countries
        %w[FR DE ES BE NL LU IT PT AT IE FI]
      end

      def applicable_currencies
        %w[eur]
      end
    end
  end
end
