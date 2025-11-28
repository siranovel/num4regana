require 'spec_helper'
require 'num4regana'


RSpec.describe Num4RegAnaLib do
    describe Num4RegAnaLib::SmplRegAnaLib do
        before do
            @yi = [286, 851, 589, 389, 158, 1037, 463, 563, 372, 1020]
            @xi = [107, 336, 233,  82,  61,  378, 129, 313, 142,  428]
        end
        let!(:regana) { Num4RegAnaLib::SmplRegAnaLib.new }
        it '#line_reg_ana' do
            res = {
                "intercept":  99.075,    # 定数項
                "slope":      2.145,     # 回帰係数
            }
            expect(
                regana.line_reg_ana(@yi, @xi)
            ).to linereg(res, 3)
        end
        it '#getr2' do
            expect(
                regana.getr2(@yi, @xi)
            ).to my_round(0.893, 3)
        end
        it '#getr' do
            expect(
                regana.getr(@yi, @xi)
            ).to my_round(0.945, 3)
        end
    end    
    describe Num4RegAnaLib::OLSMultRegAnaLib do
        before do
            # 
            @olsyi = [45, 38, 41, 34, 59, 47, 35, 43, 54, 52]
            @olsxij = [
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
            #
            @olsyi2 = [
                283, 157, 192, 249, 259, 226, 352, 97, 111,  8, 235, 92,
                371, 161, 148, 362, 244, 237, 282, 59, 171,  9, 240, 174,
                256, 267, 312, 257, 318, 446, 143, 193,243,215, 544, 187, 153, 81, 113, 176,
                113, 174, 270,  93, 210, 388,  92,  58,117, 49, 193, 303, 142, 48, 165, 132,
            ]
            @olsxij2 = [
                [0,0,1,0*0],[0,0,2,0*0],[0,0,3,0*0],[0,0,4,0*0],[0,0,5,0*0],[0,0,6,0*0], [0,0,7,0*0],[0,0,8,0*0],[0,0,9,0*0],[0,0,10,0*0],[0,0,11,0*0],[0,0,12,0*0],
                [0,1,1,0*1],[0,1,2,0*1],[0,1,3,0*1],[0,1,4,0*1],[0,1,5,0*1],[0,1,6,0*1],[0,1,7,0*1],[0,1,8,0*1],[0,1,9,0*1],[0,1,10,0*1],[0,1,11,0*1],[0,1,12,0*1],
                [1,0,1,0*1],[1,0,2,0*1],[1,0,3,0*1],[1,0,4,0*1],[1,0,5,0*1],[1,0,6,0*1],[1,0,7,0*1],[1,0,8,0*1],[1,0,9,0*1],[1,0,10,0*1],[1,0,11,0*1],[1,0,12,0*1],[1,0,13,0*1],[1,0,14,0*1],[1,0,15,0*1],[1,0,16,0*1],
                [1,1,1,1*1],[1,1,2,1*1],[1,1,3,1*1],[1,1,4,1*1],[1,1,5,1*1],[1,1,6,1*1],[1,1,7,1*1],[1,1,8,1*1],[1,1,9,1*1],[1,1,10,1*1],[1,1,11,1*1],[1,1,12,1*1],[1,1,13,1*1],[1,1,14,1*1],[1,1,15,1*1],[1,1,16,1*1],
            ]
        end
        let!(:regana) { Num4RegAnaLib::OLSMultRegAnaLib.new }
        it '#line_reg_ana' do
            res = {
                "intercept":  -34.71,    # 定数項
                "slope":      [3.47, 0.53],     # 回帰係数
            }
            expect(
                regana.line_reg_ana(@olsyi, @olsxij)
            ).to linereg(res, 2)
        end
        it '#line_reg_ana 2' do
            res = {
                "intercept":  126.97,    # 定数項
                "slope":      [156.74, 0.07, -11.29, -94.00],     # 回帰係数
            }
            expect(
                regana.line_reg_ana(@olsyi2, @olsxij2)
            ).to linereg(res, 2)
        end
        it '#getr2' do
            expect(
                regana.getr2(@olsyi, @olsxij)
            ).to my_round(0.858, 3)
        end
        it '#getadjr2' do
            expect(
                regana.getadjr2(@olsyi, @olsxij)
            ).to my_round(0.8176, 4)
        end
        it '#getvif' do
            res = [1.5101, 1.5101]
            expect(
                regana.getvif(@olsxij)
            ).to is_rounds(res, 4)
        end
        it '#getaic' do
            expect(
                regana.getaic(@olsyi, @olsxij)
            ).to my_round(58.113, 3)
        end
    end
end



