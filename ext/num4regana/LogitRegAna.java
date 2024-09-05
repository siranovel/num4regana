public class LogitRegAna {
    private static LogitRegAna regana = new LogitRegAna();
    public static LogitRegAna getInstance() {
        return regana;
    }
    public LineReg nonLineRegAna(double[] yi, double xij[][]) {
        NonLineRegAna line = new NonLineRegAna();

        return line.nonLineRegAna(yi, xij);
    }
    /*********************************/
    /* interface define              */
    /*********************************/
    /*********************************/
    /* class define                  */
    /*********************************/
    public class LineReg {
        private double a   = 0.0;
        private double[] b = null;
        public LineReg(double[] b) {
            this.a = b[0];
            this.b = new double[b.length - 1];
            for (int i = 0; i < this.b.length; i++) {
                this.b[i] = b[i + 1];
            }
        }
        public double getIntercept() {
            return a;
        }
        public double[] getSlope() {
            return b;
        }
    }
    private class NonLineRegAna {
        private final double eta = 0.001;
        private final int num = 10000;
        public LineReg nonLineRegAna(double[] yi, double[][] xij) {
            double[] b = new double[1 + xij[0].length];
            
            for(int i = 0; i < b.length; i++) {
                b[i] = 0.0;
            }
            for  (int i = 0; i < num; i++) {
                b = grand_metod(yi, b, xij);
            }
            return new LineReg(b);
        }
        // q = b0 + b1 * x0
        private double rereion(double[] b, double[] xi) {
            double ret = b[0];

            for(int i = 0; i < xi.length; i++) {
                ret += b[i + 1] * xi[i];
            }
            return ret;
        }
        // p = 1 / (1 + exp( -q))
        private double sigmoid(double q) {
            return 1.0 / (1.0 + Math.exp(-1.0 * q));
        }
        private double[] grand_metod(double[] yi, double[] b, double[][] xij) {
            double e0 = 0.0;
            double[] en = new double[xij[0].length];

            for(int i = 0; i < yi.length; i++) {
                double q = rereion(b, xij[i]);
                double p = sigmoid(q);

                e0 += (yi[i] - p);
                for(int j = 0; j < en.length; j++) {                
                    en[j] += (yi[i] - p) * xij[i][j];
                }
            }
            b[0] = b[0] + eta * e0;
            for(int j = 0; j < en.length; j++) {
                b[1 + j] += eta * en[j];
            }
            return b;
        }
    }
}

