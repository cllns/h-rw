# Require this file for unit tests
ENV["HANAMI_ENV"] ||= "test"

require_relative "../config/environment"
Hanami.boot
Hanami::Utils.require!("#{__dir__}/support")

RSpec.configure do |config|
  config.color = true
  config.disable_monkey_patching!
  config.example_status_persistence_file_path = "./tmp/rspec-examples.txt"
  config.filter_run_when_matching :focus
  config.formatter = ENV["CI"] == "true" ? :progress : :documentation
  config.order = :random
  config.shared_context_metadata_behavior = :apply_to_host_groups

  # Hanami v1.3 depends on some older gems that have warnings for newer Rubies
  # They won't be updated, but we want warnings when we upgrade to Hanami v2.0
  # TODO: Change this value to `true` once we upgrade this repo.
  config.warnings = Hanami::Version.version >= "2.0.0"

  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_doubled_constant_names = true
    mocks.verify_partial_doubles = true
  end
end
