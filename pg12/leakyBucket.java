import java.util.Scanner;
public class leakyBucket {
    public static void main(String[] args) {
        int out, n, num; 
        Scanner s = new Scanner(System.in);
        System.out.println("Enter Bucket size: ");
        n = s.nextInt();
        System.out.println("Enetr set of packets: ");
        num = s.nextInt();
        System.out.println("Enter Data rate: ");
        int a[] = new int[n];
        for(int i = 0; i < num; i++)
            a[i] = s.nextInt();
        System.out.println("Enter Output Rate: ");
        out = s.nextInt();

        for(int i = 0; i < num; i++) {

            if(a[i] > n) {
                System.out.println("Bucket Overflow !!!");
            }
            else {
                if(a[i] == out) {
                    System.out.println("Transmitted data: " + a[i]);
                }
                else if(a[i] > out) {
                    while(a[i] != 0 && a[i] >out) {
                        System.out.println("Transmitted data:" + out);
                        a[i] = a[i] - out;
                    }
                    System.out.println("Transmitted data: "+a[i]);
                }
                
            }


        }
        s.close();

    }

}