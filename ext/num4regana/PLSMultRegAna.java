import org.apache.commons.math3.stat.regression.OLSMultipleLinearRegression;
import org.apache.commons.math3.stat.correlation.Covariance;
import org.apache.commons.math3.linear.EigenDecomposition;
import org.apache.commons.math3.linear.MatrixUtils;
import org.apache.commons.math3.linear.RealMatrix;

import org.apache.commons.math3.stat.StatUtils;

public class PLSMultRegAna {
    private static PLSMultRegAna regana = new PLSMultRegAna();
    public static PLSMultRegAna getInstance() {
        return regana;
    }
    public MultLineReg lineRegAna(double[] yi, double xij[][]) {
        PLS pls = new PLS();

        return pls.lineRegAna(yi, xij);
    }
    /*********************************/
    /* interface define              */
    /*********************************/
    /*********************************/
    /* class define                  */
    /*********************************/
    // 固有値・固有ベクトル
    private class Eigen {
        private double edVal= 0.0;     // 固有値
        private double[] edVec = null; // 固有ベクトル
        public Eigen(double edVal, double[] edVec) {
            this.edVal = edVal;
            this.edVec = edVec;
        }
        public double getEdVal()   { return this.edVal; }
        public double[] getEdVec() { return this.edVec; }
    }
    private class PLS {
        private OLSMultipleLinearRegression regression = 
            new OLSMultipleLinearRegression();
        public MultLineReg lineRegAna(double[] yi, double xij[][]) {
            PCA pca = new PCA(xij);

            regression.newSampleData(yi, pca.calcScores());
            double[] beta = regression.estimateRegressionParameters();

            return new MultLineReg(beta);
        }

    }
    private class PCA {
        private RealMatrix matrixAT = null;
        private int rowN = 0;
        private int colN = 0;
        public PCA(double xij[][]) {
            this.matrixAT = MatrixUtils.createRealMatrix(xij).transpose();
            this.rowN = matrixAT.getRow(0).length;
            this.colN = matrixAT.getColumn(0).length;
        }
        public double[][] calcScores() {
            double[][] scs = new double[rowN][colN];
            // 分散行列作成
            RealMatrix matrixA = calcCovatrianceMatrix();
            // 固有値・固有ベクトル計算
            Eigen[] eds = calcEigenVector(matrixA);
            // 主成分得点を計算する
            double[] means = calcMean();
            int i = 0;  // col

            for(Eigen ed : eds) {
                double edVal = ed.getEdVal();
                double[] edVec = ed.getEdVec();
                double[] score = calcScore(edVec, means);

                for(int j = 0; j < rowN; j++) {
                    scs[j][i] = score[j];
                }
                i++;
            }
            return scs;
        }
        public double[] calcScore(double[] edVec, double[] means) {
            double[] scores = new double[rowN];

            for(int i = 0; i < edVec.length; i++) {
                double[] dt = matrixAT.getRow(i);

                for(int j = 0; j < dt.length; j++) {
                    scores[j] += edVec[i] * (dt[j] - means[i]);
                }
            }
            return scores;
        }
        private RealMatrix calcCovatrianceMatrix(){
            Covariance corel = new Covariance();
            double[][] omg = new double[colN][colN];

            for(int i = 0; i < colN; i++) {
                for(int j = 0; j < colN; j++) {
                    double[] xArray = matrixAT.getRow(i);
                    double[] yArray = matrixAT.getRow(j);

                    omg[i][j] = corel.covariance(xArray, yArray);
                }
            }
            return MatrixUtils.createRealMatrix(omg);
        }
        private Eigen[] calcEigenVector(RealMatrix matrixA) {
            // 固有値計算
            EigenDecomposition ed = new EigenDecomposition(matrixA);
            double[] eigens = ed.getRealEigenvalues();
            Eigen[] eds = new Eigen[eigens.length];
            // 固有値を求め、それの固有ベクトルを求める
            for(int i = 0; i < eigens.length; i++) {
                double[] evs = ed.getEigenvector(i).toArray();
                eds[i] = new Eigen(eigens[i], evs);
            }
            return eds;
        }
        // 平均を求める
        private double[] calcMean() {
            double[] means = new double[colN];

            for(int i= 0; i < means.length; i++) {
                double[] dt = matrixAT.getRow(i);

                means[i] = StatUtils.mean(dt);
            }
            return means;
        }
    }
}

