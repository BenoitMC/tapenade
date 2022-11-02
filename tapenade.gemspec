lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "tapenade/version"

Gem::Specification.new do |spec|
  spec.name = "tapenade"
  spec.version = Tapenade::VERSION
  spec.authors = ["Benoit MARTIN-CHAVE"]
  spec.email = ["benoit@martin-chave.com"]
  spec.homepage = "https://github.com/benoitmc/tapenade"
  spec.summary = "Improved tap method"
  spec.description = spec.summary
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.7.0"
  spec.files = Dir["lib/**/*", "README.md", "LICENSE.txt"]
end
