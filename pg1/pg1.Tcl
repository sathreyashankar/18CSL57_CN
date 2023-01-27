#create simulator object
set ns [new Simulator]

#create tracefile
set tracefile [open pg1.tr w]
$ns trace-all $tracefile

#create namfile
set namfile [open pg1.nam w]
$ns namtrace-all $namfile

#create nodes
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]

#create links and set queue limits
$ns duplex-link $n0 $n1 1Mbps 10ms DropTail
$ns queue-limit $n0 $n1 5 
$ns duplex-link $n1 $n2 10Mbps 3ms DropTail
$ns queue-limit $n1 $n2 3

#set node position
$ns duplex-link-op $n0 $n1 orient right-down
$ns duplex-link-op $n1 $n2 orient left-down
$ns color 1 Red

#create agents
set tcp [new Agent/TCP]
set sink [new Agent/TCPSink]
$ns attach-agent $n0 $tcp
$ns attach-agent $n2 $sink
$tcp set PacketSize_ 2500

#Setting color for packet flowid
$tcp set fid_ 1


#Attach application protocol
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 1.0 "$ftp start"
$ns at 10.0 "finish"

proc Finish {} {
global ns tracefile namfile
$ns flush-trace
close $tracefile
close $namfile
exit 0
}
puts "Simulation Starts"
$ns run
