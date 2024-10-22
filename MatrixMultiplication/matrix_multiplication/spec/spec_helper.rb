# frozen_string_literal: true

require 'matrix_multiplication'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.before(:all) do
    Encoding.default_external = Encoding::UTF_8
    Encoding.default_internal = Encoding::UTF_8
  end

  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
