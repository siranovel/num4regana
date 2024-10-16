import org.apache.commons.math3.stat.regression.OLSMultipleLinearRegression;
import org.apache.commons.math3.stat.regression.GLSMultipleLinearRegression;
import org.apache.commons.math3.stat.correlation.Covariance;
import org.apache.commons.math3.stat.descriptive.DescriptiveStatistics;
import java.util.Arrays;
import org.apache.commons.math3.distribution.ChiSquaredDistribution;

public class MultRegAna {
    private final double A = 0.05;
    private static MultRegAna regana = new MultRegAna();
    public static MultRegAna getInstance() {
        return regana;
    }
    public LineReg lineRegAna(double[] yi, double xij[][]) {
        LineRegAna line = createLineRegAna(yi, xij);

        return line.lineRegAna(yi, xij);
    }
    public double getR2(double[] yi, double xij[][]) {
        LineRegAna line = createLineRegAna(yi, xij);

        return line.getR2(yi, xij);
    }
    public double getAdjR2(double[] yi, double xij[][]) {
        LineRegAna line = createLineRegAna(yi, xij);

        return line.getAdjR2(yi, xij);
    }
    public double[] getVIF(double xij[][]) {
        VIF vifDt = new  VIF(xij);
        double[] retVif = new double[xij[0].length];

        for(int i = 0; i < retVif.length; i++) {
            vifDt.divDt(i);
            LineRegAna line = createLineRegAna(vifDt.getVifYi(), vifDt.getVifXi());

            retVif[i] = line.getVIF(vifDt.getVifYi(), vifDt.getVifXi());
        }
        return retVif;
    }
    private LineRegAna createLineRegAna(double[] yi, double xij[][]) {
        double[][] data = createData(yi, xij);

        // 等分散性の検定
        if (false == bartletTest(data)) {  // 等分散性
            return new OLSMultRegAna();
        }
        else {                             // 
            return new GLSMultRegAna(data);
        }
    }
    private double[][] createData(double[] yi, double xij[][]) {
        double[][] data = new double[yi.length][1 + xij[0].length];

        for (int i = 0; i < yi.length; i++) {
            data[i][0] = yi[i];
            System.arraycopy(xij[i], 0, data[i], 1, xij[0].length);
        }
        return data;
    }
    private boolean bartletTest(double data[][]) {
        OneWayAnovaTest anova = new BartletTest();
        double statistic = anova.calcTestStatistic(data);

        return anova.execute_test(statistic, A);
    }
    /*********************************/
    /* interface define              */
    /*********************************/
    private interface LineRegAna {
        // 最小２乗法
        LineReg lineRegAna(double[] yi, double xij[][]);
        // 決定係数取得
        double getR2(double[] yi, double xij[][]);
        // 自由度調整済み決定係数
        double getAdjR2(double[] yi, double xij[][]);
        // VIF
        default double getVIF(double[] yi, double xij[][]) {
            double r2 = getR2(yi, xij);

            return 1.0 / (1.0 - r2);
        }
    }
    private interface OneWayAnovaTest {
        double calcTestStatistic(double[][] xi);
        boolean execute_test(double statistic, double a);
    }
    /*********************************/
    /* class define                  */
    /*********************************/
    private class VIF {
        private double xij[][] = null;
        private double[] vifYi = null;
        private double[][] vifXi = null;
        public VIF(double xij[][]) {
            this.xij = xij;
            this.vifYi = new double[xij.length];
            this.vifXi = new double[xij.length][xij[0].length - 1];
        }
        public void divDt(int i) {
            for(int n = 0; n < vifYi.length; n++) {
                vifYi[n] = xij[n][i];
            }
            for(int n = 0; n < xij.length; n++){
                int j = 0;

                for(int m = 0; m < xij[0].length; m++) {
                    if (m != i) { 
                        vifXi[n][j] = xij[n][m];
                        j++; 
                    }
                }
            }
        }
        public double[] getVifYi() { return vifYi; }
        public double[][] getVifXi() { return vifXi;}
    }
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
    // 等分散性検定
    private class BartletTest implements OneWayAnovaTest {
        private int n = 0;
        public double calcTestStatistic(double[][] xi) {
            n = xi.length;
            double ln2L = logL(xi);

            return calcB(ln2L, xi);
        }
        private double logL(double[][] xi) {
            double[] si = new double[n];
            DescriptiveStatistics stat = new DescriptiveStatistics();
            double nisi2 = 0.0;    // (Ni - 1)*si^2の合計
            double nilogsi2 = 0.0; // (Ni - 1)*log(si^2)の合計
            int sumN = 0;

            for(int i = 0; i < n; i++) {
                Arrays.stream(xi[i]).forEach(stat::addValue);
                sumN += stat.getN();
                si[i] = stat.getVariance();
                nisi2 += (stat.getN() - 1) * si[i];
                nilogsi2 += (stat.getN() - 1) * Math.log(si[i]);
                stat.clear();
            }
            double sumNin = sumN - n;
            return sumNin * (Math.log(nisi2 / sumNin) - nilogsi2 / sumNin);
        }
        private double calcB(double ln2L, double[][] xi) {
            double invSumN = 0.0;
            int sumN = 0;
            DescriptiveStatistics stat = new DescriptiveStatistics();

            for(int i = 0; i < n; i++) {
                Arrays.stream(xi[i]).forEach(stat::addValue);
                invSumN += 1.0 / (stat.getN() - 1.0);
                sumN += stat.getN();
                stat.clear();
            }
            double deno = 1 + 1.0 / (3 * (n - 1))
                        * (invSumN - 1.0 / (sumN - n));
            return ln2L / deno;
        }
        public boolean execute_test(double statistic, double a) {
            ChiSquaredDistribution chi2Dist = new ChiSquaredDistribution(n - 1);
            double r_val = chi2Dist.inverseCumulativeProbability(1.0 - a);

            return (r_val < statistic) ? true : false;
        }
    }

