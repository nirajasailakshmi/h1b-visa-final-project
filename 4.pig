bag1 = load '/user/hive/warehouse/h1b_final' using PigStorage(',') as (s_no:int,case_status:chararray,employer_name:chararray,soc_name:chararray,job_title:chararray,full_time_position:chararray,prevailing_wage:int,year:chararray,worksite:chararray,longitude:double,latitude:double);

bag2 = group bag1 by (employer_name,year);

bag3 =  foreach bag2 generate group,COUNT(bag1);

bag4 = foreach bag3 generate FLATTEN(group),$1;

split bag4 into bag5 if year=='2011',bag6 if year=='2012',bag7 if year=='2013',bag8 if year=='2014',bag9 if year=='2015',bag10 if year =='2016';

bag9 = order bag5 by $2 desc;

bag10 = limit bag9 5;

bag11= order bag6 by $2 desc;

bag12 = limit bag11 5;

bag13= order bag7 by $2 desc;

bag14= limit bag13 5;

bag15= order bag8 by $2 desc;

bag16= limit bag15 5;

bag17= order bag9 by $2 desc;

bag18= limit bag17 5;

bag19= order bag10 by $2 desc;

bag20= limit bag19 5;

uniontotal= unionall bag10,bag12,bag14,bag16,bag18,bag20;

dump uniontotal;
