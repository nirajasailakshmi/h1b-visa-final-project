#!/bin/bash 
show_menu()
{
    NORMAL=`echo "\033[m"`
    MENU=`echo "\033[36m"` #Blue
    NUMBER=`echo "\033[33m"` #yellow
    FGRED=`echo "\033[41m"`
    RED_TEXT=`echo "\033[31m"`
    ENTER_LINE=`echo "\033[33m"`
    echo -e "${MENU}**********************H1B _FINAL***********************${NORMAL}"
    echo -e "${MENU}**${NUMBER} 1) ${MENU} Is the number of petitions with Data Engineer job title increasing over time?${NORMAL}"
    echo -e "${MENU}**${NUMBER} 2) ${MENU} Find top 5 job titles who are having highest growth in applications. ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 3) ${MENU} Which part of the US has the most Data Engineer jobs for each year? ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 4) ${MENU} find top 5 locations in the US who have got certified visa for each year.${NORMAL}"
    echo -e "${MENU}**${NUMBER} 5) ${MENU} Which industry has the most number of Data Scientist positions?${NORMAL}"
    echo -e "${MENU}**${NUMBER} 6) ${MENU} Which top 5 employers file the most petitions each year? ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 7) ${MENU} Find the most popular top 10 job positions for H1B visa applications for each year?${NORMAL}"
    echo -e "${MENU}**${NUMBER} 8) ${MENU} Find the percentage and the count of each case status on total applications for each year. Create a graph depicting the pattern of All the cases over the period of time.${NORMAL}"
    echo -e "${MENU}**${NUMBER} 9) ${MENU} Create a bar graph to depict the number of applications for each year${NORMAL}"
    echo -e "${MENU}**${NUMBER} 10) ${MENU}Find the average Prevailing Wage for each Job for each Year (take part time and full time separate) arrange output in descending order${NORMAL}"
    echo -e "${MENU}**${NUMBER} 11) ${MENU} Which are employers who have the highest success rate in petitions more than 70% in petitions and total petions filed more than 1000?${NORMAL}"
    echo -e "${MENU}**${NUMBER} 12) ${MENU} Which are the top 10 job positions which have the  success rate more than 70% in petitions and total petitions filed more than 1000? ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 13) ${MENU}Export result for option no 12 to MySQL database.${NORMAL}"
    echo -e "${MENU}*********************************************${NORMAL}"
    echo -e "${ENTER_LINE}Please enter a menu option and enter or ${RED_TEXT}enter to exit. ${NORMAL}"
    read opt
}
function option_picked() 
{
    COLOR='\033[01;31m' # bold red
    RESET='\033[00;00m' # normal white
    MESSAGE="$1"  #modified to post the correct option selected
    echo -e "${COLOR}${MESSAGE}${RESET}"
}
clear
show_menu
	while [ opt != '' ]
    do
    if [[ $opt = "" ]]; then 
            exit;
    else
        case $opt in
        1) clear;
        option_picked "1 a) Is the number of petitions with Data Engineer job title increasing over time?";
        start-all.sh
		echo -e "Enter the year (2011,2012,2013,2014,2015,2016)"
                 read var
         hive -e "select year,job_title,count(year) from h1b_final where job_title LIKE '%DATA ENGINEER%' group by year,job_title;"
         show_menu;
        ;;
        2) clear;
        option_picked "1 b) Find top 5 job titles who are having highest growth in applications. ";
        stop-all.sh
		pig -x local /home/hduser/final project data/pig files/1b.pig
        show_menu;
        ;;  
        3) clear;
        option_picked "2 a) Which part of the US has the most Data Engineer jobs for each year?";
          start-all.sh
		echo -e "Enter the year (2011,2012,2013,2014,2015,2016)"
                 read var
         hive -e "select split(worksite,'[,]')[1] as state, job_title,count(split(worksite,'[,]')[1]) as job_cnt from h1b_final where job_title LIKE '%DATA ENGINEER%' group by job_title,split(worksite,'[,]')[1] order by job_cnt desc;"

        show_menu;
        ;;
	    4) clear;
        option_picked "2 b) find top 5 locations in the US who have got certified visa for each year.";
         start-all.sh

        echo -e "Enter the year (2011,2012,2013,2014,2015,2016)"
		read var
	    hive -e " select worksite,year,count(worksite) as cnt,case_status from h1b_final where case_status ='CERTIFIED' and year='2011' group by worksite,year,case_status order by cnt desc limit 5;"

        show_menu;
        ;;  
	    5) clear;
        option_picked "3) Which industry has the most number of Data Scientist positions?";
        start-all.sh  
      echo -e "Enter the year (2011,2012,2013,2014,2015,2016)"
		read var
	    hive -e "select soc_name ,count(soc_name) as cnt from h1b_final where job_title like '%Data Scientists%' group by soc_name order by cnt desc;"
    D:\workspace/WinSCP/Output jar/home/hduser


        show_menu;
        ;;
        6) clear;
        option_picked "4)Which top 5 employers file the most petitions each year?";
		start-all.sh        
		echo -e "Enter the year (2011,2012,2013,2014,2015,2016)"
		read var
	    hive -e "select * from y21 union all select * from y22 union all select * from y23 union all select * from y24 union all select * from y25 union all select * from y26 order by year;"

        show_menu;
        ;;
        7) clear;
        option_picked "5) Find the most popular top 10 job positions for H1B visa applications for each year?";

                     "a) for all applications?"
	    echo -e "Enter the year (2011,2012,2013,2014,2015,2016)"
		read var
		hive -e "select * from year21 union all select * from year22 union all select * from year23 union all select * from year24 union all select * from year25 union all select * from year26 order by year;"

                 "b) for only certified applications ?"
