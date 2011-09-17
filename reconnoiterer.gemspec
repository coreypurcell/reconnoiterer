# -*- encoding: utf-8 -*-
require_relative "reconnoiterer/version"

Gem::Specification.new do |s|
  s.name        = "reconnoiterer"
  s.version     = Reconnoiterer::VERSION
  s.authors     = ["Corey Purcell"]
  s.email       = ["corey.purcell@gmail.com"]
  s.homepage    = "https://github.com/coreypurcell/Reconnoiterer"
  s.summary     = %q{An app for watching for conditions on websites}
  s.description = %q{App built around the Outpost gem that watches websites and alerts you to conditions}

  s.required_ruby_version = ">= 1.9.2"

  s.files   = Dir.glob("{lib,spec,bin}/**/*")
  s.files  += %w{README.md Rakefile LICENSE reconnoiterer.gemspec}
  s.require_paths = ["lib"]

end
