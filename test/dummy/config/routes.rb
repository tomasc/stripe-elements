Rails.application.routes.draw do
  mount Stripe::Elements::Engine => "/stripe-elements"
end
