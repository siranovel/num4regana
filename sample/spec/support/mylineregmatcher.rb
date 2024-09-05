module MyLineRegMatcher
  class Matcher
    def initialize(expected, n)
      @expected = expected
      @n = n
    end
    def matches?(actual)
        ret = true
        @actual = actual
        act_intercept = actual[:intercept]
        act_slope = actual[:slope]

        if (act_intercept.round(@n) != @expected[:intercept]) then
            ret = false
        end
        if act_slope.kind_of?(Array) == true then
            act_slope.size.times{|i|
                if act_slope[i].round(@n) != @expected[:slope][i] then
                    ret = false
                end
            }
        else
            if  act_slope.round(@n) != @expected[:slope] then
                ret = false
            end
        end
        return ret
    end
    def failure_message
      "#{@expected} expected but got #{@actual}"
    end
  end
  def linereg(expected, n)
    Matcher.new(expected, n)
  end
end

