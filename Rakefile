require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "pie-high"
    gem.summary = %Q{An easy-as-pie Ruby interface to the High Charts JavaScript library}
    gem.description = %Q{High Charts is one of the best JavaScript charting libraries there is.  Here is a straight-forward
                      Ruby API to harness all the power High Charts has to offer.  Includes support for Ruport pivot tables.}
    gem.email = "jefferey.sutherland@gmail.com"
    gem.homepage = "http://github.com/drpentode/pie-high"
    gem.authors = ["Jeff Sutherland"]
    gem.add_development_dependency "rspec", ">= 1.2.9"
    gem.add_development_dependency "ruport", ">=1.6.1"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :spec => :check_dependencies

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "pie-high #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
