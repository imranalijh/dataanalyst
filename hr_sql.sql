use hr_analytics;
select * from hr_2;
 select * from hr_1;
 
 alter table hr_1 change column ï»¿Age Age int;
  alter table hr_2 change column ï»¿Employeeid Employeeid int;
  
  select count(*) as Total_Employees from hr_1;
  select sum(attr_yes)as No_attrition from hr_1;
  select concat(round((sum(attr_yes)/count(*))*100,2),'%') as Attrition_rate from hr_1;
  
 -- 1 Average Attrition rate for all Departments
select Department, concat(round((sum(attr_yes)/count(*))*100, 2),'%') as Avg_attr_rate from hr_1 group by department;
  
 -- 2 Average Hourly rate of Male Research Scientist
 
 select JobRole,Gender,round(avg(hourlyRate)) as Avg_hourly_rate from Hr_1 where Jobrole = 'Research Scientist' And Gender ='Male';
 
 select JobRole,Gender,round(avg(hourlyRate)) as Avg_hourly_rate  from Hr_1 where Jobrole = 'Research Scientist' And Gender ='Female';
 
 -- 3 Attrition rate Vs Monthly income stats-- stored procedure

 
 -- 4 Average working years for each Department
 
 select Department, round(Avg(TotalWorkingYears),2) as Avg_Working_years from hr_1 as h1
 join hr_2 as h2 on h1.EmployeeNumber = h2.Employeeid
 group by Department;
 
 -- 5 Job Role Vs Work life balance 

 select h1.JobRole, round(avg(workLifeBalance),2) as Work_life_balance from hr_1 as h1
 join hr_2 as h2 on h1.EmployeeNumber = h2.Employeeid group by jobRole;
 
 -- 6 Attrition rate Vs Year since last promotion relation

 select count(attr_yes), h2.YearsSinceLastPromotion from hr_1 as h1 
 join hr_2 as h2 on h1.EmployeeNumber = h2.Employeeid group by yearssincelastpromotion order by yearssincelastpromotion Asc; 
 
 select 
 case
  when	h2.YearsSinceLastPromotion <=10 then '0-10 years'
  when	h2.YearsSinceLastPromotion <=20 then '11-20 years'
  when	h2.YearsSinceLastPromotion <=30 then '21-30 years'
  else '31+ years'
  end as PromotionBand,
  count(*) as TotalEmployees,
  sum(attr_yes) as Ex_employees,
  (sum(attr_yes)/count(*))*100 As Attrition_Rate
  from hr_1 as h1 
 join hr_2 as h2 on h1.EmployeeNumber = h2.Employeeid
  group by PromotionBand
  order by PromotionBand;
  
  
   SET global log_bin_trust_function_creators = 1;