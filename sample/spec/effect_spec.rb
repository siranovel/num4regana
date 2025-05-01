require 'spec_helper'
require 'num4regana'

RSpec.describe Num4RegAnaLib do
    describe Num4RegAnaLib::RCTLib do
        let!(:regana) { Num4RegAnaLib::RCTLib.new }
        it '#smple_line_reg_ana 1' do
            yi = [300, 600, 600, 300, 300, 600, 600, 300, 600, 300]
            zi = [  0,   1,   1,   0,   0,   1,   1,   0,   1,   0]  
             expect(
                regana.smple_line_reg_ana(yi, zi)
            ).to my_round(300.0, 1)
        end
        it '#smple_line_reg_ana 2' do
            yi = [300, 600, 500, 400, 300, 500, 600, 400, 500, 300]
            zi = [  0,   1,   0,   1,   0,   0,   1,   1,   0,   0]  
            expect(
                regana.smple_line_reg_ana(yi, zi)
            ).to my_round(100.0, 1)
        end
    end
end
