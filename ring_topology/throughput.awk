BEGIN {
	thr = 0;
	totalsize = 0;
	start = 0;
	stop = 0;
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
	if (event == "+" && p_id == 0 && from == 0)
		start = time;
	if (event == "r" && to == 3)
	{
		totalsize = totalsize + size;
		stop = time;
	}
}
END {
	thr = (totalsize * 8) / (stop - start);
	printf("Throughput = %f bps\n", thr);
}
