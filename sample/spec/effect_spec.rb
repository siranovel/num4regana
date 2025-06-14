require 'spec_helper'
require 'num4regana'
require 'csv'

class EffectDat
    def initialize
        csv_dat = CSV.read('demo-ps.csv')
        csv_dat.delete_at(0)
        @yi = []
        @xij = []
        @zi = []
        csv_dat.each do |dt|
            @yi.push(dt[9].to_f) # day
            @zi.push(dt[2].to_f) # sex
            # age, BMI, Cr
            @xij.push(
                [dt[1].to_f, dt[3].to_f, dt[6].to_f]
            )
        end
    end
    def yi
        return @yi
    end
    def xij
        return @xij
    end
    def zi
        return @zi
    end
end

RSpec.describe Num4RegAnaLib do
    before(:all) do
        @bias_t = EffectDat.new
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
    end
end
