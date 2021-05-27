# frozen_string_literal: true

module Stripe
  class Elements
    class Selector < Base
      option :elements

      def call
        tag.div dom_attrs do
          [navigation, rendered_elements].reject(&:blank?).join.html_safe
        end
      end

      def rendered_elements
        elements.map { |element| render(element) }.join.html_safe
      end

      def navigation
        render Navigation.new(elements: elements)
      end

      def dom_data
        super.merge(stimulus_controller_data)
      end

      class Navigation < Stripe::Component
        delegate(:stimulus_action, :stimulus_target, to: :"Stripe::Elements::Selector")

        option :elements

        def call
          tag.nav buttons, dom_attrs
        end

        def buttons
          elements.map do |element|
            render Button.new(element: element)
          end.join.html_safe
        end

        def render?
          rendered_elements.length > 1
        end

        def rendered_elements
          elements.reject { |e| !e.render? }
        end
      end

      class Button < Stripe::Component
        delegate(
          :stimulus_action_data,
          :stimulus_target_data,
          to: :"Stripe::Elements::Selector"
        )

        option :element

        def call
          render TabComponent.new(
            label: t(".#{element.identifier}"),
            selected: element.default?,
            data: dom_data
          )
        end

        def dom_data
          super
            .merge(stimulus_target_data("button"))
            .merge(stimulus_action_data("click" => "select"))
            .merge(element: element.identifier)
        end
      end
    end
  end
end
