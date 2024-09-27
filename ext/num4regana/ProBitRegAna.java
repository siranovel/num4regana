import java.util.Arrays;
import org.apache.commons.math3.distribution.NormalDistribution;
import java.util.Map;

public class ProBitRegAna extends AbstractGLM {
    private final int NUM = 1000;
    private static ProBitRegAna regana = new ProBitRegAna();
    private NormalDistribution ndist = new NormalDistribution(0, 1);
    
    public static ProBitRegAna getInstance() {
        return regana;
    }
    public LineReg nonLineRegAna(double[] yi, double[][] xij) {
        double[] b = initB(xij[0].length);
         
        for  (int i = 0; i < NUM; i++) {
            b = grand_metod(yi, b, xij);
        }
        return new LineReg(b);
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
    // 
    double linkFunc(double q) {
        return ndist.cumulativeProbability(q);
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

