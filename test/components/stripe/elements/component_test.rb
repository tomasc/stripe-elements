# frozen_string_literal: true

require "test_helper"

module Stripe::Elements
  class ComponentTest < ViewComponent::TestCase
    test "component renders something useful" do
      assert_equal(
        %(<span>Hello, components!</span>),
        render_inline(Component.new(message: "Hello, components!")).css("span").to_html
      )
    end
  end
end
