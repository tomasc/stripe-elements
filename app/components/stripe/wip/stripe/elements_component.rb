module Shop
  module Stripe
    class ElementsComponent < ApplicationComponent
      COUNTRY_CODE = ""
      PUBLISHABLE_KEY = ""

      def initialize(form: nil, client_secret:, customer_email:, billing_address:, delivery_address: nil)
        @form = form
        @client_secret = client_secret
        @customer_email = customer_email
        @billing_address = billing_address
        @delivery_address = delivery_address
      end

      private

      attr_reader :form
      attr_reader :client_secret
      attr_reader :customer_email
      attr_reader :billing_address
      attr_reader :delivery_address

      def elements
        [
          card_element_component,
          sepa_debit_element_component,
          ideal_bank_element_component
        ]
      end

      def card_element_component
        CardElementComponent.new
      end

      def sepa_debit_element_component
        SepaDebitElementComponent.new(billing_address: billing_address)
      end

      def ideal_bank_element_component
        IdealBankElementComponent.new(billing_address: billing_address)
      end

      def dom_data
        super
          .merge(controller_data)
          .merge(billing_address_data)
          .merge(customer_email_data)
          .merge(stripe_data)
          .merge(action_data)
      end

      def action_data
        { action: "stripe:element:change->#{controller_name}#onChange" }
      end

      def billing_address_data
        { "#{controller_name}-billing-address": billing_address.to_json }
      end

      def customer_email_data
        { "#{controller_name}-customer-email": customer_email }
      end

      def delivery_address_data
        return if delivery_address.blank?
        { "#{controller_name}-delivery-address": delivery_address.to_json }
      end

      def stripe_data
        {
          "#{controller_name}-stripe": {
            country_code: COUNTRY_CODE,
            publishable_key: PUBLISHABLE_KEY,
            client_secret: client_secret,
          }
        }
      end
    end
  end
end
