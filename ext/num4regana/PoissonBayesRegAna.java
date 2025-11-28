import java.util.Arrays;
import java.util.Map;
import org.apache.commons.math3.distribution.BetaDistribution;
import org.apache.commons.math3.distribution.PoissonDistribution;

public class PoissonBayesRegAna extends AbstractGLMM {
    private final int NUM = 1000;
    private static PoissonBayesRegAna regana = new PoissonBayesRegAna();
    public static PoissonBayesRegAna getInstance() {
        return regana;
    }
    public MultLineReg nonLineRegAna(double[] yi, double xij[][]) {
        double[] b = initB(xij[0].length);

        for  (int i = 0; i < NUM; i++) {
            b = mcmcGS(yi, b, xij);
        }
        return new PoissonLineReg(b);
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
    public class PoissonLineReg extends MultLineReg {
        private static double[] calcMeanB(double[] b) {
            int i = 0;
            double[] pb = new double[b.length];

            for(double e : b) {
                PoissonDistribution dist = new PoissonDistribution(e);

                pb[i] = dist.getNumericalMean();
                i++;
            }
            return pb;
        
        }
        public PoissonLineReg(double[] b) {
            super(calcMeanB(b));
        }
    }
}

