import org.apache.commons.math3.stat.regression.OLSMultipleLinearRegression;

public class OLSMultRegAna {
    private static OLSMultRegAna regana = new OLSMultRegAna();
    public static OLSMultRegAna getInstance() {
        return regana;
    }
    public LineReg lineRegAna(double[] yi, double xij[][]) {
        LineRegAna line = new LineRegAna();

        return line.lineRegAna(yi, xij);
    }
    public double getR2(double[] yi, double xij[][]) {
        LineRegAna line = new LineRegAna();

        return line.getR2(yi, xij);
    }
    public double getAdjR2(double[] yi, double xij[][]) {
        LineRegAna line = new LineRegAna();

        return line.getAdjR2(yi, xij);
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
    private class LineRegAna {
        // 最小２乗法
        public LineReg lineRegAna(double[] yi, double xij[][]) {
            OLSMultipleLinearRegression regression = new OLSMultipleLinearRegression();

            regression.newSampleData(yi, xij);

            double[] beta = regression.estimateRegressionParameters();

            LineReg ret = new LineReg(beta);
            return ret;
        }
        // 決定係数取得
        public double getR2(double[] yi, double xij[][]) {
            OLSMultipleLinearRegression regression = new OLSMultipleLinearRegression();

            regression.newSampleData(yi, xij);
            return regression.calculateRSquared();
        }
        // 自由度調整済み決定係数
        public double getAdjR2(double[] yi, double xij[][]) {
            OLSMultipleLinearRegression regression = new OLSMultipleLinearRegression();

            regression.newSampleData(yi, xij);
            return regression.calculateAdjustedRSquared();
        }
        
    }
}

