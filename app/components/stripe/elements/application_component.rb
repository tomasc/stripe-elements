# frozen_string_literal: true

module Stripe::Elements
  class ApplicationComponent < ViewComponent::Base
    extend Dry::Initializer

    module Types
      include Dry.Types()
    end
  end
end
