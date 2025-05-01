import org.apache.commons.math3.stat.regression.SimpleRegression;

public class SmplRegAna {
    private static SmplRegAna regana = new SmplRegAna();
    public static SmplRegAna getInstance() {
        return regana;
    }
    public SmplLineReg lineRegAna(double[] yi, double xi[]) {
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
    private class LineRegAna {
        // 単回帰の分析
        public SmplLineReg lineRegAna(double[] yi, double xi[]) {
            SimpleRegression simpleReg = new SimpleRegression(true);

            for(int i = 0; i < yi.length; i++) {
                simpleReg.addData(xi[i], yi[i]);
            }
            SmplLineReg ret = new SmplLineReg(simpleReg.getIntercept(), simpleReg.getSlope());

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

