module Shop
  module Stripe
    class ElementsComponent
      class ElementComponent < ApplicationComponent
        def dom_data
          super
            .merge(controller_data)
            .merge(default_data)
            .merge(style_data)
            .merge(target_data)
        end

        def target_data
          { target: "#{Shop::Stripe::ElementsComponent.controller_name}.#{target_name}"}
        end

        def target_name
          model_name.to_s.split("::").last.camelcase(:lower).gsub("Component", "")
        end

        def default_data
          { default: default?.to_s }
        end

        def style_data
          { "#{controller_name}-style": style_json }
        end

        def default?
          false
        end

        def style_json
          style.deep_transform_keys{ |key| key.to_s.camelize(:lower) }.to_json
        end

        def style
          {
            base: {
              font_family: "",
              font_size: "",
              color: "",
              icon_color: "",
              font_smoothing: "",
              font_weight: ,
              "::placeholder": {
                color: "",
              }
            },
            invalid: {
              iconColor: "",
              color: "",
            }
           }
        end
      end
    end
  end
end