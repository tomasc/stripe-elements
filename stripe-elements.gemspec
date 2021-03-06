# frozen_string_literal: true

$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "stripe/elements/version"

Gem::Specification.new do |spec|
  spec.name          = "stripe-elements"
  spec.version       = Stripe::Elements::VERSION
  spec.authors       = ["Tom\u00E1\u0161 Celizna", "Asger Behncke Jacobsen"]
  spec.email         = ["mail@tomascelizna.com", "a@asgerbehnckejacobsen.dk"]

  spec.summary       = "Stripe Elements Rails Engine with Stimulus Js"
  spec.homepage      = "https://github.com/tomasc/stripe-elements"
  spec.license       = "MIT"

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", "~> 6.0.3", ">= 6.0.3.2"
  spec.add_dependency "view_component", "~> 2.13"

  spec.add_dependency "dry-initializer", "~> 3.0"
  spec.add_dependency "dry-types", "~> 1.4"
  spec.add_dependency "slim", "~> 4.0"
  spec.add_dependency "slim-rails", "~> 3.2"

  spec.add_development_dependency "sqlite3"

  spec.add_development_dependency "capybara", "~> 3.33"
  spec.add_development_dependency "lefthook", "~> 0.7"
  spec.add_development_dependency "rubocop", "0.81"
  spec.add_development_dependency "rubocop-rails", "2.5.1"
  spec.add_development_dependency "rubocop-rails_config", "0.10"
end
