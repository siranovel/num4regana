require_relative('num4lineregana')
require_relative('num4glmregana')
require_relative('num4glmmregana')
require_relative('num4hbmregana')

# 回帰分析
module Num4RegAnaLib
    include Num4LineRegAnaLib
    include Num4GLMRegAnaLib
    include Num4GLMMRegAnaLib
    include Num4HBMRegAnaLib
end


