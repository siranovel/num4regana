import java.util.Map;
import java.util.Arrays;
import org.apache.commons.math3.distribution.BetaDistribution;

public class LogitBayesRegAna extends AbstractGLMM {
    private final int NUM = 1000;
    private final int TIM = 3;
    private static LogitBayesRegAna regana = new LogitBayesRegAna();
    public static LogitBayesRegAna getInstance() {
        return regana;
    }
    public LineReg nonLineRegAna(double[] yi, double xij[][]) {
        double[] b = initB(xij[0].length);

        for  (int i = 0; i < NUM; i++) {
            b = mcmcGS(yi, b, xij);
        }

        return new LineReg(b);
    }
    public double getBIC(Map<String, Object> regCoe, double[][] xij) {
        double[] b = new double[1 + xij[0].length];

        b[0] = (double)regCoe.get("intercept");
        System.arraycopy(regCoe.get("slope"), 0, b, 1, xij[0].length);
        return calcBIC(b, xij);
    }
    private double[] initB(int xsie) {
        double[] b = new double[1 + xsie];
        BetaDistribution beDist = new BetaDistribution(50, 50);

        for(int i = 0; i < b.length; i++) {
            b[i] = beDist.sample();
        }
        return b;
    }
    private double[] calcMeanBy(double[] yi, double[] b) {
        double[] meanB = new double[b.length];

        Arrays.fill(meanB, 0.0);
        for(int i = 0; i < meanB.length; i++) {
            for(int j = 0; j < yi.length; j++) {
                meanB[i] += yi[j] * b[i];
            }
        }
        return meanB;
    }
    // q = b0 + b1 * x0 + r
    // (ランダム切片モデル)
    double regression(double[] b, double[] xi, double r) {
        double ret = 0.0;

        for(int i = 0; i < xi.length; i++) {
            ret += b[i] * xi[i];
        }
        return ret + r;
    }
    // p = 1 / (1 + exp( -q))
    double linkFunc(double q) {
        return 1.0 / (1.0 + Math.exp(-1.0 * q));
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
}

