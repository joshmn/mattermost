lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "mattermost/version"

Gem::Specification.new do |spec|
  spec.name          = "mattermost"
  spec.version       = Mattermost::VERSION
  spec.authors       = ["Josh Brody"]
  spec.email         = ["josh@josh.mn"]

  spec.summary       = "A slick Mattermost API client"
  spec.description   = "A slick Mattermost API client"
  spec.homepage      = "http://josh.mn"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'httparty'

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rake", "~> 10.0"
end
