# 小数点桁四捨五入
module MyRoundMatcher
  class Matcher
    def initialize(expected, n)
      @expected = expected
      @n = n
    end

    def matches?(actual)
      @actual = actual.round(@n)
      @actual == @expected
    end

    def failure_message
      "#{@expected} expected but got #{@actual}"
    end
  end
  def my_round(expected, n)
    Matcher.new(expected, n)
  end
end

