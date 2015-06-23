require 'rspec/core/rake_task'

task :default => [:spec]

task :spec do
  desc "Run the specs."
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.pattern = "spec/**/*_spec.rb"
    t.rspec_opts = "--tag ~slow"
  end
end

task integration: [:spec] do
  desc "Run the specs including the integration specs."
  RSpec::Core::RakeTask.new(:integration) do |t|
    t.pattern = "spec/**/*_spec.rb"
    t.rspec_opts = "--tag slow"
  end
end

task :full do
  RSpec::Core::RakeTask.new(:full) do |t|
    t.pattern = "spec/**/*_spec.rb"
  end
end
