BEGIN {
	sent = 0;
	rec = 0;
	drop = 0;
}
{
	event = $1;
	time = $2;
	from = $3;
	to = $4;
	type = $5;
	size = $6;
	flowid = $8;
	src = $9;
	dest = $10;
	seq = $11;
	p_id = $12;
	if (event == "+" && from == 0)
		sent++;
	if (event == "r" && to == 3)
		rec++;
	if (event == "d" && from == 2)
		drop++;
}
END {
	printf("Number of Packets Sent = %d\n", sent);
	printf("Number of Packets Received = %d\n", rec);
	printf("Number of Packets Dropped = %d\n", drop);
}
