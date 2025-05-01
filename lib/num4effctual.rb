require 'java'
require 'num4regana.jar'
require 'commons-math3-3.6.1.jar'

java_import 'Effectual'

# 効果検証
module Num4EffectualLib
    # 無作為化比較試験(RCT:Randomized Controlled Trial)
    class RCTLib
        def initialize
            @effect = Effectual.getInstance()
        end
        def smple_line_reg_ana(yi, xi)
            regana = Num4LineRegAnaLib::SmplRegAnaLib.new
            ret = regana.line_reg_ana(yi, xi)
            return ret[:slope]
        end
    end
end

