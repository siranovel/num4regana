import java.util.Arrays;
import java.util.Map;
import org.apache.commons.math3.distribution.BetaDistribution;

public class PoissonHierBayesRegAna extends AbstractGLMM {
    private final int NUM = 1000;
    private static PoissonHierBayesRegAna regana = new PoissonHierBayesRegAna();
    public static PoissonHierBayesRegAna getInstance() {
        return regana;
    }
    public MultLineReg nonLineRegAna(double[] yi, double xij[][]) {
        double[] b = initB(xij[0].length);

        for  (int i = 0; i < NUM; i++) {
            b = mcmcEM(yi, b, xij);
        }
        return new MultLineReg(b);
    }
    private double[] initB(int xsie) {
        double[] b = new double[1 + xsie];

        Arrays.fill(b, 0.0);
        return b;
    }
    // q = b0 + b1 * x0 + r
    // ランダム切片モデル
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
}
