# -*- encoding: utf-8 -*-
# stub: ridgepole 0.9.2 ruby lib

Gem::Specification.new do |s|
  s.name = "ridgepole".freeze
  s.version = "0.9.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Genki Sugawara".freeze]
  s.date = "2021-03-13"
  s.description = "Ridgepole is a tool to manage DB schema. It defines DB schema using Rails DSL, and updates DB schema according to DSL.".freeze
  s.email = ["sugawara@cookpad.com".freeze]
  s.executables = ["ridgepole".freeze]
  s.files = ["bin/ridgepole".freeze]
  s.homepage = "https://github.com/winebarrel/ridgepole".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.2.7".freeze)
  s.rubygems_version = "3.2.3".freeze
  s.summary = "Ridgepole is a tool to manage DB schema.".freeze

  s.installed_by_version = "3.2.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<activerecord>.freeze, [">= 5.1", "< 6.2"])
    s.add_runtime_dependency(%q<diffy>.freeze, [">= 0"])
    s.add_development_dependency(%q<appraisal>.freeze, [">= 2.2.0"])
    s.add_development_dependency(%q<bundler>.freeze, [">= 0"])
    s.add_development_dependency(%q<erbh>.freeze, [">= 0.1.2"])
    s.add_development_dependency(%q<hash_modern_inspect>.freeze, [">= 0.1.1"])
    s.add_development_dependency(%q<hash_order_helper>.freeze, [">= 0.1.6"])
    s.add_development_dependency(%q<mysql2>.freeze, [">= 0"])
    s.add_development_dependency(%q<pg>.freeze, [">= 0"])
    s.add_development_dependency(%q<rake>.freeze, [">= 0"])
    s.add_development_dependency(%q<rspec>.freeze, [">= 3.0.0"])
    s.add_development_dependency(%q<rspec-match_fuzzy>.freeze, [">= 0.1.3"])
    s.add_development_dependency(%q<rspec-match_ruby>.freeze, [">= 0.1.3"])
    s.add_development_dependency(%q<rubocop>.freeze, ["= 1.9.1"])
    s.add_development_dependency(%q<rubocop-rake>.freeze, [">= 0.5.1"])
    s.add_development_dependency(%q<rubocop-rspec>.freeze, [">= 2.1.0"])
    s.add_development_dependency(%q<simplecov>.freeze, [">= 0"])
    s.add_development_dependency(%q<simplecov-lcov>.freeze, [">= 0"])
  else
    s.add_dependency(%q<activerecord>.freeze, [">= 5.1", "< 6.2"])
    s.add_dependency(%q<diffy>.freeze, [">= 0"])
    s.add_dependency(%q<appraisal>.freeze, [">= 2.2.0"])
    s.add_dependency(%q<bundler>.freeze, [">= 0"])
    s.add_dependency(%q<erbh>.freeze, [">= 0.1.2"])
    s.add_dependency(%q<hash_modern_inspect>.freeze, [">= 0.1.1"])
    s.add_dependency(%q<hash_order_helper>.freeze, [">= 0.1.6"])
    s.add_dependency(%q<mysql2>.freeze, [">= 0"])
    s.add_dependency(%q<pg>.freeze, [">= 0"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, [">= 3.0.0"])
    s.add_dependency(%q<rspec-match_fuzzy>.freeze, [">= 0.1.3"])
    s.add_dependency(%q<rspec-match_ruby>.freeze, [">= 0.1.3"])
    s.add_dependency(%q<rubocop>.freeze, ["= 1.9.1"])
    s.add_dependency(%q<rubocop-rake>.freeze, [">= 0.5.1"])
    s.add_dependency(%q<rubocop-rspec>.freeze, [">= 2.1.0"])
    s.add_dependency(%q<simplecov>.freeze, [">= 0"])
    s.add_dependency(%q<simplecov-lcov>.freeze, [">= 0"])
  end
end
