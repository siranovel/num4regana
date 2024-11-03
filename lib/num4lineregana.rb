require 'java'
require 'num4regana.jar'
require 'commons-math3-3.6.1.jar'

java_import 'SmplRegAna'
java_import 'MultRegAna'
# 線形回帰分析
#  (Apache commoms math3使用)
module Num4LineRegAnaLib
    # 単回帰分析
    class SmplRegAnaLib
        def initialize
            @regana = SmplRegAna.getInstance()
        end
        # 単回帰分析
        #
        # @overload line_reg_ana(yi, xi)
        #   @param [Array] yi yの値(double[])
        #   @param [Array] xi xの値(double[])
        #   @return [Hash] (intercept:定数項 slope:回帰係数)
        # @example
        #   yi = [286, 851, 589, 389, 158, 1037, 463, 563, 372, 1020]
        #   xi = [107, 336, 233,  82,  61,  378, 129, 313, 142,  428]
        #   regana = Num4RegAnaLib::SmplRegAnaLib.new
        #   regana.line_reg_ana(yi, xi)
        #   => 
        #     {
        #        "intercept":  99.075, # 定数項
        #        "slope":      2.145,  # 回帰係数
        #     }
        def line_reg_ana(yi, xi)
            ret = @regana.lineRegAna(yi.to_java(Java::double), xi.to_java(Java::double))
            retRb = {
                "intercept":  ret.getIntercept(), # 定数項
                "slope":      ret.getSlope(),     # 回帰係数
            }
            return retRb
        end
        # 決定係数
        #
        # @overload getr2(yi, xi)
        #   @param [Array] yi yの値(double[])
        #   @param [Array] xi xの値(double[])
        #   @return [double] 決定係数
        # @example
        #   yi = [286, 851, 589, 389, 158, 1037, 463, 563, 372, 1020]
        #   xi = [107, 336, 233,  82,  61,  378, 129, 313, 142,  428]
        #   regana = Num4RegAnaLib::SmplRegAnaLib.new
        #   regana.getr2(yi, xi)
        #   => 0.893
        def getr2(yi, xi)
            return @regana.getR2(yi.to_java(Java::double), xi.to_java(Java::double))
        end
        # 相関係数
        #
        # @overload getr(yi, xi)
        #   @param [Array] yi yの値(double[])
        #   @param [Array] xi xの値(double[])
        #   @return [double] 相関係数
        # @example
        #   yi = [286, 851, 589, 389, 158, 1037, 463, 563, 372, 1020]
        #   xi = [107, 336, 233,  82,  61,  378, 129, 313, 142,  428]
        #   regana = Num4RegAnaLib::SmplRegAnaLib.new
        #   regana.getr(yi, xi)
        #   => 0.945
        def getr(yi, xi)
            return @regana.getR(yi.to_java(Java::double), xi.to_java(Java::double))
        end
    end
    # 重回帰分析(最小２乗法:等分散性checkあり)
    class OLSMultRegAnaLib
        def initialize
            @multana = MultRegAna.getInstance()
        end
        # 重回帰分析
        #
        # @overload line_reg_ana(yi, xij)
        #   @param [Array] yi yの値(double[])
        #   @param [Array] xij xの値(double[][])
        #   @return [Hash] (intercept:定数項 slope:回帰係数)
        # @example
        #   olsyi = [45, 38, 41, 34, 59, 47, 35, 43, 54, 52]
        #   olsxij = [
        #       [17.5, 30],
        #       [17.0, 25],
        #       [18.5, 20],
        #       [16.0, 30],
        #       [19.0, 45],
        #       [19.5, 35],
        #       [16.0, 25],
        #       [18.0, 35],
        #       [19.0, 35],
        #       [19.5, 40],
        #   ]
        #   regana = Num4RegAnaLib::OLSMultRegAnaLib.new
        #   regana.line_reg_ana(olsyi, olsxij)
        #   => 
        #     {
        #        "intercept":  -34.71,           # 定数項
        #        "slope":      [3.47, 0.53],     # 回帰係数
        #     }
        def line_reg_ana(yi, xij)
            multRet = @multana.lineRegAna(yi.to_java(Java::double), xij.to_java(Java::double[]))

            retRb = {
                "intercept":  multRet.getIntercept(), # 定数項
                "slope":      multRet.getSlope().to_a,     # 回帰係数
            }
            return retRb
        end
        # 決定係数
        #
        # @overload getr2(yi, xij)
        #   @param [Array] yi yの値(double[])
        #   @param [Array] xij xの値(double[][])
        #   @return [double] 決定係数
        # @example
        #   olsyi = [45, 38, 41, 34, 59, 47, 35, 43, 54, 52]
        #   olsxij = [
        #       [17.5, 30],
        #       [17.0, 25],
        #       [18.5, 20],
        #       [16.0, 30],
        #       [19.0, 45],
        #       [19.5, 35],
        #       [16.0, 25],
        #       [18.0, 35],
        #       [19.0, 35],
        #       [19.5, 40],
        #   ]
        #   regana = Num4RegAnaLib::OLSMultRegAnaLib.new
        #   regana.getr2(olsyi, olsxij)
        #   => 0.858
        def getr2(yi, xij)
            return @multana.getR2(yi.to_java(Java::double), xij.to_java(Java::double[]))
        end
        # 自由度調整済み決定係数
        #
        # @overload getadjr2(yi, xij)
        #   @param [Array] yi yの値(double[])
        #   @param [Array] xij xの値(double[][])
        #   @return [double] 自由度調整済み決定係数
        # @example
        #   olsyi = [45, 38, 41, 34, 59, 47, 35, 43, 54, 52]
        #   olsxij = [
        #       [17.5, 30],
        #       [17.0, 25],
        #       [18.5, 20],
        #       [16.0, 30],
        #       [19.0, 45],
        #       [19.5, 35],
        #       [16.0, 25],
        #       [18.0, 35],
        #       [19.0, 35],
        #       [19.5, 40],
        #   ]
        #   regana = Num4RegAnaLib::OLSMultRegAnaLib.new
        #   regana.getadjr2(olsyi, olsxij)
        #   => 0.8176
        def getadjr2(yi, xij)
            return @multana.getAdjR2(yi.to_java(Java::double), xij.to_java(Java::double[]))
        end
        # VIF
        #
        # @overload getvif(xij)
        #   @param [Array] xij xの値(double[][])
        #   @return [double] VIF
        # @example
        #   olsxij = [
        #       [17.5, 30],
        #       [17.0, 25],
        #       [18.5, 20],
        #       [16.0, 30],
        #       [19.0, 45],
        #       [19.5, 35],
        #       [16.0, 25],
        #       [18.0, 35],
        #       [19.0, 35],
        #       [19.5, 40],
        #   ]
        #   regana = Num4RegAnaLib::OLSMultRegAnaLib.new
        #   regana.getvif(olsxij)
        #   => [1.5101, 1.5101]
        def getvif(xij)
            multRet = @multana.getVIF(xij.to_java(Java::double[]))
            return multRet.to_a
        end
        # AIC
        #
        # @overload getaic(yi, xij)
        #   @param [Array] yi yの値(double[])
        #   @param [Array] xij xの値(double[][])
        #   @return [double] AIC
        # @example
        #   olsyi = [45, 38, 41, 34, 59, 47, 35, 43, 54, 52]
        #   olsxij = [
        #       [17.5, 30],
        #       [17.0, 25],
        #       [18.5, 20],
        #       [16.0, 30],
        #       [19.0, 45],
        #       [19.5, 35],
        #       [16.0, 25],
        #       [18.0, 35],
        #       [19.0, 35],
        #       [19.5, 40],
        #   ]
        #   regana = Num4RegAnaLib::OLSMultRegAnaLib.new
        #   regana.getaic(olsyi, olsxij)
        #   => 58.113
        def getaic(yi, xij)
            return @multana.getAIC(yi.to_java(Java::double), xij.to_java(Java::double[]))
        end
    end
end

