package test;

import java.io.IOException;

public class FirstGrade {

	public static void main(String[] args) throws IOException {
		// TODO Auto-generated method stub

		String a = "2020.06.15. 오전 10:08";
		String b = "2020.06.15. 오전 8:03";
		System.out.println(a.length());
		System.out.println(b.length());
		
		int k = b.lastIndexOf(" ");
		b = b.substring(0, k+1) + "0" + b.substring(k+1);
				
		System.out.println(b);
		System.out.println(b.length());
	}

}
