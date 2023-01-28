# This script is created by NSG2 beta1
# <http://wushoupong.googlepages.com/nsg>

#===================================
#     Simulation parameters setup
#===================================
set val(chan)   Channel/WirelessChannel    ;# channel type
set val(type) GSM
set val(prop)   Propagation/TwoRayGround   ;# radio-propagation model
set val(netif)  Phy/WirelessPhy            ;# network interface type
set val(mac)    Mac/802_11                 ;# MAC type
set val(ifq)    Queue/DropTail/PriQueue    ;# interface queue type
set val(ll)     LL                         ;# link layer type
set val(ant)    Antenna/OmniAntenna        ;# antenna model
set val(ifqlen) 50                         ;# max packet in ifq
set val(nn)     10                         ;# number of mobilenodes
set val(rp)     DSDV                       ;# routing protocol
set val(x)      1202                      ;# X dimension of topography
set val(y)      504                      ;# Y dimension of topography
set val(stop)   10.0                         ;# time of simulation end

#===================================
#        Initialization        
#===================================
#Create a ns simulator
set ns [new Simulator]

#Setup topography object
set topo       [new Topography]
$topo load_flatgrid $val(x) $val(y)
create-god $val(nn)

#Open the NS trace file
set tracefile [open out.tr w]
$ns trace-all $tracefile

#Open the NAM trace file
set namfile [open out.nam w]
$ns namtrace-all $namfile
$ns namtrace-all-wireless $namfile $val(x) $val(y)
set chan [new $val(chan)];#Create wireless channel

#===================================
#     Mobile node parameter setup
#===================================
$ns node-config -adhocRouting  $val(rp) \
                -llType        $val(ll) \
                -macType       $val(mac) \
                -ifqType       $val(ifq) \
                -ifqLen        $val(ifqlen) \
                -antType       $val(ant) \
                -propType      $val(prop) \
                -phyType       $val(netif) \
                -channel       $chan \
                -topoInstance  $topo \
                -agentTrace    ON \
                -routerTrace   ON \
                -macTrace      ON \
                -movementTrace ON

#===================================
#        Nodes Definition        
#===================================
#Create 10 nodes
set n0 [$ns node]
$n0 set X_ 300
$n0 set Y_ 398
$n0 set Z_ 0.0
set x1(0) 424
set y1(0) 479
$ns initial_node_pos $n0 20
set n1 [$ns node]
$n1 set X_ 503
$n1 set Y_ 401
$n1 set Z_ 0.0
set x1(1) 424
set y1(1) 479
$ns initial_node_pos $n1 20
set n2 [$ns node]
$n2 set X_ 701
$n2 set Y_ 400
$n2 set Z_ 0.0
set x1(2) 624
set y1(2) 479
$ns initial_node_pos $n2 20
set n3 [$ns node]
$n3 set X_ 899
$n3 set Y_ 404
$n3 set Z_ 0.0
set x1(3) 456
set y1(3) 645
$ns initial_node_pos $n3 20
set n4 [$ns node]
$n4 set X_ 1102
$n4 set Y_ 399
$n4 set Z_ 0.0
set x1(4) 546
set y1(4) 654
$ns initial_node_pos $n4 20
set n5 [$ns node]
$n5 set X_ 295
$n5 set Y_ 201
$n5 set Z_ 0.0
set x1(5) 765
set y1(5) 657
$ns initial_node_pos $n5 20
set n6 [$ns node]
$n6 set X_ 504
$n6 set Y_ 199
$n6 set Z_ 0.0
set x1(6) 487
set y1(6) 564
$ns initial_node_pos $n6 20
set n7 [$ns node]
$n7 set X_ 699
$n7 set Y_ 204
$n7 set Z_ 0.0
set x1(7) 654
set y1(7) 456
$ns initial_node_pos $n7 20
set n8 [$ns node]
$n8 set X_ 902
$n8 set Y_ 198
$n8 set Z_ 0.0
set x1(8) 567
set y1(8) 657
$ns initial_node_pos $n8 20
set n9 [$ns node]
$n9 set X_ 1100
$n9 set Y_ 198
$n9 set Z_ 0.0
set x1(9) 456
set y1(9) 546
$ns initial_node_pos $n9 20

puts "__________________________________________________"
set m 0
puts "__________________________________________________"
puts "|node| one hop neighbour|"
puts "__________________________________________________"
for { set i 0} {$i<$val(nn)} {incr i} {
set k 0
for { set j 0} {$j<$val(nn)} {incr j} {
set a [expr $x1($j) - $x1($i)]
set b [expr $a*$a]
set c [expr $y1($j) - $y1($i)] 
set d [expr $c*$c]
set e [expr $b+$d]
set f 0.5
set g [expr pow($e, $f)]
if { $g <= 200 && $i != $j} {
puts "| node($i) | node($j) |"
set nei($m) $j
set k [expr $k+1]
set m [expr $m+1]
}
}
}
puts "Loading connection pattern..."
puts "Loading scenario file"
#===================================
#        Agents Definition        
#===================================
#Setup a UDP connection
set udp0 [new Agent/UDP]
$ns attach-agent $n0 $udp0
set null1 [new Agent/Null]
set sink [new Agent/LossMonitor]
$ns attach-agent $ns7 $sink
$ns attach-agent $n9 $null1
$ns connect $udp0 $null1
$udp0 set packetSize_ 1500


#===================================
#        Applications Definition        
#===================================
#Setup a CBR Application over UDP connection
set cbr0 [new Application/Traffic/CBR]
$cbr0 attach-agent $udp0
$cbr0 set packetSize_ 1000
$cbr0 set rate_ 1.0Mb
$cbr0 set random_ null
$ns at 1.0 "$cbr0 start"
$ns at 2.0 "$cbr0 stop"


#===================================
#        Termination        
#===================================
#Define a 'finish' procedure
proc finish {} {
    global ns tracefile namfile
    $ns flush-trace
    close $tracefile
    close $namfile
    exec nam out.nam &
    exec xgraph throughput.tr &
    exec xgraph cost.tr &
    exec xgraph delay.tr &
    exit 0
}
for {set i 0} {$i < $val(nn) } { incr i } {
    $ns at $val(stop) "\$n$i reset"
}
$ns at $val(stop) "$ns nam-end-wireless $val(stop)"
$ns at $val(stop) "finish"
$ns at $val(stop) "puts \"done\" ; $ns halt"
$ns run