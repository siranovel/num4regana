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
        #
        # @overload smple_line_reg_ana(yi, xi)
        #   @param [Array] yi 目的変数(double[])
        #   @param [Array] zi 介入変数(double[])
        #   @return [double] 効果量
        # @example
        #   yi = [300, 600, 500, 400, 300, 500, 600, 400, 500, 300]
        #   zi = [  0,   1,   0,   1,   0,   0,   1,   1,   0,   0]  
        #   regana = Num4RegAnaLib::RCTLib.new
        #   regana.smple_line_reg_ana(yi, zi)
        #   => 100.0
        def smple_line_reg_ana(yi, xi)
            regana = Num4LineRegAnaLib::SmplRegAnaLib.new
            ret = regana.line_reg_ana(yi, xi)
            return ret[:slope]
        end
        # 傾向スコアによる効果推定
        #   逆確率重み付け推定(IPW)
        #
        # @overload ipw(yi, xij, zi)
        #   @param [Array] yi 目的変数(double[])
        #   @param [Array] xij 共変量変数(double[][])
        #   @param [Array] zi 介入変数(double[])
        def ipw(yi, xij, zi)
            return @effect.ipw(yi.to_java(Java::double), xij.to_java(Java::double[]), zi.to_java(Java::double))
        end
    end
end

