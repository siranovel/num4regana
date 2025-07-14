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
# 差分の差分法
class EffectDatDID
    def initialize
        @yi = []
        @xij = []
        @zi = []
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


