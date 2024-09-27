import java.util.Arrays;
import org.apache.commons.math3.distribution.BetaDistribution;
import org.apache.commons.math3.distribution.NormalDistribution;

abstract class AbstractGLMM {
    private NormalDistribution nDist = new NormalDistribution(0,1);
    abstract double regression(double[] b, double[] xi, double r);
    abstract double linkFunc(double q);
    // mcmc法
    // （メトロポリス法,ギブスサンプリング）
    protected double[] mcmcGS(double[] yi, double[] b, double[][] xij) {
        BetaDistribution beDist = new BetaDistribution(50, 50);
        BetaDistribution beDist2 = new BetaDistribution(1, 1);  // 確率用
        double[] newB = new double[b.length];
        double oldL = 0.0;
        double newL = 0.0;

        for(int i = 0; i < b.length; i++) {
            newB = Arrays.copyOf(b, b.length);
            oldL = calcLx(b,xij);
            newB[i] = beDist.sample();
            newL = calcLx(newB,xij);

            double r = newL / oldL;
            if (r > 1.0) {
                b[i] = newB[i];
            }
            else {
                double r2 = beDist2.sample();

                if (r2 < (1.0 - r)) {
                    b[i] = newB[i];
                }
            }            
        }
        return b;
    }
    // BIC
    protected double calcBIC(double[] b, double[][] xij) {
        // 尤度計算
        double maxL = calcLogLx(b,xij);
        int k = 1 + xij[0].length;
        int n = xij.length;

        return -2 * maxL + k * Math.log(n);
    }
    // EMアルゴリズム
    protected double[] mcmcEM(double[] yi, double[] b, double[][] xij) {
        double[] newB = new double[b.length];

        double[] bE = calcEStep(yi, b);
        double[] bM = calcMStep(yi, bE, xij);

        for(int i = 0; i < newB.length; i++) {
            newB[i] = b[i] + bM[i];
        }
        return newB;
    }
    /* ------------------------------------------------------------------ */
    // 尤度計算(パラメータ)
    private double calcLx(double[] b, double[][] xij) {
        double l = 1.0;
        double[] xi = new double[b.length];

        for(int i = 0; i < xij.length; i++) {
            xi[0] = 1.0;
            System.arraycopy(xij[i], 0, xi, 1, xij[0].length);
            double q = regression(b, xi, nDist.sample());
            double p = linkFunc(q);

            l *= p;
        }
        return l;
    }   
    // 対数尤度計算(パラメータ)
    private double calcLogLx(double[] b, double[][] xij) {
        double l = 0.0;
        double[] xi = new double[b.length];

        for(int i = 0; i < xij.length; i++) {
            xi[0] = 1.0;
            System.arraycopy(xij[i], 0, xi, 1, xij[0].length);
            double q = regression(b, xi, nDist.sample());
            double p = linkFunc(q);

            l += Math.log(p);
        }
        return l;
    }
    // E-Step
    //  (自己エントロピー)
    private double[] calcEStep(double[] yi, double[] b) {
        double[] bh = new double[b.length];

        Arrays.fill(bh, 0.0);
        for(int j = 0; j < b.length; j++) {
            for(int i = 0; i < yi.length; i++) {
                double p = linkFunc(yi[i]);

                bh[j] += p * Math.log(p);
            }
            bh[j] *= -1;
        }
        return bh;
    }
    // M-Step
    //  (KLダイバージェンス)
    private double[] calcMStep(double[] yi, double[] b, double[][] xij) {
        double[] xi = new double[b.length];
        double[] ei = new double[b.length];

        Arrays.fill(ei, 0.0);
        for(int j = 0; j < b.length; j++) {
            for(int i = 0; i < xij.length; i++) {
                xi[0] = 1.0;
                System.arraycopy(xij[i], 0, xi, 1, xij[0].length);

                double q = linkFunc(yi[i]);
                double p = linkFunc(regression(b, xi, 0));

                ei[j] += q * (Math.log(q) - Math.log(p)) * xi[j];
            }   
        }
        return ei;
    }   
}

