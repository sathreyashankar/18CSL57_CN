# This script is created by NSG2 beta1
# <http://wushoupong.googlepages.com/nsg>

#===================================
#     Simulation parameters setup
#===================================
set val(stop)   10.0                         ;# time of simulation end

#===================================
#        Initialization        
#===================================
#Create a ns simulator
set ns [new Simulator]

#Open the NS trace file
set tracefile [open pg3.tr w]
$ns trace-all $tracefile

#Open the NAM trace file
set namfile [open pg3.nam w]
$ns namtrace-all $namfile

#...use some flat file to create congestion graph windows
set WinFile0 [open WinFileReno w]
set WinFile1 [open WinFileNewReno w]

#===================================
#        Nodes Definition        
#===================================
#Create 6 nodes
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]

#...set color
$ns color 1 Red
$ns color 2 Blue
 

#===================================
#        Links Definition        
#===================================
#Createlinks between nodes
$ns duplex-link $n0 $n1 100.0Mb 10ms DropTail
$ns queue-limit $n0 $n1 50
$ns duplex-link-op $n0 $n1 color "blue"
$ns duplex-link $n1 $n2 100.0Mb 10ms DropTail
$ns queue-limit $n1 $n2 50
$ns duplex-link $n1 $n3 100.0Mb 10ms DropTail
$ns queue-limit $n1 $n3 50
$ns duplex-link-op $n1 $n3 color "green"

#Give node position (for NAM)
$ns duplex-link-op $n0 $n1 orient right-down
$ns duplex-link-op $n1 $n2 orient left-down
$ns duplex-link-op $n1 $n3 orient right

set lan [$ns newLan "$n3 $n4 $n5" 1Mb 40ms LL Queue / DropTail Mac / 802_3 Channel]

proc PlotWindow {tcpSource file} {
global ns
set time 0.1
set now [$ns now]
set cwnd [$tcpSource set cwnd_]
puts $file "$now $cwnd"
$ns at [expr $now+$time] "PlotWindow $tcpSource $file"
}


#===================================
#        Agents Definition        
#===================================
#Setup a TCP/Reno connection
set tcp0 [new Agent/TCP/Reno]
$tcp0 set window_ 8000
$tcp0 set fid_ 1
$ns attach-agent $n0 $tcp0
set sink1 [new Agent/TCPSink]
$ns attach-agent $n4 $sink1
$ns connect $tcp0 $sink1
$tcp0 set packetSize_ 1500

#Setup a TCP/Newreno connection
set tcp2 [new Agent/TCP/Newreno]
$tcp2 set window_ 8000
$tcp2 set fid_ 2
$ns attach-agent $n2 $tcp2
set sink3 [new Agent/TCPSink]
$ns attach-agent $n5 $sink3
$ns connect $tcp2 $sink3
$tcp2 set packetSize_ 1500


#===================================
#        Applications Definition        
#===================================
#Setup a FTP Application over TCP/Reno connection
set ftp0 [new Application/FTP]
$ftp0 attach-agent $tcp0
$ns at 1.0 "$ftp0 start"
$ns at 0.1 "PlotWindow $tcp0 $WinFile0"
$ns at 2.0 "$ftp0 stop"

#Setup a FTP Application over TCP/Newreno connection
set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp2
$ns at 1.0 "$ftp1 start"
$ns at 0.1 "PlotWindow $tcp2 $WinFile1"
$ns at 2.0 "$ftp1 stop"


#===================================
#        Termination        
#===================================
#Define a 'finish' procedure
proc finish {} {
    global ns tracefile namfile
    $ns flush-trace
    close $tracefile
    close $namfile
    exec nam pg3.nam &
exec xgraph WinFileReno WinFileNewReno &
    exit 0
}
$ns at $val(stop) "$ns nam-end-wireless $val(stop)"
$ns at $val(stop) "finish"
$ns at $val(stop) "puts \"done\" ; $ns halt"
$ns run
