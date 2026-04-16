require 'spec_helper'
require 'num4regana'

RSpec.describe Num4RegAnaLib do
    # 数量化Ⅰ類
    describe Num4RegAnaLib::OLSMultRegAnaLib do
        let!(:regana) { Num4RegAnaLib::OLSMultRegAnaLib.new }
        it '#line_reg_ana 1' do
            olsyi = [57, 65, 51, 54, 45, 67]
            dmyxi = [
                [0, 1],
                [0, 0],
                [1, 0],
                [0, 0],
                [1, 0],
                [0, 1]
            ]
            res = {
                "intercept":  59.5,    # 定数項
                "slope":      [-11.5, 2.5],     # 回帰係数
            }
            expect(
                regana.line_reg_ana(olsyi, dmyxi)
            ).to is_linereg(res, 1)
        end
        it '#line_reg_ana 2' do
            olsyi = [79,82,86,78,90,
                     83,75,81,73,82,
                     80,88,81,85,78,
                     82,84,82,80]
            dmyxi = [
                [0,2,0,0,0],[0,2,0,1,1],[1,1,0,0,1],[1,0,1,0,1],[0,1,0,1,2],
                [1,1,0,0,1],[0,2,0,0,1],[0,0,1,0,1],[0,2,0,0,0],[1,0,0,0,1],
                [0,2,0,0,1],[0,1,0,0,1],[0,0,0,0,1],[1,2,0,1,0],[0,0,1,0,0],
                [0,1,0,1,1],[1,0,0,0,1],[1,1,0,0,1],[0,0,0,0,0]
            ]
            res = {
                "intercept":  80.089,    # 定数項
                "slope":      [1.572, -1.649,-3.380,4.090,2.651],     # 回帰係数
            }
            expect(
                regana.line_reg_ana(olsyi, dmyxi)
            ).to is_linereg(res, 3)
        end        
    end
end

