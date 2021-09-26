
-- Task 1
use sonra_task;
select * from topups;

insert into topups values(68,6, '2017-06-28', 12);
insert into topups values(69,6, '2017-06-29', 6);
insert into topups values(70,6, '2017-06-30', 11);

-- Task 2

-- Simple Aggregations. Print out the list of user IDs and the total of ALL top-ups performed by
-- them but ONLY for the users that had at least one topup ever by the amount of €15 exactly. Can this
-- be solved in a single SELECT statement, without Window Aggregates or subqueries (nested
-- SELECTs)?
select id_user, sum(topup_val) from topups group by id_user;

-- Solution for Task 2 
SELECT 
    distinct a.id_user,sum(b.topup_val)
FROM
    topups a join topups b on a.id_user = b.id_user 
where a.topup_val = 15
group by a.seq,a.id_user
ORDER BY a.id_user;
-- end

SELECT 
    id_user, SUM(topup_val)
FROM
    topups
WHERE
    id_user in (select id_user from topups where topup_val = 15)
    group by id_user
    order by id_user;

select distinct id_user from topups;

set SQL_SAFE_UPDATES = 0;

-- Task 3
-- Row Sequencing. Show the 5 (but not more) rows with the most recent top-ups per user. In
-- case of more top-ups on a given day, print those with higher amounts first.
select * from topups;

select id_user,topup_date, topup_val from topups where (select count(*) from topups t where t.id_user = topups.id_user order by topup_val desc) = 5;

SELECT 
   distinct a.seq, a.id_user,a.topup_date, b.topup_val
FROM
    topups a join topups b on a.id_user = b.id_user and a.topup_date = b.topup_date and a.topup_val = b.topup_val 
ORDER BY a.id_user, a.topup_date desc;

-- Solution for task 3
select * from (
    select id_user, 
           topup_date,
           topup_val, 
           row_number() over (partition by id_user order by topup_date desc) as recent_rank 
    from topups) ranks
where recent_rank <= 5 order by id_user;

-- end