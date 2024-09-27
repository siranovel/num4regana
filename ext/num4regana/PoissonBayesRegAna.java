import java.util.Arrays;
import java.util.Map;
import org.apache.commons.math3.distribution.BetaDistribution;

public class PoissonBayesRegAna extends AbstractGLMM {
    private final int NUM = 1000;
    private final int TIM = 3;
    private static PoissonBayesRegAna regana = new PoissonBayesRegAna();
    public static PoissonBayesRegAna getInstance() {
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
    // q = b0 + b1 * x0
    double regression(double[] b, double[] xi, double r) {
        double ret = 0.0;

        for(int i = 0; i < xi.length; i++) {
            ret += b[i] * xi[i];
        }
        return ret;
    }
    // p = exp(q)
    double linkFunc(double q) {
        return Math.exp(q);
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

