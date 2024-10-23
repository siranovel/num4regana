require 'num4regana'

glmyi = [4, 10, 7, 14]
glmxij = [
        [1],
        [2],
        [3],
        [4],
]
regana = Num4RegAnaLib::PoissonHierBayesRegAnaLib.new
10.times do
    p regana.non_line_reg_ana(glmyi, glmxij)
end

