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

            return 0.0;
        }
        private double logitFunc(MultLineReg lineReg, double[] xi) {
            return 0.0;
        }
    }
}


