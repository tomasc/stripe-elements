module Stripe
  module Elements
    class Engine < ::Rails::Engine
      isolate_namespace Stripe::Elements
    end
  end
end
