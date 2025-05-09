public class Effectual {
    private static Effectual effect = new Effectual();
    public static Effectual getInstance() {
        return effect;
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
    private class IPW {
        LogitRegAna logitReg = LogitRegAna.getInstance();
        public double ipw(double[] yi, double[][] xij, double[] zi) {
            MultLineReg lineReg = logitReg.nonLineRegAna(zi, xij);
            double sumWY1 = 0.0;
            double sumWZ1 = 0.0;
            double sumWY0 = 0.0;
            double sumWZ0 = 0.0;

            for(int i = 0; i < yi.length; i++) {
                double p = logitFunc(lineReg, xij[i]);
                if (p == 0) { continue; }
                if (p == 1.0) { continue; }
                sumWY1 += zi[i] * yi[i] / p;
                sumWZ1 += zi[i] / p;

                sumWY0 += (1.0 - zi[i]) * yi[i] / (1 - p);
                sumWZ0 += (1.0 - zi[i]) / (1 - p);
            }
            double meanWY1 = (sumWZ1 == 0.0) ? 0.0 : sumWY1 / sumWZ1;
            double meanWY0 = (sumWZ0 == 0.0) ? 0.0 : sumWY0 / sumWZ0;

            return meanWY1 - meanWY0;
        }
        private double logitFunc(MultLineReg lineReg, double[] xi) {
            double q = lineReg.getIntercept();
            double b[] = lineReg.getSlope();

            for(int i = 0; i < xi.length; i++) {
                q += b[i] * xi[i];
            }
            return 1.0 / (1.0 + Math.exp(-1.0 * q));
        }
    }
}


