package pg10;
import java.io.*;
import java.net.*;
import java.util.Scanner;
class UDPServer{
public static void main(String args[])throws Exception
{
DatagramSocket serverSocket=new DatagramSocket(9876);
System.out.println("Server started");
byte[] sendData=new byte[1024];
byte[] recvData=new byte[1024];
DatagramPacket recvPacket=new DatagramPacket(recvData,recvData.length);
serverSocket.receive(recvPacket);
recvPacket.getData();
InetAddress IPAddress=recvPacket.getAddress();
int port=recvPacket.getPort();
System.out.println("client connected");
Scanner input=new Scanner(System.in);
System.out.println("Enter the message to be sent :");
String msg=input.nextLine();
sendData=msg.getBytes();
DatagramPacket sendPacket=new DatagramPacket(sendData,sendData.length,IPAddress,port);
serverSocket.send(sendPacket);
System.exit(0);
serverSocket.close();
input.close();
}
}

 