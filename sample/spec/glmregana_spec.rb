require 'spec_helper'
require 'num4regana'

RSpec.describe Num4RegAnaLib do
    describe Num4RegAnaLib::LogitRegAnaLib do
        let!(:regana) { Num4RegAnaLib::LogitRegAnaLib.new }
        it '#non_line_reg_ana' do
            yi = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
            xij = [
                [1, 24],
                [1, 18],
                [0, 15],
                [1, 16],
                [0, 10],
                [1, 26],
                [1, 2],
                [0, 24],
                [1, 18],
                [1, 22],
                [1, 3],
                [1, 6],
                [0, 15],
                [0, 12],
                [1, 6],
                [0, 6],
                [1, 12],
                [0, 12],
                [1, 18],
                [1, 3],
                [1, 8],
                [0, 9],
                [0, 12],
                [0, 6],
                [0, 8],
                [1, 12],
            ]
            res = {
                "intercept":  -6.2313,    # 定数項
                "slope":      [2.5995, 0.1652],     # 回帰係数
            }
            expect(
                regana.non_line_reg_ana(yi, xij)
            ).to linereg(res, 4)
        end
        it '#get_aic' do
            reg = {
                :intercept=>  -6.2313,    # 定数項
                :slope=>      [2.5995, 0.1652],     # 回帰係数
            }
            xij = [
                [1, 24],
                [1, 18],
                [0, 15],
                [1, 16],
                [0, 10],
                [1, 26],
                [1, 2],
                [0, 24],
                [1, 18],
                [1, 22],
                [1, 3],
                [1, 6],
                [0, 15],
                [0, 12],
                [1, 6],
                [0, 6],
                [1, 12],
                [0, 12],
                [1, 18],
                [1, 3],
                [1, 8],
                [0, 9],
                [0, 12],
                [0, 6],
                [0, 8],
                [1, 12],
            ]
            expect(
                regana.get_aic(reg, xij)
            ).to my_round(155.612, 3)

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
        it '#get_aic' do
            reg = {
                :intercept => 1.3138,    # 定数項
                :slope    =>  [0.3173],  # 回帰係数
            }
            xij = [
                [1],
                [2],
                [3],
                [4],
            ]
            expect(
                regana.get_aic(reg, xij)
            ).to my_round(-12.856, 3)

        end
    end
    describe Num4RegAnaLib::ProBitRegAnaLib do
        let!(:regana) { Num4RegAnaLib::ProBitRegAnaLib.new }
        it '#non_line_reg_ana' do
            yi = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
            xij = [
                [1, 24],
                [1, 18],
                [0, 15],
                [1, 16],
                [0, 10],
                [1, 26],
                [1, 2],
                [0, 24],
                [1, 18],
                [1, 22],
                [1, 3],
                [1, 6],
                [0, 15],
                [0, 12],
                [1, 6],
                [0, 6],
                [1, 12],
                [0, 12],
                [1, 18],
                [1, 3],
                [1, 8],
                [0, 9],
                [0, 12],
                [0, 6],
                [0, 8],
                [1, 12],
            ]
            res = {
                "intercept":  -5.0497,    # 定数項
                "slope":      [2.2379, 0.2973],     # 回帰係数
            }
            expect(
                regana.non_line_reg_ana(yi, xij)
            ).to linereg(res, 4)
        end
        it '#get_aic' do
            reg = {
                :intercept=>  -5.0497,    # 定数項
                :slope=>      [2.2379, 0.2973],     # 回帰係数
            }
            xij = [
                [1, 24],
                [1, 18],
                [0, 15],
                [1, 16],
                [0, 10],
                [1, 26],
                [1, 2],
                [0, 24],
                [1, 18],
                [1, 22],
                [1, 3],
                [1, 6],
                [0, 15],
                [0, 12],
                [1, 6],
                [0, 6],
                [1, 12],
                [0, 12],
                [1, 18],
                [1, 3],
                [1, 8],
                [0, 9],
                [0, 12],
                [0, 6],
                [0, 8],
                [1, 12],
            ]
            expect(
                regana.get_aic(reg, xij)
            ).to my_round(119.674, 3)
        end
    end
end

