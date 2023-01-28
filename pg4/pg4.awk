BEGIN
{
    count=0
    packet=0
    time=0
}

{
    if($1=="r" && $3=="_3_" && $4=="RTR")
    {
        count++
        packet=packet+$8
        time=$2
    }
}

END
{
    printf("The throughput from the sender node to the receiver node is %f Mbps.", ((count*packet*8)/(time*1000000)));
}