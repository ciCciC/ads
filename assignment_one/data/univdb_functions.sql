-- all results
select * from instructor;

-- count both return 1 result
select count() from instructor;
select count(*) from instructor;

-- distinct removes duplicates (always 1 column)
select DISTINCT name from instructor;

-- avg salary
select avg(salary) from instructor;

-- avg subQ in select
select (salary - (select avg(salary) from instructor)) distance_from_avg from instructor;

-- max min returns 1 tuple with 2 columns
select max(salary) max_sal, min(salary) min_sal from instructor;
-- max min returns all tuples with 2 columns
select (select max(salary) from instructor) max_sal, (select min(salary) from instructor) min_sal from instructor;

-- between, <= >=
select * from instructor where salary between 10000 and 70000;
select * from instructor where salary >= 10000 and salary <= 70000;
select * from instructor where salary not between 10000 and 70000;

-- order by, asc on default
select name from instructor order by name;
select name from instructor order by name desc;
select salary, name from instructor order by salary desc, name;

-- like
select name from instructor where name like 'a%';
select name from instructor where name like '__a%';
select name from instructor where name like 'b%';
select name from instructor where name like 'Brandt';
select name from instructor where name like 1000; -- works but without any result
select name from instructor where name not like 'b%';
select name from instructor where name < 'E';
select name from instructor where name like 'b\\%cd%' escape '\';

select name from instructor where salary > 10000 is unknown;

-- total, sum
select sum(salary) from instructor;
select total(salary) from instructor;

-- group by (left, right and full join would give bad result because they allow null tuples)
select dept_name, count(DISTINCT instructor.ID) as instr_count from instructor, teaches
where instructor.ID=teaches.ID
group by dept_name;

select dept_name, count(DISTINCT instructor.ID) as instr_count from instructor join teaches
on instructor.ID=teaches.ID
group by dept_name;

-- having, average salary higher than 42000 and lower than max salary
select dept_name, avg(salary) avg_salary from instructor
group by dept_name
having avg_salary > 42000 and avg_salary < (select max(salary) from instructor);

-- IN, checks if the salary exists in subquery
select * from instructor where salary in (select salary from instructor where salary between 20000 and 70000);
select * from instructor where salary in (select ID from instructor where salary between 20000 and 70000); -- works but empty table

select distinct course_id
from section
where semester = 'Fall' and year= 2017 and
course_id in (select course_id from section
where semester = 'Spring' and year= 2018);

-- NOT IN
select * from instructor where salary NOT IN (select salary from instructor where salary between 20000 and 70000);

-- using ROW/ TUPLE CONSTRUCTOR SYNTAX (here we define the attributes) = (course_id, sec_id, semester, year)
select count(DISTINCT ID) from takes where (course_id, sec_id, semester, year) in (select course_id, sec_id, semester, year from teaches where teaches.ID=10101);

select name from instructor where salary > (select salary from instructor where dept_name='Biology');

-- EXIST, returns boolean
select course_id from section s where s.semester='Fall' AND s.year=2017 AND
                                      exists(select course_id from section t where t.semester='Spring' AND t.year=2018 AND s.course_id=t.course_id);

-- NOT EXIST, return boolean
select course_id from section s where s.semester='Fall' AND s.year=2017 AND
                                      not exists(select course_id from section t where t.semester='Spring' AND t.year=2018 AND s.course_id=t.course_id);

-- UNIQUE, returns boolean, context=Find all courses that were offered at most once in 2017
-- select T.course_id from course T where UNIQUE(select S.course_id from section S where T.course_id=S.course_id AND S.year=2017);

select T.course_id from course T where 1 >= (select count(S.course_id) from section S where T.course_id=S.course_id AND S.year=2017);

select dept_name, avg_salary from (select dept_name, avg(salary) avg_salary from instructor group by dept_name)
where avg_salary > 42000;

-- print names of each instructor with their salary and average salary in their department
select name, salary, I.dept_name, round(avg_salary, 2) from instructor I
    left join
    (select dept_name, avg(salary) avg_salary from instructor group by dept_name) T
where I.dept_name=T.dept_name;

-- With clause
with max_budget (value) as
    (select max(budget)
    from department)
select budget
from department, max_budget
where department.budget = max_budget.value;

-- scalar subquery
select dept_name,
       (select count(*)
       from instructor
       where department.dept_name = instructor.dept_name) as num_instructors
from department;

select * from student;
select * from department;
select course_id from course EXCEPT select course_id from course, department where course.dept_name=department.dept_name;

select dept_name, (select count() from student where student.dept_name=department.dept_name) n_students from department where n_students = 1;

select dept_name from student group by dept_name;

select * from department a left join student d on a.dept_name = d.dept_name;

select * from course c, course x where c.course_id=x.course_id;

select DISTINCT tbl_name from sqlite_master;

select max(salary), min(salary) from instructor;

select name, salary from instructor
where salary=(select max(salary) from instructor) or salary=(select min(salary) from instructor);

create table TestChecks (
    id integer primary key ,
    name varchar,
    instructor_id integer not null,
    foreign key(instructor_id) references instructor
                        );

select * from TestChecks;
insert into TestChecks values(null, 'A', 10102);
insert into TestChecks values(null, 'A', null);



select * from TestChecks;
select * from instructor;
select * from section;