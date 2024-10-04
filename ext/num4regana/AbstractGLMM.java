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
        double[] newB = new double[b.length];

        for(int i = 0; i < b.length; i++) {
            newB = Arrays.copyOf(b, b.length);
            newB[i] = beDist.sample();

            b[i] = mcmcSample(
                calcLx(b,xij),         // oldL
                calcLx(newB,xij),      // newL
                new double[] {b[i], newB[i]} // bTbl: [0]=> oldB, [1]=> newB
            );
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
        double[][] bE = calcEStep(yi, b, xij);
        double[] bM = calcMStep(yi, bE, xij);

        for(int i = 0; i < newB.length; i++) {
            newB[i] = bM[i];  
        }
        return newB;
    }
    /*********************************/
    /* interface define              */
    /*********************************/
    /*********************************/
    /* class define                  */
    /*********************************/
    private static class ArraysFillEx {
        public static void fill(Object array, Object value) {
            // 第一引数が配列か判定
            Class<?> type = array.getClass();
            if (!type.isArray()) {
                throw new IllegalArgumentException("not array");
            }

            // クラスの型を判定
            String arrayClassName = array.getClass().getSimpleName()
                    .replace("[]", "")
                    .toLowerCase();
            String valueClassName = value.getClass().getSimpleName()
                    .toLowerCase()
                    .replace("character", "char")
                    .replace("integer", "int");
            if (!arrayClassName.equals(valueClassName)) {
                throw new IllegalArgumentException("does not matc");
            }

            // 処理
            if (type.getComponentType().isArray()) {
                for(Object o: (Object[])array) {
                    fill(o, value);
                }
            }
            else if (array instanceof boolean[]) {
                Arrays.fill((boolean[])array, (boolean)value);
            }
            else if (array instanceof char[]) {
                Arrays.fill((char[])array, (char)value);
            }
            else if (array instanceof byte[]) {
                Arrays.fill((byte[])array, (byte)value);
            }
            else if (array instanceof short[]) {
                Arrays.fill((short[])array, (short)value);
            }
            else if (array instanceof int[]) {
                Arrays.fill((int[])array, (int)value);
            }
            else if (array instanceof long[]) {
                Arrays.fill((long[])array, (long)value);
            }
            else if (array instanceof float[]) {
                Arrays.fill((float[])array, (float)value);
            }
            else if (array instanceof double[]) {
                Arrays.fill((double[])array, (double)value);
            }
            else {
                Arrays.fill((Object[])array, value);
            }
        }
    }
    /* ------------------------------------------------------------------ */
    private double mcmcSample(double oldL, double newL, double[] bTbl) {
        double r = newL / oldL;
        BetaDistribution beDist2 = new BetaDistribution(1, 1);  // 確率用
        double b;

        b = bTbl[0];
        if (r > 1.0) {
            b = bTbl[1];
        }
        else {
            double r2 = beDist2.sample();

            if (r2 < (1.0 - r)) {
                b = bTbl[1];
            }
        }            
        return b;
    }
    // 尤度計算(パラメータ)
    private double calcLx(double[] b, double[][] xij) {
        double l = 1.0;
        double[] xi = new double[b.length];

        for(int i = 0; i < xij.length; i++) {
            xi[0] = 1.0;
            System.arraycopy(xij[i], 0, xi, 1, xij[0].length);
            double q = linkFunc(
                regression(b, xi, nDist.sample())
            );

            l *= q;
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
            double q = linkFunc(
                regression(b, xi, nDist.sample())
            );

            l += Math.log(q);
        }
        return l;
    }
    // E-Step
    //  (Expetation:自己エントロピー)
    private double[][] calcEStep(double[] yi, double[] b, double[][] xij) {
        double[][] bh = new double[yi.length][b.length];
        double[] xi = new double[b.length];

        ArraysFillEx.fill(bh, 0.0);
        for(int i = 0; i < yi.length; i++) {
            xi[0] = 1.0;
            System.arraycopy(xij[i], 0, xi, 1, xij[i].length);
            double p = yi[i];
            double q = linkFunc(regression(b, xi, nDist.sample()));

            for(int j = 0; j < b.length; j++) {
                bh[i][j] = 
                    Math.log(p * xi[j]) - q * (Math.log(q) - Math.log(p * xi[j]));
            }
        }
        return bh;
    }
    // M-Step
    //  (Maximiation:KLダイバージェンス)
    private double[] calcMStep(double[] yi, double[][] q, double[][] xij) {
        double[] xi = new double[1 + xij[0].length];
        double[] ei = new double[1 + xij[0].length];

        Arrays.fill(ei, 0.0);
        for(int j = 0; j < xi.length; j++) {
            for(int i = 0; i < xij.length; i++) {
                xi[0] = 1.0;
                System.arraycopy(xij[i], 0, xi, 1, xij[0].length);

                double p = yi[i];

                ei[j] += q[i][j] * (Math.log(p * xi[j]) - Math.log(q[i][j]));
            }
            ei[j] = -1 * ei[j];
        }
        return ei;
    }   
}

