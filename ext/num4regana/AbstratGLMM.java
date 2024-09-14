import java.util.Arrays;
import org.apache.commons.math3.distribution.BetaDistribution;

abstract class AbstratGLMM {
    abstract double rereion(double[] b, double[] xi, double r);
    abstract double linkFunc(double q);
    protected double[] mcmc(double[] yi, double[] b, double[][] xij) {
        double[] bnew = new double[1 + xij[0].length];
        BetaDistribution beDist = new BetaDistribution(1,1);

        for(int i= 0; i < bnew.length; i++) {
System.out.printf("%f ", beDist.sample());
        }
        System.out.println();
        return null;
    }    
}

