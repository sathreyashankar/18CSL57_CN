package pg8;
import java.util.Scanner;

public class bellmanFord {
    public static void BellmanFord(int numvertex, int source, int numedges, int edgemat[][]){
        int srcdist[] = new int[numedges];
        for(int i = 1; i<=numvertex; i++){
            srcdist[i] = 999;
        }
        srcdist[source] = 0;
        for(int i = 1; i <= numvertex; i++){
            for(int j = 1; j<= numedges; j++){
                int u = edgemat[j][0];
                int v = edgemat[j][1];
                int w = edgemat[j][2];
                if(srcdist[v] > srcdist[u] + w){
                    srcdist[v] = srcdist[u] + w;
                }
            }
        }
        System.out.println("The solution : ");
        for(int i = 1; i <= numvertex; i++){
            System.out.println("The distance from " + source + " to " + i + " is : " + srcdist[i]);
        }
    }

    public static void main(String[] args) {
        Scanner s = new Scanner(System.in);
        System.out.println("Enter number of vertices in the graph");
        int numvertex = s.nextInt();
        System.out.println("Enter number of edges in the grapg");
        int numedges = s.nextInt();
        System.out.println("Enter the matrix: [from, to, cost]");
        int[][] edgemat = new int[numedges+1][3];
        for(int i = 1;i <= numedges; i++){
            edgemat[i][0] = s.nextInt();
            edgemat[i][1] = s.nextInt();
            edgemat[i][2] = s.nextInt();
        }
        System.out.println("Enter Source Vertex");
        int source = s.nextInt();
        BellmanFord(numvertex, source, numedges, edgemat);
        s.close();
    }
}
