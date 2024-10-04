require 'spec_helper'
require 'num4regana'

RSpec.describe Num4RegAnaLib do
    describe Num4RegAnaLib::PoissonHierBayesRegAnaLib do
        let!(:regana) { Num4RegAnaLib::PoissonHierBayesRegAnaLib.new }
        it '#non_line_reg_ana' do
            yi = [4, 10, 7, 14]
            xij = [
                [1],
                [2],
                [3],
                [4],
            ]
            res = {
                "intercept":  -11.7452,    # 定数項
                "slope":      [-23.6337],  # 回帰係数
            }
            expect(
                regana.non_line_reg_ana(yi, xij)
            ).to linereg(res, 4)
        end
    end
end

