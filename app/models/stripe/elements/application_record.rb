module Stripe
  module Elements
    class ApplicationRecord < ActiveRecord::Base
      self.abstract_class = true
    end
  end
end
