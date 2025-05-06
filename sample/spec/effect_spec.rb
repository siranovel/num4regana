require 'spec_helper'
require 'num4regana'
require 'csv'

class EffectDat
    def initialize
        csv_dt = CSV.read('bias_df.csv')
        # Yi: spend
        # Zi: treatment
        @yi = []
        @xij = []
        @zi = []
        csv_dt.each do |dt|
            @yi.push(dt[11].to_i)           # spend
            @zi.push(dt[12].to_i)           # treatment
            case dt[7]                 # channel(Web, Phone, Multichannel)
            when "Phone"               # recency + history + channel
                @xij.push([dt[0].to_i, dt[2].to_f, 1, 0])
            when "Web"
                @xij.push([dt[0].to_i, dt[2].to_f, 0, 1])
            when "Multichannel"
                @xij.push([dt[0].to_i, dt[2].to_f, 1, 1])
            else
                @xij.push([dt[0].to_i, dt[2].to_f, 0, 0])
            end
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
        it '#ipw' do
            yi = @bias_t.yi
            xij = @bias_t.xij
            zi = @bias_t.zi
            expect(
                regana.ipw(yi, xij, zi)
            ).to my_round(100.0, 1)

            p @bias_t.xi[0]
        end
    end
end
