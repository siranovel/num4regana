require 'rspec'

Dir["./spec/support/**/*.rb"].each do |f|
    require f
end
RSpec.configure do |config|
  config.include MyLineRegMatcher
  config.include MyRoundMatcher
  config.include MyIsArrMatcher
  config.include MyIsHashMatcher
end

