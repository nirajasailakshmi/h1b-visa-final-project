employers= load '/user/hive/warehouse/h1b_final' using PigStorage(',') as (s_no:int,case_status:chararray,employer_name:chararray,soc_name:chararray,job_title:chararray,full_time_position:chararray,prevailing_wage:int,year:chararray,worksite:chararray,long:double,lati:double);


cstatus= filter employers by $1=='case_status';

temp= group cstatus by $2;

total= foreach temp generate group,COUNT(cstatus.$1); 

certified= filter employers by $1 == 'CERTIFIED';

temp1= group certified by $2;

totalcertified= foreach temp1 generate group,COUNT(certified.$1); 

certifiedwithdrawn= filter employers by $1 == 'CERTIFIED-WITHDRAWN';

temp2= group certifiedwithdrawn by $2;

totalcertifiedwithdrawn= foreach temp2 generate group,COUNT(certifiedwithdrawn.$1);

joined= join totalcertified by $0,totalcertifiedwithdrawn by $0,total by $0;

joined1= foreach joined generate $0,$1,$3,$5;

intermediateoutput= foreach joined1 generate $0,(float)($1+$2)*100/($3),$3;

intermediateoutput2= filter intermediateoutput by $1>70 and $2>1000;
	 
finaloutput= order intermediateoutput2 by $1 DESC;

dump finaloutput;


