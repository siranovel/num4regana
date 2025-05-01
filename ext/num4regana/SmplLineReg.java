public class SmplLineReg {
    private double a = 0.0;
    private double b = 0.0;
    public SmplLineReg(double a, double b) {
        this.a = a;
        this.b = b;
    }
    public double getIntercept() {
        return a;
    }
    public double getSlope() {
        return b;
    }
}

