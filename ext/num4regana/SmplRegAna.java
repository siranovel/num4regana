import org.apache.commons.math3.stat.regression.SimpleRegression;

public class SmplRegAna {
    private static SmplRegAna regana = new SmplRegAna();
    public static SmplRegAna getInstance() {
        return regana;
    }
    public LineReg lineRegAna(double[] yi, double xi[]) {
        LineRegAna line = new LineRegAna();

        return line.lineRegAna(yi, xi);
    }
    public double getR2(double[] yi, double xi[]) {
        LineRegAna line = new LineRegAna();

        return line.getR2(yi, xi);
    }
    public double getR(double[] yi, double xi[]) {
        LineRegAna line = new LineRegAna();

        return line.getR(yi, xi);
    }
    /*********************************/
    /* interface define              */
    /*********************************/
    /*********************************/
    /* class define                  */
    /*********************************/
    public class LineReg {
        private double a = 0.0;
        private double b = 0.0;
        public LineReg(double a, double b) {
            this.a = a;
            this.b = b;
        }
        public double getIntercept() {
            return a;
        }
        public double getSlope() {
            return b;
        }
    }
    private class LineRegAna {
        // 単回帰の分析
        public LineReg lineRegAna(double[] yi, double xi[]) {
            SimpleRegression simpleReg = new SimpleRegression(true);

            for(int i = 0; i < yi.length; i++) {
                simpleReg.addData(xi[i], yi[i]);
            }
            LineReg ret = new LineReg(simpleReg.getIntercept(), simpleReg.getSlope());

            return ret;
        }
        // 決定係数取得
        public double getR2(double[] yi, double xi[]) {
            SimpleRegression simpleReg = new SimpleRegression(true);

            for(int i = 0; i < yi.length; i++) {
                simpleReg.addData(xi[i], yi[i]);
            }

            return simpleReg.getRSquare();
        }
        // 相関係数取得
        public double getR(double[] yi, double xi[]) {
            SimpleRegression simpleReg = new SimpleRegression(true);

            for(int i = 0; i < yi.length; i++) {
                simpleReg.addData(xi[i], yi[i]);
            }

            return simpleReg.getR();
        }
    }
}

