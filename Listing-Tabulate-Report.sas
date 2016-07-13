data year_sales;
   input Month $ Quarter $ SalesRep $14. Type $ Units Price @@;
   AmountSold=Units*price;
   datalines;
01 1 Hollingsworth Deluxe    260 49.50 01 1 Garcia        Standard   41 30.97
01 1 Hollingsworth Standard  330 30.97 01 1 Jensen        Standard  110 30.97
01 1 Garcia        Deluxe    715 49.50 01 1 Jensen        Standard  675 30.97
02 1 Garcia        Standard 2045 30.97 02 1 Garcia        Deluxe     10 49.50
02 1 Garcia        Standard   40 30.97 02 1 Hollingsworth Standard 1030 30.97
02 1 Jensen        Standard  153 30.97 02 1 Garcia        Standard   98 30.97
03 1 Hollingsworth Standard  125 30.97 03 1 Jensen        Standard  154 30.97
03 1 Garcia        Standard  118 30.97 03 1 Hollingsworth Standard   25 30.97
03 1 Jensen        Standard  525 30.97 03 1 Garcia        Standard  310 30.97
04 2 Garcia        Standard  150 30.97 04 2 Hollingsworth Standard  260 30.97
04 2 Hollingsworth Standard  530 30.97 04 2 Jensen        Standard 1110 30.97
04 2 Garcia        Standard 1715 30.97 04 2 Jensen        Standard  675 30.97
05 2 Jensen        Standard   45 30.97 05 2 Hollingsworth Standard 1120 30.97
05 2 Garcia        Standard   40 30.97 05 2 Hollingsworth Standard 1030 30.97
05 2 Jensen        Standard  153 30.97 05 2 Garcia        Standard   98 30.97
06 2 Jensen        Standard  154 30.97 06 2 Hollingsworth Deluxe     25 49.50
06 2 Jensen        Standard  276 30.97 06 2 Hollingsworth Standard  125 30.97
06 2 Garcia        Standard  512 30.97 06 2 Garcia        Standard 1000 30.97
07 3 Garcia        Standard  250 30.97 07 3 Hollingsworth Deluxe     60 49.50
07 3 Garcia        Standard   90 30.97 07 3 Hollingsworth Deluxe     30 49.50
07 3 Jensen        Standard  110 30.97 07 3 Garcia        Standard   90 30.97
07 3 Hollingsworth Standard  130 30.97 07 3 Jensen        Standard  110 30.97
07 3 Garcia        Standard  265 30.97 07 3 Jensen        Standard  275 30.97
07 3 Garcia        Standard 1250 30.97 07 3 Hollingsworth Deluxe     60 49.50
07 3 Garcia        Standard   90 30.97 07 3 Jensen        Standard  110 30.97
07 3 Garcia        Standard   90 30.97 07 3 Hollingsworth Standard  330 30.97
07 3 Jensen        Standard  110 30.97 07 3 Garcia        Standard  465 30.97
07 3 Jensen        Standard  675 30.97 08 3 Jensen        Standard  145 30.97
08 3 Garcia        Deluxe    110 49.50 08 3 Hollingsworth Standard  120 30.97
08 3 Hollingsworth Standard  230 30.97 08 3 Jensen        Standard  453 30.97
08 3 Garcia        Standard  240 30.97 08 3 Hollingsworth Standard  230 49.50
08 3 Jensen        Standard  453 30.97 08 3 Garcia        Standard  198 30.97
08 3 Hollingsworth Standard  290 30.97 08 3 Garcia        Standard 1198 30.97
08 3 Jensen        Deluxe     45 49.50 08 3 Jensen        Standard  145 30.97
08 3 Garcia        Deluxe    110 49.50 08 3 Hollingsworth Standard  330 30.97
08 3 Garcia        Standard  240 30.97 08 3 Hollingsworth Deluxe     50 49.50
08 3 Jensen        Standard  453 30.97 08 3 Garcia        Standard  198 30.97
08 3 Jensen        Deluxe    225 49.50 09 3 Hollingsworth Standard  125 30.97
09 3 Jensen        Standard  254 30.97 09 3 Garcia        Standard  118 30.97
09 3 Hollingsworth Standard 1000 30.97 09 3 Jensen        Standard  284 30.97
09 3 Garcia        Standard  412 30.97 09 3 Jensen        Deluxe    275 49.50
09 3 Garcia        Standard  100 30.97 09 3 Jensen        Standard  876 30.97
09 3 Hollingsworth Standard  125 30.97 09 3 Jensen        Standard  254 30.97
09 3 Garcia        Standard 1118 30.97 09 3 Hollingsworth Standard  175 30.97
09 3 Jensen        Standard  284 30.97 09 3 Garcia        Standard  412 30.97
09 3 Jensen        Deluxe    275 49.50 09 3 Garcia        Standard  100 30.97
09 3 Jensen        Standard  876 30.97 10 4 Garcia        Standard  250 30.97
10 4 Hollingsworth Standard  530 30.97 10 4 Jensen        Standard  975 30.97
10 4 Hollingsworth Standard  265 30.97 10 4 Jensen        Standard   55 30.97
10 4 Garcia        Standard  365 30.97 11 4 Hollingsworth Standard 1230 30.97
11 4 Jensen        Standard  453 30.97 11 4 Garcia        Standard  198 30.97
11 4 Jensen        Standard   70 30.97 11 4 Garcia        Standard  120 30.97
11 4 Hollingsworth Deluxe    150 49.50 12 4 Garcia        Standard 1000 30.97
12 4 Jensen        Standard  876 30.97 12 4 Hollingsworth Deluxe    125 49.50
12 4 Jensen        Standard 1254 30.97 12 4 Hollingsworth Standard  175 30.97
;
run;

