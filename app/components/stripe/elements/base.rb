# frozen_string_literal: true

module Stripe
  module Elements
    class Component < ViewComponent::Base
      extend Dry::Initializer

      module Types
        include Dry.Types()
      end
    end
  end
end
