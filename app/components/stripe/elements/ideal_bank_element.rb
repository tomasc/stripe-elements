# frozen_string_literal: true

module Stripe
  module Elements
    class IdealBankElement < Element
      include CountryApplicability
      include CurrencyApplicability

      # FLOW = "redirect"

      def account_holder_input
        tag.input class: bem(e: :account_holder_input),
          data: stimulus_target_data("accountHolder"),
          placeholder: t(".account_holder")
      end

      def applicable_countries
        %w[NL]
      end

      def applicable_currencies
        %w[eur]
      end

      def style
        super.merge({ padding: "9px" })
      end
    end
  end
end
