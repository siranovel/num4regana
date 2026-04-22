import java.util.Arrays;
import java.util.Map;
import java.util.HashMap;
import org.apache.commons.math3.analysis.function.Sigmoid;

public class LogitRegAna extends AbstractGLM {
    private final int NUM = 1000;
    private static LogitRegAna regana = new LogitRegAna();
    private Sigmoid sigmoid = new Sigmoid();
    public static LogitRegAna getInstance() {
        return regana;
    }
    public MultLineReg nonLineRegAna(double[] yi, double xij[][]) {
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
    public Map<String, Double> validity(double[] yi, Map<String, Object> regCoe, double[][] xij, double threshold) {
        Validity va = new Validity();

        return va.validity(yi, regCoe, xij, threshold);
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
    // p = 1 / (1 + exp(-q))
    double linkFunc(double q) {
        return sigmoid.value(q);
    }
    /*********************************/
    /* interface define              */
    /*********************************/
    /*********************************/
    /* class define                  */
    /*********************************/
    private class Validity {
        private int act_0 = 0;         // 実測値 0
        private int act_1 = 0;         // 実測値 1
        private int[][] predict = new int[2][2]; // predict[実測値][
        private double tp = 0.0;       // 実測値=1 予測値 = 1
        private double fn = 0.0;       // 実測値=1 予測値 = 0
        private double fp = 0.0;       // 実測値=0 予測値 = 1
        private double tn = 0.0;       // 実測値=0 予測値 = 0
        public Map<String, Double> validity(double[] yi, Map<String, Object> regCoe, double[][] xij, double threshold) {
            test(yi, regCoe, xij, threshold);

            return preciIndex();       // 分類問題の精度指標
        }
        private void test(double[] yi, Map<String, Object> regCoe, double[][] xij, double threshold) {
            int n = yi.length;

            for(int i = 0; i < n; i++) {
                int sc = score(regCoe, xij[i], threshold);
                if (1.0 == yi[i]) { act_1++; predict[1][sc]++; }
                if (0.0 == yi[i]) { act_0++; predict[0][sc]++; }
            }
            tp = (double)predict[1][1] / (double)act_1;
            fn = (double)predict[1][0] / (double)act_1;
            fp = (double)predict[0][1] / (double)act_0;
            tn = (double)predict[0][0] / (double)act_0;
        }
        private int score(Map<String, Object> regCoe, double[] xi, double threshold) {
            double[] b = new double[1 + xi.length];
            double[] wxi = new double[b.length];

            b[0] = (double)regCoe.get("intercept");
            System.arraycopy(regCoe.get("slope"), 0, b, 1, xi.length);
            wxi[0] = 1.0;
            System.arraycopy(xi, 0, wxi, 1, xi.length);
            double z = linkFunc(regression(b, wxi));
            return z < threshold ? 0 : 1;
        }        
        private Map<String, Double> preciIndex() {
            Map<String, Double> retMap = new HashMap<String, Double>();

            // 精度・正確度
            retMap.put("accuracy", (tp+tn)/(tp+fp+tn+fn));
            // 適合度
            retMap.put("precision", tp/(tp+fp));
            // 再現度
            retMap.put("recall", tp/(tp+fn));
            // 感度=再現率
            retMap.put("sensitivity", tp/(tp+fn));
            // 特異度
            retMap.put("specificity", tn/(fp+tn));
            // 陽性敵中率=適合度
            retMap.put("ppv", tp/(tp+fp));
            // 陰性的中率
            retMap.put("npv", tn/(tn+fn));
            // 真陽性率=再現率・感度
            retMap.put("tpr", tp/(tp+fn));
            // 偽陽性率
            retMap.put("fpr", fp/(fp+tn));
            // 真陰性率
            retMap.put("tnr", tn/(fp+tn));
            // 偽陰性率
            retMap.put("fnr", fn/(tp+fn));
            return retMap;
        }
    }
}

