require 'spec_helper'
require 'num4regana'
require 'effectdat'

RSpec.describe Num4RegAnaLib do
    before(:all) do
        @bias_dt = EffectDatPS.new
        @did_dt = EffectDatDID.new
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
            yi = @bias_dt.yi
            xij = @bias_dt.xij
            zi = @bias_dt.zi
            expect(
                regana.psm(yi, xij, zi)
            ).to my_round(2.8, 1)
        end
        it '#ipw' do
            yi = @bias_dt.yi
            xij = @bias_dt.xij
            zi = @bias_dt.zi
            expect(
                regana.ipw(yi, xij, zi)
            ).to my_round(5.6, 1)
        end
        it '#did' do
            yi = @did_dt.yi
            ti = @did_dt.ti
            zi = @did_dt.zi
            expect(
                regana.did(yi, ti, zi)
            ).to my_round(-1454.0, 1)
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
