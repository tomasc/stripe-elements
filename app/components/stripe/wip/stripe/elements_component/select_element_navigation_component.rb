module Shop
  module Stripe
    class ElementsComponent
      class SelectElementNavigationComponent < ElementComponent
        def initialize(elements:)
          @elements = elements
        end

        private

        attr_reader :elements

        def dom_data
          super
            .merge(controller_data)
        end
      end
    end
  end
end