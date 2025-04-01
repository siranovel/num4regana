require 'spec_helper'
require 'num4regana'

RSpec.describe Num4RegAnaLib do
    describe Num4RegAnaLib::SmplRegAnaLib do
        let!(:regana) { Num4RegAnaLib::SmplRegAnaLib.new }
        it '#rct 1' do
            yi = [300, 600, 500, 400, 300, 500, 600, 400, 500, 300]
            zi = [  0,   1,   0,   1,   0,   0,   1,   1,   0,   0]  
            res = {
                "intercept": 400.0,
                "slope":     100.0
            }
            expect(
                regana.line_reg_ana(yi, zi)
            ).to linereg(res, 1)
        end
        it '#rct 2' do
            yi = [300, 600, 600, 300, 300, 600, 600, 300, 600, 300]
            zi = [  0,   1,   1,   0,   0,   1,   1,   0,   1,   0]  
            res = {
                "intercept": 300.0,
                "slope":     300.0
            }
            expect(
                regana.line_reg_ana(yi, zi)
            ).to linereg(res, 1)
        end
    end
end
