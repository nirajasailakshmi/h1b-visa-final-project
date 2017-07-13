 bag=load '/user/hive/warehouse/h1b_final' using PigStorage() as (s_no:int,case_status:chararray,employer_name:chararray,soc_name:chararray,job_title:chararray,full_time_position:chararray,prevailing_wage:int,year:chararray,worksite:chararray,longitude:double,latitude:double);
	

p1= filter bag by $7=='2011';
q1= group p1 by $4;								
r1= foreach q1 generate group,COUNT($1);				


p2= filter bag by $7=='2012'; 
q2= group p2 by $4;								
r2= foreach q2 generate group,COUNT($1);				


p3= filter bag  by $7=='2013'; 
q3= group p3 by $4;								
r3= foreach q3 generate group,COUNT($1);				

p4= filter bag  by $7=='2014'; 
q4= group p4 by $4;								
r4= foreach q4 generate group,COUNT($1);				

p5= filter bag  by $7=='2015'; 
q5= group p5 by $4;								
r5= foreach q5 generate group,COUNT($1);				


p6= filter bag by $7=='2016'; 
q6= group p6 by $4;								
r6= foreach q6 generate group,COUNT($1);				

joined= join r1 by $0,r2 by $0,r3 by $0,r4 by $0,r5 by $0,r6 by $0;
yearwiseapplications= foreach joined generate $0,$1,$3,$5,$7,$9,$11;

progressivegrowth= foreach yearwiseapplications  generate $0,
(float)($6-$5)*100/$5,(float)($5-$4)*100/$4,
(float)($4-$3)*100/$3,(float)($3-$2)*100/$2,
(float)($2-$1)*100/$1;

avg_growth_percent = foreach growth_percent generate $0,(($1+$2+$3+$4+$5)/5);
	
order_agp = order avg_growth_percent by $1 desc;
	
top5 = limit order_agp 5;
	
dump top5;


    




