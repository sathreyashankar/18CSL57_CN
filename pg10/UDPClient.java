package pg10;

import java.io.*;
import java.net.*;
class UDPClient{
public static void main(String args[])throws Exception
{
BufferedReader inFromUser=new BufferedReader(new InputStreamReader(System.in));
DatagramSocket clientSocket=new DatagramSocket();
InetAddress IPAddress=InetAddress.getByName("localhost");
byte[] sendData=new byte[1024];
byte[] recvData=new byte[1024];
System.out.println("Enter start to connect to server");
String sentence=inFromUser.readLine();
sendData=sentence.getBytes();
DatagramPacket sendPacket=new DatagramPacket(sendData,sendData.length,IPAddress,9876);
clientSocket.send(sendPacket);
DatagramPacket recvPacket=new DatagramPacket(recvData,recvData.length);
clientSocket.receive(recvPacket);
String modifiedsentence=new String(recvPacket.getData());
System.out.println("Message received :"+modifiedsentence);
clientSocket.close();
}
}
