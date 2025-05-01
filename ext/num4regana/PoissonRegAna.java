import java.util.Arrays;
import java.util.Map;

public class PoissonRegAna extends AbstractGLM {
    private final int NUM = 1000;
    private static PoissonRegAna regana = new PoissonRegAna();
    public static PoissonRegAna getInstance() {
        return regana;
    }
    public MultLineReg nonLineRegAna(double[] yi, double[][] xij) {
        double[] b = initB(xij[0].length);

        for  (int i = 0; i < NUM; i++) {
            b = grand_metod(yi, b, xij);
        }
        return new MultLineReg(b);
    }
    public double getAIC(Map<String, Object> regCoe, double[][] xij) {
        double[] b = new double[1 + xij[0].length];

        b[0] = (double)regCoe.get("intercept");
        System.arraycopy(regCoe.get("slope"), 0, b, 1, xij[0].length);
        return calcAIC(b, xij);
    }
    private double[] initB(int xsie) {
        double[] b = new double[1 + xsie];
         
        Arrays.fill(b, 0.0);
        return b;
    }
    // q = b0 + b1 * x0
    double regression(double[] b, double[] xi) {
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

