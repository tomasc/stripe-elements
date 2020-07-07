# frozen_string_literal: true

module Stripe::Elements
  class Component < ApplicationComponent
    option :message, type: Types::String
  end
end
