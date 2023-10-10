require File.expand_path('lib/RORM/version', __dir__)

Gem::Specification.new do |spec|
  spec.name          = "RORM"
  spec.version       = RORM::VERSION
  spec.authors       = ["Mihai Neagoi"]
  spec.email         = ["neagoimihai@gmail.com"]
  spec.summary       = %q{A simple ORM for Ruby}
  spec.license       = "MIT"
  spec.platform      = Gem::Platform::RUBY
  spec.required_ruby_version = ">= 2.0.0"

  spec.files = Dir.glob('lib/**/*') + Dir["lib/RORM/version.rb", "lib/database_connection.rb", "lib/RORM.rb", "lib/", "rorm.gemspec", "Gemfile", "Gemfile.lock"]
  spec.add_dependency "pg"
end
