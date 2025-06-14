import org.apache.commons.math3.analysis.function.Sigmoid;

public class Effectual {
    private static Effectual effect = new Effectual();
    public static Effectual getInstance() {
        return effect;
    }
    public double psm(double[] yi, double[][] xij, double[] zi) {
        PSM ps_psm = new PSM();

        return ps_psm.psm(yi, xij, zi);
    }
    public double ipw(double[] yi, double[][] xij, double[] zi) {
        IPW ps_ipw = new IPW();

        return ps_ipw.ipw(yi, xij, zi);
    }
    /*********************************/
    /* interface define              */
    /*********************************/
    /*********************************/
    /* class define                  */
    /*********************************/
    // 傾向スコアマッチング(PSM)
    private class PSM {
        private LogitRegAna logitReg = LogitRegAna.getInstance();
        private Sigmoid sigmoid = new Sigmoid();
        private int y0cnt = 0;
        private int y1cnt = 0;
        private double y0[][] = null;
        private double y1[][] = null;
        private final double caliper = 0.002;
        public double psm(double[] yi, double[][] xij, double[] zi) {
            double indices = 0.0;
            int matCnt = 0;

            yiDiv(yi, xij, zi);
            // マッチング
            for(int i = 0; i < y1cnt; i++) {
                for(int j = 0; j < y0cnt; j++) {
                    double abs_diff = Math.abs(y0[j][1] - y1[i][1]);

                    if (abs_diff < caliper) {
                       indices += y1[i][0] - y0[j][0];
                       matCnt++;
                       break;
                    }
                }
            }
            return indices / matCnt;
        }
        private void yiDiv(double[] yi, double[][] xij, double[] zi) {
            MultLineReg lineReg = logitReg.nonLineRegAna(zi, xij);
            int n = yi.length;

            y0 = new double[n][2];
            y1 = new double[n][2];
            for (int i = 0; i < n; i++) {
                double ps = sigmoidFunc(lineReg, xij[i]);
            
                if (0.0 == zi[i]) {
                    y0[y0cnt][0] = yi[i];
                    y0[y0cnt][1] = ps;
                    y0cnt++;
                }
                if (1.0 == zi[i]) {
                    y1[y1cnt][0] = yi[i];
                    y1[y1cnt][1] = ps;
                    y1cnt++;
                }
            }
        }        
        private double sigmoidFunc(MultLineReg lineReg, double[] xi) {
            double q = lineReg.getIntercept();
            double b[] = lineReg.getSlope();

            for(int i = 0; i < xi.length; i++) {
                q += b[i] * xi[i];
            }
            return sigmoid.value(q);
        }
    }
    // 逆確率重み付き推定(IPW)
    private class IPW {
        private LogitRegAna logitReg = LogitRegAna.getInstance();
        private Sigmoid sigmoid = new Sigmoid();
        public double ipw(double[] yi, double[][] xij, double[] zi) {
            MultLineReg lineReg = logitReg.nonLineRegAna(zi, xij);
            int n = yi.length;
            double sumWY1 = 0.0;
            double sumWZ1 = 0.0;
            double sumWY0 = 0.0;
            double sumWZ0 = 0.0;

            for(int i = 0; i < n; i++) {
                double ps = sigmoidFunc(lineReg, xij[i]);

                if (ps == 0.0) { continue; }
                if (ps == 1.0) { continue; }
                sumWY1 += zi[i] * yi[i] / ps;
                sumWZ1 += zi[i] / ps;

                sumWY0 += (1.0 - zi[i]) * yi[i] / (1.0 - ps);
                sumWZ0 += (1.0 - zi[i]) / (1.0 - ps);
            }
            double meanWY1 = (sumWZ1 == 0.0) ? 0.0 : sumWY1 / sumWZ1;
            double meanWY0 = (sumWZ0 == 0.0) ? 0.0 : sumWY0 / sumWZ0;
            return meanWY1 - meanWY0;
        }
        private double sigmoidFunc(MultLineReg lineReg, double[] xi) {
            double q = lineReg.getIntercept();
            double b[] = lineReg.getSlope();

            for(int i = 0; i < xi.length; i++) {
                q += b[i] * xi[i];
            }
            return sigmoid.value(q);
        }
    }
}


