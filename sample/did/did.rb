require 'num4regana'

death = [2261, 2458, 3904,2547]
LSV = [0, 0, 1, 1]
D1854 = [0, 1, 0, 1]


olsyi = death
olsxij = [[0, 0, 0*0],
          [0, 1, 0*1],
          [1, 0, 1*0],
          [1, 1, 1*1]
         ]
ols = Num4RegAnaLib::OLSMultRegAnaLib.new
p ols.line_reg_ana(olsyi, olsxij)

