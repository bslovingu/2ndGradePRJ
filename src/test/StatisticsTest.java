package test;

public class StatisticsTest {

	public static void main(String[] args) {
		// TODO Auto-generated method stub

		double k = 1000.0;
		double y = 10.0;
		double m = 1.96;

		double res_tmp = (Math.sqrt(1 / y)) * (m / 2);
		System.out.println(res_tmp);
	
		double res = (res_tmp * (Math.sqrt((k-y)/(k-1))));
		System.out.println(res);

	}

}
