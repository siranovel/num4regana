public class MultLineReg {
    private double a   = 0.0;
    private double[] b = null;
    public MultLineReg(double[] b) {
        this.a = b[0];
        this.b = new double[b.length - 1];
        System.arraycopy(b, 1, this.b, 0, this.b.length);
    }
    public double getIntercept() {
        return a;
    }
    public double[] getSlope() {
        return b;
    }
}

