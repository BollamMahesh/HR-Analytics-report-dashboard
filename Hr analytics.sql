USE HR_Analytics
go
select * from [ HR_Employees]

alter table [ HR_Employees] add salary_range varchar(15);

alter table hr_analytics add column salaryrange varchar(15);
update [ HR_Employees] set salary_range= 'low' where MonthlyIncome <= 3000;
update  [ HR_Employees] set salary_range= 'medium' where MonthlyIncome between 3000 and 7500;
update  [ HR_Employees] set salary_range= 'high' where MonthlyIncome between 7500 and 15000;
update  [ HR_Employees] set salary_range= 'top' where MonthlyIncome >= 15000 ;
select *from [ HR_Employees]; 


select YearsAtCompany,YearsSinceLastPromotion,Attrition from  [ HR_Employees];

alter table [ HR_Employees] add employee_id int IDENTITY(1,1);
ALTER TABLE [ HR_Employees] DROP  employee_id IDENTITY;
GO
alter table  [ HR_Employees] add employee_id int primary key identity(100,1) ;
-- top 5 salary holders 
select top 5 MonthlyIncome ,employee_id from [ HR_Employees]
order by MonthlyIncome desc
 
select* from [ HR_Employees] 


-- Scenario 1: Total Headcount and Overall Attrition Count

select count(*) as total_emp,
sum(case when  Attrition = 'Yes' then 1 else 0 end) as attrition_members
 from [ HR_Employees]

-- Scenario 2: Find the Average Monthly Income by Department
select avg(MonthlyIncome) as avg_salary,Department
from [ HR_Employees]
group by Department;

-- Scenario 3: Identify Employees working Overtime with Low Job Satisfaction (Flight Risks)
select employee_id,OverTime,JobSatisfaction
from [ HR_Employees]
where JobSatisfaction  < 3 and OverTime ='Yes'

-- Scenario 4: Count of Employees by Business Travel Frequency
select 
sum(case when BusinessTravel = 'Travel_frequently' then 1 else 0 end) as travel_frequentlt,
sum(case when BusinessTravel = 'Travel_rarely' then 1 else 0 end) as travel_rarely,
sum(case when BusinessTravel = 'non-Travel' then 1 else 0 end) as non_travel
from  [ HR_Employees]
-- Scenario 5: Gender Distribution Across Different Job Roles
select gender,jobrole, count(*) as total_count from  [ HR_Employees] 
group by gender,jobrole
order by jobrole;


-- Scenario 6: Identify Departments with an Attrition Rate higher than 10%
WITH DepartmentAttrition AS (
    -- Step 1: Calculate the core metrics per department
    SELECT 
        Department,
        COUNT(*) AS TotalHeadcount,
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS TotalLeavers,
        -- Calculate the percentage: (Leavers / Total Headcount) * 100
        ROUND(
            CAST(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS FLOAT) / 
            CAST(COUNT(*) AS FLOAT) * 100, 2
        ) AS AttritionRatePct
    FROM 
        [ HR_Employees]
    GROUP BY 
        Department
)
-- Step 2: Filter for departments exceeding the 10% threshold
SELECT 
    Department,
    TotalHeadcount,
    TotalLeavers,
    AttritionRatePct
FROM 
    DepartmentAttrition
WHERE 
    AttritionRatePct > 10.0
ORDER BY 
    AttritionRatePct DESC;


-- Scenario 7: Overall Attrition Rate
select count(*) as total_emp,
sum(case when  Attrition = 'Yes' then 1 else 0 end) as attrition_members
CAST(sum(case when Attrition ='Yes' then 1 else 0 end ) as float)/ count(*)*100 as attrition_rate,
from [ HR_Employees] 
--Attrition employees with emp_id
select Attrition,employee_id from [ HR_Employees]
where Attrition = 'Yes'
order by employee_id;

 

