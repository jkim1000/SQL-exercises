오답노트

Q1
#https://platform.stratascratch.com/coding/10141-apple-product-counts?code_type=3

#Apple Product counts

#Challenge1: Setting up a CASE WHEN statement and counting the number of observations that follow the case statement
#Challenge2: Recognizing that there might be duplicate users

#Solution: 
select language, 
count(distinct(
case when events.device in ('macbook pro','iphone 5s','ipad air') then events.user_id 
else null end)) as n_apple_user,
count(distinct(events.user_id))
from playbook_events as events
join playbook_users as users
on events.user_id = users.user_id
group by language
order by count(*) desc

#Similar questions: https://platform.stratascratch.com/coding/10134-spam-posts?code_type=3, https://platform.stratascratch.com/coding/10133-requests-acceptance-rate/discussion?code_type=3
#Comments: can also do sum(case when [condition] then 1 else 0 end), be comfortable with calculating percentages


Q2
#https://platform.stratascratch.com/coding/10322-finding-user-purchases?code_type=3

#Finding User purchases

#Challenge1: Manipulating the lag function to calculate time difference. Make sure you know lag syntax 

#Solution:
select distinct(user_id)
from
(select *, lag (created_at) over (partition by user_id order by created_at) as lag_date
from amazon_transactions) as lag_tbl
where datediff(created_at, lag_date) <= 7

#Alternative Solution:
SELECT a1.user_id
      FROM amazon_transactions as a1
      LEFT JOIN amazon_transactions a2
           ON a1.user_id = a2.user_id
           AND a1.id <> a2.id
     WHERE ABS(DATEDIFF(a1.created_at, a2.created_at)) < 7
     GROUP BY a1.user_id 
     ORDER BY a1.user_id

#Comment:For the alternative solution, time efficiency is better because you are not doing subquery

Q3
#https://platform.stratascratch.com/coding/10308-salaries-differences?code_type=3

#Salaries difference

#Interesting approach that uses case when to calculate differences between two different conditionals

SELECT 
ABS(MAX(CASE WHEN department = 'marketing' THEN salary end) -
MAX(CASE WHEN department = 'engineering' THEN salary end))

FROM db_employee
JOIN db_dept
ON db_employee.department_id = db_dept.id;

#Comment: Be flexible with sum, max, min, avg, count statements on case when statements
#similar questions: https://platform.stratascratch.com/coding/10318-new-products?code_type=3

