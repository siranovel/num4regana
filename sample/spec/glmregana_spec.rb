require 'spec_helper'
require 'num4regana'

RSpec.describe Num4RegAnaLib do
    describe Num4RegAnaLib::LogitRegAnaLib do
        let!(:regana) { Num4RegAnaLib::LogitRegAnaLib.new }
        before(:all) do
            @yi = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
            @xij = [
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
        end
        it '#non_line_reg_ana' do
            res = {
                "intercept":  -6.2313,    # 定数項
                "slope":      [2.5995, 0.1652],     # 回帰係数
            }
            expect(
                regana.non_line_reg_ana(@yi, @xij)
            ).to is_linereg(res, 4)
        end
        it '#get_aic' do
            reg = {
                :intercept=>  -6.2313,    # 定数項
                :slope=>      [2.5995, 0.1652],     # 回帰係数
            }
            expect(
                regana.get_aic(reg, @xij)
            ).to my_round(155.612, 3)
        end
        it '#validity' do
            reg = {
                :intercept=>  -6.2313,    # 定数項
                :slope=>      [2.5995, 0.1652],     # 回帰係数
            }
            res = {
                "accuracy": 0.636,     # 精度・正確度
                "precision": 1.000,    # 適合度
                "recall": 0.273,       # 再現率
                "sensitivity": 0.273,  # 感度
                "specificity": 1.000,  # 特異度
                "ppv": 1.000,          # 陽性適敵中率
                "npv": 0.579,          # 陽性適中率
                "tpr": 0.273,          # 真陽性率
                "fpr": 0.000,          # 偽陽性率
                "tnr": 1.000,          # 真陰性率
                "fnr": 0.727         # 偽陰性率
            }
            expect(
                regana.validity(@yi, reg, @xij, 0.5)
            ).to is_hash(res, 3)
        end
    end
    describe Num4RegAnaLib::PoissonRegAnaLib do
        let!(:regana) { Num4RegAnaLib::PoissonRegAnaLib.new }
        before(:all) do
            @yi = [4, 10, 7, 14]
            @xij = [
                [1],
                [2],
                [3],
                [4],
            ]
        end
        it '#non_line_reg_ana' do
            res = {
                "intercept":  1.3138,    # 定数項
                "slope":      [0.3173],  # 回帰係数
            }
            expect(
                regana.non_line_reg_ana(@yi, @xij)
            ).to is_linereg(res, 4)
        end
        it '#get_aic' do
            reg = {
                :intercept => 1.3138,    # 定数項
                :slope    =>  [0.3173],  # 回帰係数
            }
            expect(
                regana.get_aic(reg, @xij)
            ).to my_round(-12.856, 3)
        end
    end
    describe Num4RegAnaLib::ProBitRegAnaLib do
        let!(:regana) { Num4RegAnaLib::ProBitRegAnaLib.new }
        before(:all) do
            @yi = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
            @xij = [
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
        end

        it '#non_line_reg_ana' do
            res = {
                "intercept":  -5.0497,    # 定数項
                "slope":      [2.2379, 0.2973],     # 回帰係数
            }
            expect(
                regana.non_line_reg_ana(@yi, @xij)
            ).to is_linereg(res, 4)
        end
        it '#get_aic' do
            reg = {
                :intercept=>  -5.0497,    # 定数項
                :slope=>      [2.2379, 0.2973],     # 回帰係数
            }
            expect(
                regana.get_aic(reg, @xij)
            ).to my_round(119.674, 3)
        end
        it '#validity' do
            reg = {
                :intercept=>  -5.0497,    # 定数項
                :slope=>      [2.2379, 0.2973],     # 回帰係数
            }
            res = {
                "accuracy": 0.718,   # 精度・正確度
                "precision": 0.761,  # 適合度
                "recall": 0.636,     # 再現率
                "sensitivity": 0.636,# 感度
                "specificity": 0.800,# 特異度
                "ppv": 0.761,        # 陽性適敵中率
                "npv": 0.688,        # 陽性適中率
                "tpr": 0.636,        # 真陽性率
                "fpr": 0.200,        # 偽陽性率
                "tnr": 0.800,        # 真陰性率
                "fnr": 0.364,        # 偽陰性率
            }
            expect(
                regana.validity(@yi, reg, @xij, 0.5)
            ).to is_hash(res, 3)
        end
    end
end

