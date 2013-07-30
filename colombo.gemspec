# encoding: utf-8

$:.push File.expand_path("../lib", __FILE__)
require "colombo/version"

Gem::Specification.new do |s|
  s.name        = "colombo"
  s.version     = Colombo::VERSION
  s.authors     = ["Luis Mendes"]
  s.email       = ["lmmendes@gmail.com"]
  s.homepage    = "http://github.com/lmmendes/colombo"
  s.summary     = %q{Digital Ocean API client}
  s.description = %q{A simple ruby client for Digital Ocean API}

  s.rubyforge_project = "colombo"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.license = 'MIT'

  s.add_runtime_dependency "rest-client", "~> 1.6.7"

  s.add_development_dependency "minitest"
  s.add_development_dependency "webmock"
  s.add_development_dependency "vcr"
  s.add_development_dependency "turn"
  s.add_development_dependency "rake"

  s.signing_key = ENV['RUBYGEMS_PRIVATE_GEM_KEY']
  s.cert_chain  = ['gem-public_cert.pem']

end
