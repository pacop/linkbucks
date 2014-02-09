# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://guides.rubygems.org/specification-reference/ for more options
  gem.name = "linkbucks"
  gem.email = "pacopa.93@gmail.com"
  gem.homepage = "http://github.com/pacop/linkbucks"
  gem.license = "MIT"
  gem.summary = %Q{Unofficial API Wrapper for Linkbucks.com}
  gem.description = %Q{Unofficial API Wrapper for Linkbucks.com}
  gem.email = "pacopa.93@gmail.com"
  gem.authors = ["pacop"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

task :test => :spec

require 'yard'
YARD::Rake::YardocTask.new


task :default => [:spec]