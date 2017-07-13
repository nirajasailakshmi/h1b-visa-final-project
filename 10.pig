data = LOAD '/user/hive/warehouse/h1b_final' USING PigStorage(',') as 
(s_no:int,case_status:chararray,employer_name:chararray,soc_name:chararray,job_title:chararray,full_time_position:chararray,prevailing_wage:int,year:chararray,worksite:chararray,longitude:double,latitude:double);



cleansed= filter data by $1=='case_status';
temp= group cleansed by $4;
total= foreach temp generate group,COUNT(cleansed.$1);



certified= filter data by $1 == 'CERTIFIED';
temp1= group certified by $4;
totalcertified= foreach temp1 generate group,COUNT(certified.$1);


certifiedwithdrawn= filter data by $1 == 'CERTIFIED-WITHDRAWN';
temp2= group certifiedwithdrawn by $4;
totalcertifiedwithdrawn= foreach temp2 generate group,COUNT(certifiedwithdrawn.$1);



joined= join totalcertified by $0,totalcertifiedwithdrawn by $0,total by $0;

joined2= foreach joined generate $0,$1,$3,$5;

intermediateoutput= foreach joined2 generate $0,(float)($1+$2)*100/($3),$3;

intermediateoutput2= filter intermediateoutput by $1>70 and $2>1000;
	
finaloutput= order intermediateoutput2 by $1 DESC;

dump finaloutput;


