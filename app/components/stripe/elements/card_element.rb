# frozen_string_literal: true

module Stripe
  class Elements
    class CardElement < Element
      # FLOW = "none"

      def card_holder_input
        tag.input class: bem(e: :card_holder_input),
          data: stimulus_target_data("cardHolder"),
          placeholder: t(".name_on_card")
      end

      def applicable_billing_address?
        true
      end

      def applicable_currency?
        true
      end
    end
  end
end
