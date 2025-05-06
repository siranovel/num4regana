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
        # 単回帰による効果推定
        def smple_line_reg_ana(yi, xi)
            regana = Num4LineRegAnaLib::SmplRegAnaLib.new
            ret = regana.line_reg_ana(yi, xi)
            return ret[:slope]
        end
        # 傾向スコアによる効果推定
        #   傾向スコアマッチング(PSM)
#        def psm
#        end
        #   逆確率重み付け推定(IPW)
        def ipw(yi, xij, zi)
            return @effect.ipw(yi.to_java(Java::double), xij.to_java(Java::double[]), zi.to_java(Java::double))
        end
    end
end

