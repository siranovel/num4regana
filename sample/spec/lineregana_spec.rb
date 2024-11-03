require 'spec_helper'
require 'num4regana'


RSpec.describe Num4RegAnaLib do
    describe Num4RegAnaLib::SmplRegAnaLib do
        let!(:regana) { Num4RegAnaLib::SmplRegAnaLib.new }
        it '#line_reg_ana' do
            yi = [286, 851, 589, 389, 158, 1037, 463, 563, 372, 1020]
            xi = [107, 336, 233,  82,  61,  378, 129, 313, 142,  428]
            res = {
                "intercept":  99.075,    # 定数項
                "slope":      2.145,     # 回帰係数
            }
            expect(
                regana.line_reg_ana(yi, xi)
            ).to linereg(res, 3)
        end
        it '#getr2' do
            yi = [286, 851, 589, 389, 158, 1037, 463, 563, 372, 1020]
            xi = [107, 336, 233,  82,  61,  378, 129, 313, 142,  428]
            expect(
                regana.getr2(yi, xi)
            ).to my_round(0.893, 3)
        end
        it '#getr' do
            yi = [286, 851, 589, 389, 158, 1037, 463, 563, 372, 1020]
            xi = [107, 336, 233,  82,  61,  378, 129, 313, 142,  428]
            expect(
                regana.getr(yi, xi)
            ).to my_round(0.945, 3)
        end
    end    
    describe Num4RegAnaLib::OLSMultRegAnaLib do
        let!(:regana) { Num4RegAnaLib::OLSMultRegAnaLib.new }
        it '#line_reg_ana' do
            olsyi = [45, 38, 41, 34, 59, 47, 35, 43, 54, 52]
            olsxij = [
                [17.5, 30],
                [17.0, 25],
                [18.5, 20],
                [16.0, 30],
                [19.0, 45],
                [19.5, 35],
                [16.0, 25],
                [18.0, 35],
                [19.0, 35],
                [19.5, 40],
            ]
            res = {
                "intercept":  -34.71,    # 定数項
                "slope":      [3.47, 0.53],     # 回帰係数
            }
            expect(
                regana.line_reg_ana(olsyi, olsxij)
            ).to linereg(res, 2)
        end
        it '#getr2' do
            olsyi = [45, 38, 41, 34, 59, 47, 35, 43, 54, 52]
            olsxij = [
                [17.5, 30],
                [17.0, 25],
                [18.5, 20],
                [16.0, 30],
                [19.0, 45],
                [19.5, 35],
                [16.0, 25],
                [18.0, 35],
                [19.0, 35],
                [19.5, 40],
            ]
            expect(
                regana.getr2(olsyi, olsxij)
            ).to my_round(0.858, 3)
        end
        it '#getadjr2' do
            olsyi = [45, 38, 41, 34, 59, 47, 35, 43, 54, 52]
            olsxij = [
                [17.5, 30],
                [17.0, 25],
                [18.5, 20],
                [16.0, 30],
                [19.0, 45],
                [19.5, 35],
                [16.0, 25],
                [18.0, 35],
                [19.0, 35],
                [19.5, 40],
            ]
            expect(
                regana.getadjr2(olsyi, olsxij)
            ).to my_round(0.8176, 4)
        end
        it '#getvif' do
            olsxij = [
                [17.5, 30],
                [17.0, 25],
                [18.5, 20],
                [16.0, 30],
                [19.0, 45],
                [19.5, 35],
                [16.0, 25],
                [18.0, 35],
                [19.0, 35],
                [19.5, 40],
            ]
            res = [1.5101, 1.5101]
            expect(
                regana.getvif(olsxij)
            ).to is_rounds(res, 4)
        end
        it '#getaic' do
            olsyi = [45, 38, 41, 34, 59, 47, 35, 43, 54, 52]
            olsxij = [
                [17.5, 30],
                [17.0, 25],
                [18.5, 20],
                [16.0, 30],
                [19.0, 45],
                [19.5, 35],
                [16.0, 25],
                [18.0, 35],
                [19.0, 35],
                [19.5, 40],
            ]
            expect(
                regana.getaic(olsyi, olsxij)
            ).to my_round(58.113, 3)
        end
    end
end



