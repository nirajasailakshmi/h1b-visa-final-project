bag1 = load '/user/hive/warehouse/h1b_final' using PigStorage() as (s_no:int,case_status:chararray,employer_name:chararray,soc_name:chararray,job_title:chararray,full_time_position:chararray,prevailing_wage:int,year:int,worksite:chararray,long:double,lati:double);

bag2 = group bag1 by year ; 

bag4 = foreach bag2 generate group as year,bag1.case_status;

bag5 = foreach bag4 generate year,FLATTEN($1);

split bag5 into bag6  if null::case_status =='CERTIFIED-WITHDRAWN',bag7 if null::case_status =='WITHDRAWN' ,bag8 if null::case_status =='CERTIFIED',bag9 if null::case_status =='DENIED'; 
 
bag10 = group bag6 by year ; 
  
bag11 = group bag7 by year ; 
 
bag12 = group bag8 by year;  

bag13 = group bag9 by year; 

bag14 = foreach bag10 generate group as year,COUNT(bag6.$1); 

bag15 = foreach bag11 generate group as year,COUNT(bag7.$1); 

bag16 = foreach bag12 generate group as year,COUNT(bag8.$1); 

bag17 = foreach bag13 generate group as year,COUNT(bag9.$1);

bag18 =join bag14 by $0,bag15 by $0,bag16 by $0,bag17 by $0;

total = foreach bag18 generate $0,$1,$3,$5,$7,$1+$3+$5+$7;

dump total;

sixthopt = foreach total generate $0,((double)$1/$5*100),((double)$2/$5*100),((double)$3/$5*100),((double)$4/$5*100);

dump sixthopt;




