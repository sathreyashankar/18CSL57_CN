package pg11;
// import java.util.Scanner;

// public class RSA {
// 	public static int multi(int x, int y, int n) {
// 		int k = 1, j;
// 		for(j = 1; j <= y; j++) 
// 			k = (k * x)% n;
// 		return k;
// 	}
	
// 	public static int gcd(int m, int n) {
// 		if(n == 0)
// 			return m;
// 		else
// 			return (gcd(n, m%n));
// 	}
	
// 	public static void main(String[] args) {
// 		int msg, plaintext, ciphertext;
// 		int n, d = 0, e, z, p, q, i;
// 		Scanner s = new Scanner(System.in);
// 		System.out.println("Enter the value of prime p & q");
// 		p = s.nextInt();
// 		q = s.nextInt();
// 		System.out.println("Enter the message : ");
// 		msg = s.nextInt();
// 		n = p * q;
// 		z = (p - 1) * (q - 1);
// 		do {
// 			System.out.println("Chose the value of e such that gcd(z, e) = 1");
// 			e = s.nextInt();
// 		}while(gcd(z, e)!=1);
		
// 		i = 2;
// 		while( ( (i*e) % z ) != 1) {
// 			i++;
// 			d = i;
// 		}
		
// 		System.out.println("public key is (" + e + " , " + n + " ) " );
// 		System.out.println("private key is (" + d + " , " + n + " ) " );
		
// 		ciphertext = multi(msg, e, n);
// 		System.out.println("Ciphertext = " + ciphertext);
// 		plaintext = multi(ciphertext, d, n);
// 		System.out.println("Plaintext = " + plaintext);
// 		s.close();
// 	}
// }



import java.util.Scanner;
class Prog11{
    public static int mult(int text,int key1,int key2){
        int k=1;
        for(int i=1;i<=key1;i++)k=(k*text)%key2;
        return k;
    }
    public static int gcd(int m, int n){return n==0 ? m : gcd(n,m%n);}
    public static void main(String[] args){
        Scanner s = new Scanner(System.in);
        System.out.println("Enter 2 unique prime numbers");
        int p = s.nextInt();
        int q = s.nextInt();
        int n = p*q;
        int phi = (p-1)*(q-1);
        System.out.println("Enter message to be encryped (integer)");
        int m = s.nextInt();
        int e,d=phi;
        do{
            System.out.println("Enter an integer which isnt a factor of "+phi);
            e = s.nextInt();
        }while(gcd(phi,e)!=1);
        while((e*d)%phi!=1)d++;
        System.out.println("Public Key is "+e+","+n);
        System.out.println("Private Key is "+d+","+n);
        int cipherText = mult(m,e,n);
        System.out.println("CipherText: "+cipherText);
        int decipherText = mult(cipherText, d, n);
        System.out.println("DecipherText: "+decipherText);
        s.close();
    }
} 