echo -e "Enter the year (2011,2012,2013,2014,2015,2016)"
		read var
		hive -e "select * from year11 union all select * from year12 union all select * from year13 union all select * from year14 union all select * from year15 union all select * from year16 order by year;"

        show_menu;
        ;;
        8) clear;
       	stop-all.sh
		option_picked "6) Find the percentage and the count of each case status on total applications for each year. Create a graph depicting the pattern of All the cases over the period of time.";
		pig -x local /home/hduser/final project data/pig files/6a.pig
        show_menu;
        ;;
		9) clear;
		start-all.sh
		sleep 6
        option_picked "7) Create a bar graph to depict the number of applications for each year";
		hive -e "select year,count(*) as applications  from h1b_final group by  year order by year;"
        show_menu;
        ;;
		10) clear;
        option_picked "8) Find the average Prevailing Wage for each Job for each Year (take part time and full time separate) arrange output in descending order";
		echo -e "Enter the year(2011,2012,2013,2014,2015,2016)"
		read year
		echo -e "Enter the choice Full time/ Part time.(Y/N)"
		read var
        hive -e "select year,job_title,AVG(prevailing_wage) as average from h1b_final where full_time_position='Y' and prevailing_wage is not null group by job_title,year order by average desc;"

        hive -e "select year,job_title,AVG(prevailing_wage) as average from h1b_final where full_time_position='N' and prevailing_wage is not null group by job_title,year order by average desc;"
              show_menu;
                ;;
		11) clear;
		stop-all.sh
		option_picked "9) Which are   employers who have the highest success rate in petitions more than 70% in petitions and total petions filed more than 1000?"
		stop-all.sh
		pig -x local /home/hduser/final project data/pig files/9.pig
    D:\workspace/WinSCP/Output jar/home/hduser
           show_menu;
                ;;
		12) clear;
		stop-all.sh
		option_picked "10) Which are the top 10 job positions which have the  success rate more than 70% in petitions and total petitions filed more than 1000?"
		stop-all.sh
		
		pig -x local /home/hduser/final project data/pig files/10.pig
     D:\workspace/WinSCP/Output jar/home/hduser
		
        show_menu;
        ;;
		13) clear;
		option_picked "Now lets export the question10 to MySql"
		sqoop export --connect jdbc:mysql://localhost/employee --username root --password 'sairam' --table exportAns10 --update-mode allowinsert --update-key employee_id --export-dir /niit/employee.txt --input-fields-terminated-by '\t' ;

		
        show_menu;
        ;;
		\n) exit;   
		;;
        *) clear;
        option_picked "Pick an option from the menu";
        show_menu;
        ;;
    esac
fi

done
