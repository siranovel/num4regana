require 'spec_helper'
require 'num4regana'

RSpec.describe Num4RegAnaLib do
    describe Num4RegAnaLib::LogitRegAnaLib do
        let!(:regana) { Num4RegAnaLib::LogitRegAnaLib.new }
        it '#non_line_reg_ana' do
            yi = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
            xij = [
                [95],
                [90],
                [85],
                [80],
                [80],
                [75],
                [70],
                [70],
                [65],
                [50],
                [60],
                [55],
                [45],
                [65],
                [40],
                [35],
                [55],
                [50],
                [50],
                [45],
            ]
            res = {
                "intercept":  -17.81,    # 定数項
                "slope":      [0.16],     # 回帰係数
            }
            expect(
                regana.non_line_reg_ana(yi, xij)
            ).to linereg(res, 2)
        end
    end
    describe Num4RegAnaLib::PoissonRegAnaLib do
        let!(:regana) { Num4RegAnaLib::PoissonRegAnaLib.new }
        it '#non_line_reg_ana' do
            yi = [4, 10, 7, 14]
            xij = [
                [1],
                [2],
                [3],
                [4],
            ]
            res = {
                "intercept":  1.3138,    # 定数項
                "slope":      [0.3173],  # 回帰係数
            }
            expect(
                regana.non_line_reg_ana(yi, xij)
            ).to linereg(res, 4)
        end
    end
end

