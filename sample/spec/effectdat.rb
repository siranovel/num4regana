require 'csv'

# 傾向スコア
class EffectDatPS
    def initialize
        csv_dat = CSV.read('demo-ps.csv')
        csv_dat.delete_at(0)
        @yi = []
        @xij = []
        @zi = []
        csv_dat.each do |dt|
            @yi.push(dt[9].to_f) # days
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
# 回帰不連続デザイン(Regreion Discontinuity Design:RDD)
class EffectDatRDD
    def initialize
        @yi = []
        @xi = []
        @zi = []
        csv_dt = CSV.read('rdd_data.csv')
        csv_dt.each do |dt|
            treatment = ("Mens E-Mail" == dt[8]) ? 1 : 0
            @yi.push(dt[9].to_f) # visit
            @xi.push(dt[13].to_f) # history_log
            @zi.push(treatment)
        end
    end
    def yi
        return @yi
    end
    def xi
        return @xi
    end
    def zi
        return @zi
    end
end


