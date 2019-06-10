BEGIN {
thr = 0;
	totalsize = 0;
	start = 0;
	stop = 0;
	thr1 = 0;
	totalsize1 = 0;
	start1 = 0;
	stop1 = 0;
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


	if (event == "+" && p_id == 0 && type== "crb" && from == 0)
		start[p_id] = time;
	if (event == "r" && to == 5 && src == 0 )
	{
		totalsize = totalsize + size;
		stop = time;
	}
	if (event == "+" && p_id == 0 && from == 1 )
		start1 = time;
	if (event == "r" && to == 5 && src == 1 )
	{
		totalsize1 = totalsize1 + size;
		stop1 = time;
	}


}
END {


	thr = (totalsize * 8) / ((stop - start) * 1000000);
	thr1 = (totalsize1 * 8) / ((stop1 - start1) * 1000000);
	printf("Throughput 0-5 = %0.2f Mbps\n", thr);
	printf("Throughput 1-5 = %0.2f Mbps\n", thr1);
		

}
