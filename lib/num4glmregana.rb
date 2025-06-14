require 'java'
require 'num4regana.jar'
require 'commons-math3-3.6.1.jar'

java_import 'LogitRegAna'
java_import 'PoissonRegAna'
java_import 'ProBitRegAna'
java_import 'java.util.HashMap'

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
        #   glsyi = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        #   glsxij = [
        #        [1, 24],
        #        [1, 18],
        #        [0, 15],
        #        [1, 16],
        #        [0, 10],
        #        [1, 26],
        #        [1, 2],
        #        [0, 24],
        #        [1, 18],
        #        [1, 22],
        #        [1, 3],
        #        [1, 6],
        #        [0, 15],
        #        [0, 12],
        #        [1, 6],
        #        [0, 6],
        #        [1, 12],
        #        [0, 12],
        #        [1, 18],
        #        [1, 3],
        #        [1, 8],
        #        [0, 9],
        #        [0, 12],
        #        [0, 6],
        #        [0, 8],
        #        [1, 12],
        #   ]
        #   regana = Num4RegAnaLib::LogitRegAnaLib.new
        #   regana.non_line_reg_ana(glsyi, glsxij)
        #   => 
        #     {
        #        "intercept":  -6.2313,              # 定数項
        #        "slope":      [2.5995, 0.1652],     # 回帰係数
        #     }
        def non_line_reg_ana(yi, xij)
            multRet = @multana.nonLineRegAna(yi.to_java(Java::double), xij.to_java(Java::double[]))
            retRb = {
                "intercept":  multRet.getIntercept(), # 定数項
                "slope":      multRet.getSlope().to_a,     # 回帰係数
            }
            return retRb
        end
        # AIC
        #
        # @overload get_aic(regcoe, xij)
        #   @param [Hash] regcoe 回帰係数(intercept:定数項 slope:回帰係数)
        #   @param [Array] xij xの値(double[][])
        #   @return double AIC値
        # @example
        #   reg = {
        #        :intercept=>  -6.2313,    # 定数項
        #        :slope=>      [2.5995, 0.1652],     # 回帰係数
        #   }
        #   xij = [
        #        [1, 24],
        #        [1, 18],
        #        [0, 15],
        #        [1, 16],
        #        [0, 10],
        #        [1, 26],
        #        [1, 2],
        #        [0, 24],
        #        [1, 18],
        #        [1, 22],
        #        [1, 3],
        #        [1, 6],
        #        [0, 15],
        #        [0, 12],
        #        [1, 6],
        #        [0, 6],
        #        [1, 12],
        #        [0, 12],
        #        [1, 18],
        #        [1, 3],
        #        [1, 8],
        #        [0, 9],
        #        [0, 12],
        #        [0, 6],
        #        [0, 8],
        #        [1, 12],
        #   ]
        #   regana = Num4RegAnaLib::LogitRegAnaLib.new
        #   regana.get_aic(reg, xij)
        #   => 155.612
        def get_aic(regcoe, xij)
            o = HashMap.new
            o["intercept"] = regcoe[:intercept]
            o["slope"]     = regcoe[:slope].to_java(Java::double)
            @multana.getAIC(o, xij.to_java(Java::double[]))
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
                "slope":     multRet.getSlope().to_a,     # 回帰係数
            }
            return retRb
        end
        # AIC(赤池の情報基準)
        #
        # @overload get_aic(regcoe, xij)
        #   @param [Hash] regcoe 回帰係数(intercept:定数項 slope:回帰係数)
        #   @param [Array] xij xの値(double[][])
        #   @return double AIC値
        # @example
        #   reg = {
        #        :intercept => 1.3138,    # 定数項
        #        :slope    =>  [0.3173],  # 回帰係数
        #   }
        #   xij = [
        #       [1],
        #       [2],
        #       [3],
        #       [4],
        #   ]
        #   regana = Num4RegAnaLib::PoissonRegAnaLib.new
        #   regana.get_aic(reg, xij)
        #   => -12.856
        def get_aic(regcoe, xij)
            o = HashMap.new
            o["intercept"] = regcoe[:intercept]
            o["slope"]     = regcoe[:slope].to_java(Java::double)
            @multana.getAIC(o, xij.to_java(Java::double[]))
        end
    end
    # プロビット回帰分析
    class ProBitRegAnaLib
        def initialize
            @multana = ProBitRegAna.getInstance()
        end
        # プロビット回帰分析
        #
        # @overload non_line_reg_ana(yi, xij)
        #   @param [Array] yi yの値(double[])
        #   @param [Array] xij xの値(double[][])
        #   @return [Hash] (intercept:定数項 slope:回帰係数)
        # @example
        #   glsyi = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        #   glsxij = [
        #        [1, 24],
        #        [1, 18],
        #        [0, 15],
        #        [1, 16],
        #        [0, 10],
        #        [1, 26],
        #        [1, 2],
        #        [0, 24],
        #        [1, 18],
        #        [1, 22],
        #        [1, 3],
        #        [1, 6],
        #        [0, 15],
        #        [0, 12],
        #        [1, 6],
        #        [0, 6],
        #        [1, 12],
        #        [0, 12],
        #        [1, 18],
        #        [1, 3],
        #        [1, 8],
        #        [0, 9],
        #        [0, 12],
        #        [0, 6],
        #        [0, 8],
        #        [1, 12],
        #   ]
        #   regana = Num4RegAnaLib::ProBitRegAnaLib.new
        #   regana.non_line_reg_ana(glsyi, glsxij)
        #   => 
        #     {
        #        "intercept":  -5.0497,    # 定数項
        #        "slope":      [2.2379, 0.2973],     # 回帰係数
        #     }
        def non_line_reg_ana(yi, xij)
            multRet = @multana.nonLineRegAna(yi.to_java(Java::double), xij.to_java(Java::double[]))
            retRb = {
                "intercept":  multRet.getIntercept(), # 定数項
                "slope":      multRet.getSlope().to_a,     # 回帰係数
            }
            return retRb
        end
        # AIC(赤池の情報基準)
        #
        # @overload get_aic(regcoe, xij)
        #   @param [Hash] regcoe 回帰係数(intercept:定数項 slope:回帰係数)
        #   @param [Array] xij xの値(double[][])
        #   @return double AIC値
        # @example
        #   reg = {
        #        :intercept=>  -5.0497,    # 定数項
        #        :slope=>      [2.2379, 0.2973],     # 回帰係数
        #   }
        #   xij = [
        #        [1, 24],
        #        [1, 18],
        #        [0, 15],
        #        [1, 16],
        #        [0, 10],
        #        [1, 26],
        #        [1, 2],
        #        [0, 24],
        #        [1, 18],
        #        [1, 22],
        #        [1, 3],
        #        [1, 6],
        #        [0, 15],
        #        [0, 12],
        #        [1, 6],
        #        [0, 6],
        #        [1, 12],
        #        [0, 12],
        #        [1, 18],
        #        [1, 3],
        #        [1, 8],
        #        [0, 9],
        #        [0, 12],
        #        [0, 6],
        #        [0, 8],
        #        [1, 12],
        #   ]
        #   regana = Num4RegAnaLib::ProBitRegAnaLib.new
        #   regana.get_aic(reg, xij)
        #   => 119.674
        def get_aic(regcoe, xij)
            o = HashMap.new
            o["intercept"] = regcoe[:intercept]
            o["slope"]     = regcoe[:slope].to_java(Java::double)
            @multana.getAIC(o, xij.to_java(Java::double[]))
        end
    end
end



