require 'spec_helper'
require 'num4regana'
require 'effectdat'

RSpec.describe Num4RegAnaLib do
    before(:all) do
        @bias_t = EffectDatPS.new
        @rdd_dt = EffectDatRDD.new
    end
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
        it '#psm' do
            yi = @bias_t.yi
            xij = @bias_t.xij
            zi = @bias_t.zi
            expect(
                regana.psm(yi, xij, zi)
            ).to my_round(2.8, 1)
        end
        it '#ipw' do
            yi = @bias_t.yi
            xij = @bias_t.xij
            zi = @bias_t.zi
            expect(
                regana.ipw(yi, xij, zi)
            ).to my_round(5.6, 1)
        end
        it '#did' do
            yi = [2261, 2458, 3904,2547]
            ti = [0, 1, 0, 1]
            zi = [0, 0, 1, 1]
            expect(
                regana.did(yi, ti, zi)
            ).to my_round(-1554.0, 1)
        end
        it '#rdd' do
            yi = @rdd_dt.yi
            xi = @rdd_dt.xi
            zi = @rdd_dt.zi
            expect(
                regana.rdd(yi, xi, zi)
            ).to my_round(0.114, 3)
        end
    end
end
