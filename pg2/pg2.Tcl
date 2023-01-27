set ns [new Simulator]
set tracefile [open pg2.tr w]
$ns trace-all $tracefile

set namfile [open pg2.nam w]
$ns namtrace-all $namfile

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]

$ns duplex-link $n0 $n1 100.0Mb 10ms DropTail
$ns queue-limit $n0 $n1 4
$ns duplex-link $n1 $n2 50.0Mb 10ms DropTail
$ns queue-limit $n1 $n2 4
$ns duplex-link $n2 $n3 1.0Mb 10ms DropTail
$ns queue-limit $n2 $n3 5
$ns duplex-link $n3 $n4 1.0Mb 10ms DropTail
$ns duplex-link $n4 $n5 10.0Mb 10ms DropTail

#set node position
$ns duplex-link-op $n0 $n1 orient right
$ns duplex-link-op $n1 $n2 orient right
$ns duplex-link-op $n2 $n3 orient right-down
$ns duplex-link-op $n3 $n4 orient left-down
$ns duplex-link-op $n4 $n5 orient left

#Procedure for Ping agent
Agent/Ping instproc recv {from rtt} {
$self instvar node_
puts "node [$node_ id]received ping answer from 1
#$from with round_trip_time $rtt ms"
}
$ns color 1 red
$ns color 2 blue

set p0 [new Agent/Ping]
$ns attach-agent $n0 $p0
$p0 set packetSize_ 50000

set p5 [new Agent/Ping]
$ns attach-agent $n5 $p5
$p5 set packetSize_ 50000
$p5 set fid_ 2

$ns connect $p0 $p5
$ns at 0.1 "$p0 send"                                        
$ns at 0.2 "$p0 send"                                     
$ns at 0.3 "$p0 send"                                      
$ns at 0.4 "$p0 send"                                         
$ns at 0.5 "$p0 send"                                             

$ns at 0.1 "$p5 send"                                       
$ns at 0.2 "$p5 send"                                    
$ns at 0.3 "$p5 send"                           
$ns at 0.4 "$p5 send"                                  
$ns at 0.5 "$p5 send"

proc finish {} {
global ns tracefile namfile
$ns flush-trace
close $tracefile
close $namfile
exec nam pg2.nam &
exec grep -c "^d" pg2.tr &

exit 0
}
puts "Simulation Start"
$ns run 