    // 最小２乗法
    private class OLSMultRegAna implements LineRegAna {
        private OLSMultipleLinearRegression regression = null;
        public OLSMultRegAna() {
            regression = new OLSMultipleLinearRegression();
        }
        public LineReg lineRegAna(double[] yi, double xij[][]) {
            regression.newSampleData(yi, xij);

            double[] beta = regression.estimateRegressionParameters();

            return new LineReg(beta);
        }
        // 決定係数取得
        public double getR2(double[] yi, double xij[][]) {
            regression.newSampleData(yi, xij);
            return regression.calculateRSquared();
        }
        // 自由度調整済み決定係数
        public double getAdjR2(double[] yi, double xij[][]) {
            regression.newSampleData(yi, xij);
            return regression.calculateAdjustedRSquared();
        }
        
    }
    // 一般化最小２乗法
    private class GLSMultRegAna implements LineRegAna {
        private GLSMultipleLinearRegression regression = null;
        private double[][] data = null;
        public GLSMultRegAna(double data[][]) {
            regression = new GLSMultipleLinearRegression();
            this.data = data;
        }
        public LineReg lineRegAna(double[] yi, double xij[][]) {
            double[][] omega = calcCovatrianceMatrix();
            regression.newSampleData(yi, xij, omega);

            double[] beta = regression.estimateRegressionParameters();
            return new LineReg(beta);
        }
        // 決定係数取得
        public double getR2(double[] yi, double xij[][]) {
            return 0.0;
        }
        // 自由度調整済み決定係数
        public double getAdjR2(double[] yi, double xij[][]) {
            return 0.0;
        }
        private double[][] calcCovatrianceMatrix() {
            Covariance corel = new Covariance();
            double[][] omega = new double[data.length][data.length];

            for(int i = 0; i < data.length; i++) {
                for(int j = 0; j < data.length; j++) {
                    double[] xArray = data[i];
                    double[] yArray = data[j];

                    omega[i][j] = corel.covariance(xArray, yArray);
                }
            }
            return omega;
        }
    }
            
}

