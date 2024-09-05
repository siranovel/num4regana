require_relative('mylineregmatcher')
require_relative('myroundmatcher')

RSpec.configure do |config|
  config.include MyLineRegMatcher
  config.include MyRoundMatcher
end


