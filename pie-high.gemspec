# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{pie-high}
  s.version = "0.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jeff Sutherland"]
  s.date = %q{2010-08-31}
  s.description = %q{High Charts is one of the best JavaScript charting libraries there is.  Here is a straight-forward
                      Ruby API to harness all the power High Charts has to offer.  Includes support for Ruport pivot tables.}
  s.email = %q{jefferey.sutherland@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "lib/hash_extensions.rb",
     "lib/high_chart.rb",
     "lib/high_chart_series.rb",
     "pie-high.gemspec",
     "spec/assets/high_chart_defaults.yml",
     "spec/high_chart_series_spec.rb",
     "spec/high_chart_spec.rb",
     "spec/spec.opts",
     "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://github.com/drpentode/pie-high}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{An easy-as-pie Ruby interface to the High Charts JavaScript library}
  s.test_files = [
    "spec/high_chart_series_spec.rb",
     "spec/high_chart_spec.rb",
     "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 1.2.9"])
      s.add_development_dependency(%q<ruport>, [">= 1.6.1"])
      s.add_development_dependency(%q<json_pure>, [">= 1.1.9"])
    else
      s.add_dependency(%q<rspec>, [">= 1.2.9"])
      s.add_dependency(%q<ruport>, [">= 1.6.1"])
      s.add_dependency(%q<json_pure>, [">= 1.1.9"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 1.2.9"])
    s.add_dependency(%q<ruport>, [">= 1.6.1"])
    s.add_dependency(%q<json_pure>, [">= 1.1.9"])
  end
end

