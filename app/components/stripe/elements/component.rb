# frozen_string_literal: true

module Stripe
  module Elements
    class Component < Base
      DEFAULT_ELEMENT = Stripe::Elements::CardElement

      option :client_secret
      option :customer_email
      option :billing_address
      option :currency
      option :country_code
      option :publishable_key
      option :delivery_address, optional: true
      option :return_url, optional: true

      def call
        tag.div dom_attrs do
          selector + errors
        end
      end

      def elements
        [
          card_element,
          sepa_debit_element,
          ideal_bank_element
        ]
      end

      def errors
        tag.div class: bem(e: :errors), data: stimulus_target_data("errors")
      end

      def card_element
        CardElement.new
      end

      def sepa_debit_element
        SepaDebitElement.new(currency: currency, country: country_code)
      end

      def ideal_bank_element
        IdealBankElement.new(currency: currency, country: country_code)
      end

      def selector
        render Stripe::Elements::Selector.new(elements: elements)
      end

      def dom_data
        super
          .merge(stimulus_controller_data)
          .merge(billing_address_data)
          .merge(customer_email_data)
          .merge(stripe_data)
          .merge(action_data)
      end

      def action_data
        stimulus_action_data(
          "stripe:element:change" => "handleChange",
          "stripe:element:error" => "handleError",
          "stripe:element:success" => "handleSuccess",
          "stripe:elements:select" => "selectElement",
        )
      end

      def billing_address_data
        stimulus_value_data("billing-address" => billing_address.to_json)
      end

      def customer_email_data
        stimulus_value_data("customer-email" => customer_email.to_json)
      end

      def delivery_address_data
        return if delivery_address.blank?
        stimulus_value_data("delivery-address" => delivery_address.to_json)
      end

      def stripe_data
        stimulus_value_data(
          stripe: {
            country_code: country_code,
            publishable_key: publishable_key,
            client_secret: client_secret,
            return_url: return_url
          }
        )
      end
    end
  end
end
