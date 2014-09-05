require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

ENV['RAILS_ENV'] = 'test'
require File.expand_path('../../config/environment', __FILE__)

require 'shoulda/matchers'
require 'rspec/rails'

RSpec.configure do |config|
  config.infer_spec_type_from_file_location!
  config.include FactoryGirl::Syntax::Methods
  config.filter_run_excluding off: true
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before :each do DatabaseCleaner.start end
  config.after do DatabaseCleaner.clean end
  
  config.fail_fast = false
  config.order = :random
  config.color = true
end