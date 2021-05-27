# frozen_string_literal: true

module Stripe
  module Elements
    class Base < ViewComponent::Base
      extend Dry::Initializer

      module Types
        include Dry.Types()
      end
    end
  end
end
