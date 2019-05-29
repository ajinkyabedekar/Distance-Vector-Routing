set ns [new Simulator]
set f [open out.tr w]
$ns trace-all $f
set nf [open out.nam w]
$ns namtrace-all $nf
$ns rtproto DV

proc finish {} {
	global ns nf f
	$ns flush-trace
	close $f
	close $nf
	exec nam out.nam &
	exit 0
}

#for {set i 0} {$i < 6} {incr i} {
#	set n($i) [$ns node]
#}

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]

#for {set i 0} {$i < 6} {incr i} {
#	$ns duplex-link $n($i) $n([expr ($i+1)%6]) 1Mb 10ms DropTail
#}

$ns duplex-link $n0 $n1 1Mb 10ms DropTail
$ns duplex-link $n1 $n2 1Mb 10ms DropTail
$ns duplex-link $n2 $n3 1Mb 10ms DropTail
$ns duplex-link $n3 $n4 1Mb 10ms DropTail
$ns duplex-link $n4 $n5 1Mb 10ms DropTail
$ns duplex-link $n5 $n0 1Mb 10ms DropTail

set udp0 [new Agent/UDP]
$ns attach-agent $n0 $udp0

set cbr0 [new Application/Traffic/CBR]
$cbr0 set packetSize_ 500
$cbr0 set interval_ 0.005
$cbr0 attach-agent $udp0

set null0 [new Agent/Null]
$ns attach-agent $n3 $null0

$ns connect $udp0 $null0

$ns at 1.0 "$cbr0 start"

$ns rtmodel-at 2.0 down $n2 $n3
$ns rtmodel-at 4.0 up $n2 $n3

$ns at 5.0 "$cbr0 stop"

$ns at 7.0 "finish"

$ns run
