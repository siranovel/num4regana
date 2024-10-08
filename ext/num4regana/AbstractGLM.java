import java.util.Arrays;

abstract class AbstractGLM {
    private final double eta = 0.005;
    abstract double regression(double[] b, double[] xi);
    abstract double linkFunc(double q);
    // 勾配降下法
    protected double[] grand_metod(double[] yi, double[] b, double[][] xij) {
        // 交差エントロピー計算
        double[] ei = calcE(yi, b, xij);

        // パラメータ更新
        for(int i = 0; i < ei.length; i++) {
            b[i] -= eta * ei[i];
        }
        return b;
    }
    // AIC
    protected double calcAIC(double[] b, double[][] xij) {
        // 尤度計算
        double maxL = calcLogL(b,xij); 
        int k = 1 + xij[0].length;

        return -2 * (maxL - k);
    }
    // 交差エントロピー計算
    private double[] calcE(double[] yi, double[] b, double[][] xij) {
        double[] xi = new double[b.length];
        double[] ei = new double[b.length];

        Arrays.fill(ei, 0.0);
        for(int i = 0; i < yi.length; i++) {
            xi[0] = 1.0;
            System.arraycopy(xij[i], 0, xi, 1, xij[0].length);
            double p = linkFunc(regression(b, xi));

            for(int j = 0; j < xi.length; j++) {                
                ei[j] += (p - yi[i]) * xi[j];
            }
        }

        return ei;
    }
    // 対数尤度計算(パラメータ)
    private double calcLogL(double[] b, double[][] xij) {
        double l = 0.0;
        double[] xi = new double[b.length];

        for(int i = 0; i < xij.length; i++) {
            xi[0] = 1.0;
            System.arraycopy(xij[i], 0, xi, 1, xij[0].length);

            double p = linkFunc(regression(b, xi));

            l += Math.log(p);
        }
        return l;
    }
}

