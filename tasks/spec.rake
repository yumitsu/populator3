require 'rspec/core/rake_task'

ADAPTERS = YAML.load(File.read(File.dirname(__FILE__) + "/../spec/example_database.yml")).keys

desc "Run specs under all supported databases"
task :spec => ADAPTERS.map { |a| "spec:#{a}" }

namespace :spec do
  ADAPTERS.each do |adapter|
    namespace :prepare do
      task adapter do
        ENV["POPULATOR_ADAPTER"] = adapter
      end
    end
    
    desc "Run specs under #{adapter}"
    RSpec::Core::RakeTask.new(adapter => "spec:prepare:#{adapter}") do |t|
      #t.spec_files = Rake::FileList["spec/**/*_spec.rb"]
      t.rspec_opts = ["-c"]
    end
  end
end
