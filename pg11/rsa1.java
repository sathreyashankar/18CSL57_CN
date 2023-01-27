package pg11;

import java.util.Scanner;

public class rsa1 {
    public static int multi(int x, int y, int n) {
        int k=1;
        for(int j = 1; j <= y; j++) {
            k = (k * x) % n;
        }
        return k;
    }
    public static int gcd(int m, int n) {
        return (n == 0 ? m : gcd(n, m%n));
    }
    public static void main(String[] args) {
        Scanner s = new Scanner(System.in);
        int msg, ct, pt, p, q, z, d, e, n;
        System.out.println("Enter prime nos p and q");
        p = s.nextInt();
        q = s.nextInt();
        System.out.println("Enter the message: ");
        msg = s.nextInt();
        n = p*q;
        z = (p-1)*(q-1);
        d = z;
        do {
            System.out.println("Eneter e such that relatively prime to z");
            e = s.nextInt();
        }while(gcd(e, z)!=1);
        while((e*d)%z!=1){
            d++;
        }
        System.out.println("Private key is : " +e+", "+n);
        System.out.println("Public key is : " +d+", "+n);
        ct = multi(msg, e, n);
        pt = multi(ct, d, n);
        System.out.println("CipherText : " + ct +"\n" + "PlainText : " + pt );
        s.close();
    }

}
