import java.util.*;
public class CRC {
        public static void main(String[] args) {
                int i, j, k, m, n, g[], d[], z[], r[], msb;
                Scanner s = new Scanner(System.in);
                System.out.println("Enter no. of data bits: ");
                n = s.nextInt();
                System.out.println("Enter no. of generator bits: ");
                m = s.nextInt();
                
                d = new int[m+n];
                System.out.println("Enter data bits: ");
                for(i = 0; i < n; i++)
                    d[i] = s.nextInt();
                
                g = new int[m];
                System.out.println("Enter generator bits: ");
                for(j = 0; j < m; j++)
                    g[j] = s.nextInt();
                
                for(i = 0; i < m-1; i++)
                    d[n+i] = 0;
                r = new int[m+n];
                for(i = 0; i < m+n; i++)
                    r[i] = d[i];
                z = new int[m];
                for(i = 0; i<m; i++)
                    z[i] = 0;
                for(i = 0; i < n; i++){
                    k = 0;
                    msb = r[i];
                    for(j = 0; j < m+i; j++){
                        if(msb == 0)
                            r[j] = xor(r[j], z[k]);
                        else
                            r[j] = xor(r[j], g[k]);
                    k++;
                    }
                    d[m+i] = r[m+i];
                }
                System.out.println("Code bits added are: " );
                for(i = n; i < m+n-1; i++){
                    d[i] = r[i]; 
                    System.out.println(d[i]);          
                }
                System.out.println("The code data is: ");
                for(i = 0; i < m+n-1; i++) {
                    System.out.println(d[i]);
                }  
                s.close();            
            }
            public static int xor(int x, int y) {
                if(x == y)
                return 0;
                else
                return 1;       
            }
}
