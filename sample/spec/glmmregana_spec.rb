require 'spec_helper'
require 'num4regana'

RSpec.describe Num4RegAnaLib do
    describe Num4RegAnaLib::LogitBayesRegAnaLib do
        let!(:regana) { Num4RegAnaLib::LogitBayesRegAnaLib.new }
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
                "intercept":  0.4804,    # 定数項
                "slope":      [0.5669, 0.5422],     # 回帰係数
            }
            regana.non_line_reg_ana(yi, xij)
#            expect(
#                regana.non_line_reg_ana(yi, xij)
#            ).to linereg(res, 4)
# {:intercept=>0.5742886218005325, :slope=>[0.5517212822536828, 0.5748054561700319]}
# {:intercept=>0.44426881466394974, :slope=>[0.5202123495676625, 0.5477244196524941]}
# {:intercept=>0.4217903552231481, :slope=>[0.44186307024347676, 0.4862701919881903]}
        end
        it '#get_bic' do
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
                regana.get_bic(reg, xij)
#            expect(
#                regana.get_bic(reg, xij)
#            ).to my_round(159.386, 3)
        end
    end    
    describe Num4RegAnaLib::PoissonBayesRegAnaLib do
        let!(:regana) { Num4RegAnaLib::PoissonBayesRegAnaLib.new }
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
            regana.non_line_reg_ana(yi, xij)
#            expect(
#                regana.non_line_reg_ana(yi, xij)
#            ).to linereg(res, 4)
# {:intercept=>0.4341885635221602, :slope=>[0.5703137378188881]}
# {:intercept=>0.5233791563571913, :slope=>[0.4629854978645746]}
# {:intercept=>0.5367747588576945, :slope=>[0.5375546954530761]}
# {:intercept=>0.47904156491260963, :slope=>[0.5388200495317951]}
        end
        it '#get_bic' do
            reg = {
                :intercept => 0.504607,    # 定数項
                :slope    =>  [0.594661],  # 回帰係数
            }
            xij = [
                [1],
                [2],
                [3],
                [4],
            ]
                regana.get_bic(reg, xij)
#            expect(
#                regana.get_bic(reg, xij)
#            ).to my_round(-13.157, 3)
        end
    end
end

