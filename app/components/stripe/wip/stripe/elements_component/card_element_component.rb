module Shop
  module Stripe
    class ElementsComponent
      class CardElementComponent < ElementComponent
        FLOW = "none"

        # NOTE: tentative API for navigation component
        def default?
          true
        end
      end
    end
  end
end