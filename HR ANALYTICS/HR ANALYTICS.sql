use hr_analytics;
select * from  `hr main data`;


#  Total Employee ---------------------------

create view Total_employee as
select count(*) total_employee from `hr main data`;

select * from Total_employee;

# Gender Count ------------------------------------------

SELECT gender, COUNT(*) AS count
FROM `hr main data`
GROUP BY gender;

# Current Employee ---------------------------------------------------------

create view `current employee` as
Select count(attrition) current_employee from `hr main data`  where attrition = 'No';

select * from `current employee`;

# Attrition Employee ------------------------------------------------------

create view Attrition AS
SELECT count(attrition) Ex_Employee from `hr main data` where attrition = 'Yes';

select * from Attrition;


# -----------------------------1. Average Attrition rate for all Departments ----------------------------#


select * from `hr main data`;
select Department,count(attrition) `Number of Attrition`from `hr main data`
where attrition = 'yes'
group by Department;


create view Dept_average as
select department, round(count(attrition)/(select count(`Employee ID`) from `hr main data`)*100,2)  as attrtion_rate
from `hr main data`
where attrition = "yes"
group by department;
select * from dept_average;


# ----------------------------------2. Average Hourly rate of Male Research Scientist--------------------------------#


SELECT AVG(HourlyRate) AS average_hourly_rate
FROM `hr main data`
WHERE gender = 'Male' AND JobRole = 'Research Scientist';


# ------------------------------3. Attrition rate Vs Monthly income stats-------------------------------------#
SELECT 
   Attrition ,
    COUNT(*) AS count,
    AVG(MonthlyIncome) AS average_monthly_income,
    MIN(MonthlyIncome) AS min_monthly_income,
    MAX(MonthlyIncome) AS max_monthly_income,
    STDDEV(MonthlyIncome) AS stddev_monthly_income
FROM 
  `hr main data`
GROUP BY 
   Attrition;


#----------------------------- --------4. Average working years for each Department-------------------------------------#

select department,Round(avg(TotalWorkingYears),0) from `hr main data`
group by department;

Create view `Employee Age` as 
select department,Round(avg(TotalWorkingYears),0) from `hr main data`
group by department;

select * from `employee age`;


# --------------------------------------5. Job Role Vs Work life balance--------------------------------


SELECT 
    JobRole,
    AVG(WorkLifeBalance) AS average_work_life_balance
FROM 
    `hr main data`
GROUP BY 
   JobRole;


# --------------------------6. Attrition rate Vs Year since last promotion relation-----------------------------------#


select * from  `hr main data`;

select `YearsSinceLastPromotion`,count(Attrition)  attrition_count
from `hr main data`
where Attrition = 'Yes'
group by `YearsSinceLastPromotion`
order by `YearsSinceLastPromotion`;


  
#  Education vs attrition

Select educationField, count(attrition) current_employee from `hr main data`
where attrition = 'yes'
group by educationfield;



# ------------------------------------8)  gender based percentage of employee ----------------------------------------#

SELECT
    Gender,
    COUNT(`Employee ID`) AS total_count,
    round(COUNT(`Employee ID`) / (SELECT COUNT(`Employee ID`) FROM `hr main data`) * 100,4) AS percentage
FROM
    `hr main data`
WHERE
    Gender IS NOT NULL
GROUP BY
    Gender;


#---------------------------------9)  Department/ Job Role wise job satisfaction------------------------------------#


SELECT
    Department,
    JobRole,
    AVG(JobSatisfaction) AS average_job_satisfaction
FROM
    `hr main data`
GROUP BY
    Department, JobRole
ORDER BY
    Department, JobRole;
    
    
    
    