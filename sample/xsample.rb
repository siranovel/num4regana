require 'num4regana'
require 'num4anova'

p "-------- SmplRegAnaLib test --------"
yi = [286, 851, 589, 389, 158, 1037, 463, 563, 372, 1020]
xi = [107, 336, 233,  82,  61,  378, 129, 313, 142,  428]
regana = Num4RegAnaLib::SmplRegAnaLib.new
p regana.line_reg_ana(yi, xi)

p "-------- OLSMultRegAnaLib test --------"
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
ols = Num4RegAnaLib::OLSMultRegAnaLib.new
p ols.line_reg_ana(olsyi, olsxij)
p ols.getr2(olsyi, olsxij)

p "-------- PoissonRegAnaLib.AIC test --------"
glmyi = [4, 10, 7, 14]
glmxij = [
        [1],
        [2],
        [3],
        [4],
]
regana = Num4RegAnaLib::PoissonRegAnaLib.new
glmres = regana.non_line_reg_ana(glmyi, glmxij)
res = regana.get_aic(glmres, glmxij)
p res


p "-------- OneWayLayoutLib.bartlet check --------"
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

oneWay = Num4AnovaLib::OneWayLayoutLib.new
p oneWay.bartlet(olsxij, 0.05)

p "-------- LogitBayesRegAnaLib test --------"
yi = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
xij = [
        [1, 24],
        [1, 18],
        [0, 15],
        [1, 16],
        [0, 10],
        [1, 26],
        [1, 2],
        [0, 24],
        [1, 18],
        [1, 22],
        [1, 3],
        [1, 6],
        [0, 15],
        [0, 12],
        [1, 6],
        [0, 6],
        [1, 12],
        [0, 12],
        [1, 18],
        [1, 3],
        [1, 8],
        [0, 9],
        [0, 12],
        [0, 6],
        [0, 8],
        [1, 12],
      ]
regana = Num4RegAnaLib::LogitBayesRegAnaLib.new
p regana.non_line_reg_ana(yi, xij)

