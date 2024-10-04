require 'java'
require 'num4regana.jar'
require 'commons-math3-3.6.1.jar'

java_import 'PoissonHierBayesRegAna'
# 階層ベイズモデル
#  (Apache commoms math3使用)
module Num4HBMRegAnaLib
    # 階層ベイズポアソン回帰分析
    class PoissonHierBayesRegAnaLib
        def initialize
            @multana = PoissonHierBayesRegAna.getInstance()
        end
        # ポアソン回帰分析
        #
        # @overload non_line_reg_ana(yi, xij)
        #   @param [Array] yi yの値(double[])
        #   @param [Array] xij xの値(double[][])
        #   @return [Hash] (intercept:定数項 slope:回帰係数)
        # @example
        #   glsyi = [4, 10, 7, 14]
        #   glsxij = [
        #       [1],
        #       [2],
        #       [3],
        #       [4],
        #   ]
        #   regana = Num4RegAnaLib::HierBayesPoissonRegAnaLib.new
        #   regana.non_line_reg_ana(glsyi, glsxij)
        #   => 
        #     {
        #        "intercept":  0.477366,    # 定数項
        #        "slope":      [0.538545],  # 回帰係数
        #     }
        def non_line_reg_ana(yi, xij)
            multRet = @multana.nonLineRegAna(yi.to_java(Java::double), xij.to_java(Java::double[]))
            retRb = {
                "intercept":  multRet.getIntercept(), # 定数項
                "slope":      multRet.getSlope().to_a,     # 回帰係数
            }
            return retRb
        end
    end
end

