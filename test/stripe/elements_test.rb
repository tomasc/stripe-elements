require 'test_helper'

class Stripe::Elements::Test < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Module, Stripe::Elements
  end
end
