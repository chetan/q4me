
begin
  require 'rubygems'
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "q4me"
    gemspec.summary = "A simple Ruby library for Q4M"
    gemspec.description = "A simple Ruby library for working with Q4M."
    gemspec.email = "chetan@pixelcop.net"
    gemspec.homepage = "http://github.com/chetan/q4me"
    gemspec.authors = ["Chetan Sarva"]
    gemspec.add_dependency('dbi', '>= 0.4.5')
    gemspec.add_dependency('dbd-mysql', '>= 0.4.4')
    gemspec.add_dependency('mysql', '>= 2.8.1')
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install jeweler"
end

require "rake/testtask"
desc "Run unit tests"
Rake::TestTask.new("test") { |t|
    #t.libs << "test"
    t.ruby_opts << "-rubygems"
    t.pattern = "test/**/*_test.rb"
    t.verbose = false
    t.warning = false
}

require "yard"
    YARD::Rake::YardocTask.new("docs") do |t|
end
