lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "tapenade/version"

Gem::Specification.new do |spec|
  spec.name          = "tapenade"
  spec.version       = Tapenade::VERSION
  spec.authors       = ["Benoit MARTIN-CHAVE"]
  spec.email         = ["benoit@martin-chave.ch"]
  spec.homepage      = "https://github.com/benoitmc/tapenade"
  spec.summary       = "Want to call a method and return self instead of normal return ? Just prefix it with tap_ !"
  spec.description   = spec.summary
  spec.license       = "MIT"

  spec.files = Dir["lib/**/*", "README.md", "LICENSE.txt"]
end
