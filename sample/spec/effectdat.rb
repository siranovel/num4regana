require 'csv'

# 傾向スコア
class EffectDatPS
    def initialize
        csv_dat = CSV.read('ps/demo-ps.csv')
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
# DID(Difference in Difference:差分の差分法)
class EffectDatDID
    # 1849年、1854年におけるエリア毎のコレラによる死者数
    @@sv1849 = [283,157,192,249,259,226,352,97,111,8,235,92]
    @@lsv1849 = [256,267,312,257,318,446,143,193,243,215,544,187,153,81,113,176]
    @@sv1854 = [371,161,148,362,244,237,282,59,171,9,240,74]
    @@lsv1854 = [113,174,270,93,210,388,92,58,117,49,193,303,142,48,165,132]
    @@yi = []
    @@ti = []
    @@zi = []
    def initialize
        # データフレームを作成
        ## 地域・年別のデータセッの作成
        js_df = crtDataFrame()
        ## 会社別のデータセットを作成
        js_sum = calcSum(js_df)

        js_sum.each do |dt|
            @@yi.push(dt[2])
            @@ti.push(dt[1] == "1854" ? 1 : 0)
            @@zi.push(dt[0].to_i)
        end
    end
    def yi
        @@yi
    end
    def ti
        return @@ti
    end
    def zi
        return @@zi
    end

    def crtDataFrame()
        sv = crtv("sv_", @@sv1849, @@sv1854, "0")
        lsv = crtv("lsv_", @@lsv1849, @@lsv1854, "1")
        df = sv + lsv
        return df
    end
    def crtv(x, v1849,v1854, lsv)
        v = []
        v1849.size.times{|i|
            # area, year, death, lsv
            v.push(
                [x + (i + 1).to_s, "1849", v1849[i], lsv]
            )
        }
        v1854.size.times{|i|
            # area, year, death, lsv
            v.push(
                [x + (i + 1).to_s, "1854", v1854[i], lsv]
            )
        }
        return v
    end
    def calcSum(df)
        s = []
        lsv = df[0][3]
        year = df[0][1]
        death = 0
        df.each do |dt|
            if dt[3] != lsv then
                s.push([lsv, year, death])
                lsv = dt[3]
                year = dt[1]
                death = 0
            end
            if dt[1] != year then
                s.push([lsv, year, death])
                year = dt[1]
                death = 0
            end
            death += dt[2]
        end
        s.push([lsv, year, death])
        return s
    end

    private :crtDataFrame, :crtv, :calcSum
end
# 回帰不連続デザイン(Regreion Discontinuity Design:RDD)
class EffectDatRDD
    def initialize
        @yi = []
        @xi = []
        @zi = []
        csv_dt = CSV.read('rdd/rdd_data.csv')
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


