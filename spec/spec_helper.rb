require_relative '../lib/hipbot'

RSpec.configure do |config|
  config.mock_with :mocha
end

Hipbot.logger.level = Logger::FATAL
