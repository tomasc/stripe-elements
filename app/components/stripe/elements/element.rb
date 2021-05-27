# frozen_string_literal: true

module Stripe
  module Elements
    class Element < Base
      def stripe_element
        tag.div data: stimulus_target_data("stripeElement")
      end

      def dom_attrs
        super.merge(hidden: !default?)
      end

      def dom_data
        super
          .merge(stimulus_controller_data)
          .merge(default_data)
          .merge(style_data)
          .merge(target_data)
          .merge(identifier_data)
      end

      def target_data
        Stripe::Elements.stimulus_target_data("element")
          .merge(Stripe::Elements::Selector.stimulus_target_data("element"))
      end

      def identifier_data
        { identifier: identifier }
      end

      def default_data
        stimulus_value_data(default: default?.to_s)
      end

      def style_data
        style_json = style.deep_transform_keys{ |key| key.to_s.camelize(:lower) }.to_json
        stimulus_value_data(style: style_json)
      end

      def default?
        self.class == DEFAULT_ELEMENT
      end

      def countries
        raise NotImplementedError
      end

      def currencies
        raise NotImplementedError
      end

      def identifier
        self.class.name.demodulize.underscore
      end

      def style
        {
          base: {
            font_family: "",
            font_size: "",
            color: "",
            icon_color: "",
            font_smoothing: "",
            font_weight: 400,
            "::placeholder": {
              color: "",
            },
            padding: ""
          },
          invalid: {
            iconColor: "",
            color: "#",
          }
        }
      end
    end
  end
end
