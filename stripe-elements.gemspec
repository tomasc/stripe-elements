$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "stripe/elements/version"

Gem::Specification.new do |spec|
  spec.name          = "stripe-elements"
  spec.version       = Stripe::Elements::VERSION
  spec.authors       = ["Tomáš Celizna", "Asger Behncke Jacobsen"]
  spec.email         = ["mail@tomascelizna.com", "a@asgerbehnckejacobsen.dk"]

  spec.summary       = %q{Stripe Elements Rails Engine with Stimulus Js}
  spec.homepage      = "https://github.com/tomasc/stripe-elements"
  spec.license       = "MIT"

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", "~> 6.0.3", ">= 6.0.3.2"

  spec.add_development_dependency "sqlite3"
end
