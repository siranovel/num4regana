require 'java'
require 'num4regana.jar'
require 'commons-math3-3.6.1.jar'

java_import 'LogitRegAna'
java_import 'PoissonRegAna'

# 一般化線形回帰分析
#  (Apache commoms math3使用)
module Num4GLMRegAnaLib
    # (2項)ロジスティック回帰分析
    class LogitRegAnaLib
        def initialize
            @multana = LogitRegAna.getInstance()
        end
        # (2項)ロジスティック回帰分析
        #
        # @overload non_line_reg_ana(yi, xij)
        #   @param [Array] yi yの値(double[])
        #   @param [Array] xij xの値(double[][])
        #   @return [Hash] (intercept:定数項 slope:回帰係数)
        # @example
        #   glsyi = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        #   glsxij = [
        #       [95],
        #       [90],
        #       [85],
        #       [80],
        #       [80],
        #       [75],
        #       [70],
        #       [70],
        #       [65],
        #       [50],
        #       [60],
        #       [55],
        #       [45],
        #       [65],
        #       [40],
        #       [35],
        #       [55],
        #       [50],
        #       [50],
        #       [45],
        #   ]
        #   regana = Num4RegAnaLib::LogitRegAnaLib.new
        #   regana.non_line_reg_ana(glsyi, glsxij)
        #   => 
        #     {
        #       "intercept":  -17.81,    # 定数項
        #       "slope":      [0.16],    # 回帰係数
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
    # ポアソン回帰分析
    class PoissonRegAnaLib
        def initialize
            @multana = PoissonRegAna.getInstance()
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
        #   regana = Num4RegAnaLib::PoissonRegAnaLib.new
        #   regana.non_line_reg_ana(glsyi, glsxij)
        #   => 
        #     {
        #        "intercept":  1.3138,    # 定数項
        #        "slope":      [0.3173],  # 回帰係数
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



