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
                "intercept":  0.4774,    # 定数項
                "slope":      [0.5385],  # 回帰係数
            }
            regana.non_line_reg_ana(yi, xij)
        end
    end
end

