require 'java'
require 'num4regana.jar'
require 'commons-math3-3.6.1.jar'

java_import 'LogitBayesRegAna'
java_import 'PoissonBayesRegAna'
java_import 'java.util.HashMap'

# 一般化線形混合モデル
#  (Apache commoms math3使用)
module Num4GLMMRegAnaLib
    # (2項)ベイズロジスティック回帰分析
    class LogitBayesRegAnaLib
        def initialize
            @multana = LogitBayesRegAna.getInstance()
        end
        # (2項)ベイズロジスティック回帰分析
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
        #   regana = Num4GLMMRegAnaLib::LogitBayesRegAnaLib.new
        #   regana.non_line_reg_ana(glsyi, glsxij)
        #   => 
        #     {  
        #        :intercept=>0.5742886218005325,      # 定数項
        #                                             # 回帰係数
        #        :slope=>[0.5517212822536828, 0.5748054561700319]
        #     }
        def non_line_reg_ana(yi, xij)
            multRet = @multana.nonLineRegAna(yi.to_java(Java::double), xij.to_java(Java::double[]))
            retRb = {
                "intercept":  multRet.getIntercept(), # 定数項
                "slope":      multRet.getSlope().to_a,     # 回帰係数
            }
            return retRb
        end
        # BIC
        #
        # @overload get_bic(regcoe, xij)
        #   @param [Hash] regcoe 回帰係数(intercept:定数項 slope:回帰係数)
        #   @param [Array] xij xの値(double[][])
        #   @return double BIC値
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
        #   regana = Num4GLMMRegAnaLib::LogitBayesRegAnaLib.new
        #   regana.get_bic(reg, xij)
        #   => 159.386
        def get_bic(regcoe, xij)
            o = HashMap.new
            o["intercept"] = regcoe[:intercept]
            o["slope"]     = regcoe[:slope].to_java(Java::double)
            @multana.getBIC(o, xij.to_java(Java::double[]))
        end
    end
    # ベイズポアソン回帰分析
    class PoissonBayesRegAnaLib
        def initialize
            @multana = PoissonBayesRegAna.getInstance()
        end
        # ベイズポアソン回帰分析
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
        #   regana = Num4GLMMRegAnaLib::PoissonBayesRegAnaLib.new
        #   regana.non_line_reg_ana(glsyi, glsxij)
        #   => 
        #     {
        #        :intercept=>0.4341885635221602, # 定数項
        #        :slope=>[0.5703137378188881]    # 回帰係数
        #     }
        def non_line_reg_ana(yi, xij)
            multRet = @multana.nonLineRegAna(yi.to_java(Java::double), xij.to_java(Java::double[]))
            retRb = {
                "intercept":  multRet.getIntercept(), # 定数項
                "slope":      multRet.getSlope().to_a,     # 回帰係数
            }
            return retRb
        end
        # BIC
        #
        # @overload get_bic(regcoe, xij)
        #   @param [Hash] regcoe 回帰係数(intercept:定数項 slope:回帰係数)
        #   @param [Array] xij xの値(double[][])
        #   @return double BIC値
        # @example
        #   reg = {
        #        :intercept=>0.4341885635221602, # 定数項
        #        :slope=>[0.5703137378188881]    # 回帰係数
        #   }
        #   xij = [
        #       [1],
        #       [2],
        #       [3],
        #       [4],
        #   ]
        #   regana = Num4GLMMRegAnaLib::BayesPoissonRegAnaLib.new
        #   regana.get_bic(reg, xij)
        #   => -13.157
        def get_bic(regcoe, xij)
            o = HashMap.new
            o["intercept"] = regcoe[:intercept]
            o["slope"]     = regcoe[:slope].to_java(Java::double)
            @multana.getBIC(o, xij.to_java(Java::double[]))
        end
    end
end