proc sort data=year_sales;
   by SalesRep;
run;

/* before using id statement, we need to sort the variable*/
proc print data=year_sales;
   id SalesRep;
   var Month Units AmountSold;
   title 'TruBlend Coffee Makers Quarterly Sales Report';
run;
title;

proc print data=year_sales noobs;
   var SalesRep Month Units AmountSold;
   where Units>500 or AmountSold>20000;
   format Units comma7. AmountSold dollar14.2;
run;

/* use proc sql to do the same thing as above*/
proc sql;
select salesrep, month, units format=comma7., amountsold format=dollar14.2
from year_sales
where Units>500 or AmountSold>20000;
quit;

/*summing numerica variables*/
proc print data=year_sales;
   var SalesRep Month Units AmountSold;
   where Units>500 or AmountSold>20000;
   format Units comma7. AmountSold dollar14.2;
   sum Units AmountSold;
run;

/*Computing Group Subtotals*/
/*before adding by in the program, we also have to sort the dataset*/
proc print data=year_sales;
   var SalesRep Month Units AmountSold;
   where Units>500 or AmountSold>20000;
   format Units comma7. AmountSold dollar14.2;
   sum Units AmountSold;
   by salesrep;
   id salesrep;  /*we can add id to identify group subtotals*/
run;

/*define labels, title and footnote*/
proc print data=year_sales noobs label split='/';
   var SalesRep Month Units AmountSold;
   where Month='04';
   format Units comma7. AmountSold dollar14.2;
   sum Units AmountSold;
   label SalesRep   = 'Sales/ Rep.'
         Units      = 'Units/ Sold'
         AmountSold = 'Amount/ Sold';
   title 'TruBlend Coffee Maker Sales Report for April';
   footnote "It is produced on &sysdate9"; /*using double quote if we have macro variables*/
run;
title;
footnote;

/*Tabulate*/
/*Creating a Basic One-Dimensional Summary Table*/
proc tabulate data=year_sales format=comma10.;
   title1 'TruBlend Coffee Makers, Inc.';
   title2 'Number of Sales by Each Sales Representative';
   class SalesRep; 
   table SalesRep; 
run;
title;

/*Creating a Basic Two-Dimensional Summary Table*/
proc tabulate data=year_sales format=dollar14.2;
   title1 'TruBlend Coffee Makers, Inc.';
   title2 'Number of Sales by Each Sales Representative';
   class SalesRep; 
   var AmountSold;
   table SalesRep, AmountSold; 
run;
title;

/*"What was the amount sold of each type of coffee maker by each sales representative?"*/
proc tabulate data=year_sales;
	class salesrep type;
	var amountsold;
	table salesrep * type, amountsold*(sum mean)*f=dollar14.2;  /*Calculating Descriptive Statistics*/
run;

/*Getting Summaries for All Variables*/
ods html file='C:\Users\Yi\Desktop\kaggle\sales.htm';
proc tabulate data=year_sales;
	class salesrep type;
	var amountsold;
	table salesrep * (type all) all, amountsold*(n='Sales' (sum='Total' mean='Average')*f=dollar14.2);  /*Calculating Descriptive Statistics*/
run;
ods html close;

proc sql;
select salesrep, type, count(type), sum(amountsold) as sum, mean(amountsold) as mean
from year_sales
group by salesrep, type;
quit;



/*Report*/
proc report data=year_sales;
   where Quarter='1';
   column SalesRep Month Type Units;
   define SalesRep / order;
   define Month / order descending;
run;

/*PROC REPORT does not repeat the values of the ORDER variables from one row to the next when the values are the same.*/

proc report data=year_sales colwidth=10 headline;
   column SalesRep type Units AmountSold;
   define SalesRep /group 'Sales/Representative'; 
   define type / across '';
   define Units / analysis sum;
   define AmountSold/ analysis sum format=dollar14.2;
run;

/*Share a column with multiple analysis variables*/
proc report data=year_sales colwidth=10 headline;
   column SalesRep type, (Units AmountSold);
   define SalesRep /group 'Sales/Representative'; 
   define type / across '';  /*use a blank as the label*/
   define Units / analysis sum;
   define AmountSold/ analysis sum format=dollar14.2;
   break after salesrep / summarize skip ol;
run;

proc report data=year_sales colwidth=10 headline;
   column SalesRep quarter Units AmountSold;
   define SalesRep /group 'Sales/Representative'; 
   define quarter / group; 
   define Units / analysis sum;
   define AmountSold/ analysis sum format=dollar14.2;
   break after salesrep / summarize skip suppress;
   rbreak after / summarize skip;
run;

/*using proc tabulate to do the same thing as above*/
proc tabulate data=year_sales;
	class salesrep quarter;
	var units amountsold;
	table salesrep*(quarter all) all, (units amountsold*f=dollar14.2);
run;

/*plot total units of two types every month of each sales representatives*/
proc sql;
create table jen as
select salesrep, type, month, sum(units)as total
from year_sales
group by salesrep, type, month
order by salesrep, month;
quit;

%let rep='Garcia';
%let type='Standard';

symbol value=dot i=join;
proc gplot data=jen;
	where salesrep=&rep and type=&type;
	plot total*month;
run;






