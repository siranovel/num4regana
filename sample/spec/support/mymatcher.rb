require_relative('mylineregmatcher')
require_relative('myroundmatcher')
require_relative('myisarrmatcher')

RSpec.configure do |config|
  config.include MyLineRegMatcher
  config.include MyRoundMatcher
  config.include MyIsArrMatcher
end


