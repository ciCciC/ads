select * from instructor;
-- returns 1 tuple because its not grouped by on dept_name
select dept_name, avg(salary) from instructor;
select avg(salary) from instructor;
select dept_name, avg(salary) from instructor group by dept_name;

select dept_name, count(distinct instructor.ID) as instr_count from instructor, teaches
where instructor.ID=teaches.ID AND teaches.semester = 'Spring' AND teaches.year = 2018
group by dept_name;

select dept_name, avg(salary) as avg_salary from instructor
group by dept_name
having avg_salary > 42000;

select course_id, semester, year, sec_id, avg(tot_cred) as avg_cred from student, takes
where student.ID=takes.ID AND takes.year = 2017
group by course_id, semester, year, sec_id
having count(student.ID) >= 2;

select distinct course_id
from section
where semester = 'Fall' and year= 2017 and course_id in (select course_id from section
where semester = 'Spring' and year= 2018);

-- inner join and join are the same and shows only matched tuples
select * from section s inner join course c on s.course_id = c.course_id;
select * from section s join course c on s.course_id = c.course_id;

select * from course c join section s on s.course_id = c.course_id; -- doesnt show null values
select * from course c left join section s on s.course_id=c.course_id; -- show even the no matches in the right table

-- this will work but will result in course X section, so 195 rows
select * from course c left join section s on c.course_id=c.course_id; select * from section s, course c;

-- following join and cartesian product shows the same result
select * from section s join course c on s.course_id = c.course_id;
-- section join section.course_id=course.course_id course
select * from section s, course c where s.course_id=c.course_id;
-- sigma s.course_id=c.course_id (Ps(section) X Pc(course))
select * from section s, course c where NOT s.course_id=c.course_id;
-- sigma ~section.course_id=course.course_id (section X course)

-- the following are the same but written differently
select distinct s.course_id from section s, course c where NOT s.course_id=c.course_id;
select distinct s.course_id from section s join course c on s.course_id!=c.course_id;

-- the count of tuples is the product of section and course (so section x course = amount of tuples)
select * from section s, course c;
select * from section s, course c where c.dept_name like 'Bio%';

-- left join and left outer join are the same, outer is optional
select * from section s left join course c on s.course_id=c.course_id; select * from section s, course c where s.course_id=c.course_id;
select * from course c left join section s on s.course_id=c.course_id; select * from course c left outer join section s on s.course_id=c.course_id;
select * from section s left outer join course c on s.course_id=c.course_id;

select * from instructor where salary > (select salary from instructor where ID=12121);
-- sigma i.salary > (pi w.salary (sigma w.ID=12121 Pw(instructor))) (Pi(instructor))

select * from instructor i, (select salary from instructor where ID=12121) w where i.salary > w.salary;
-- sigma i.salary > w.salary (Pi(instructor) X (pi salary (sigma w.ID=12121 Pw(instructor))))

select course_id from section where semester='Fall' AND year=2017 EXCEPT select course_id from section where semester='Spring' AND year=2018;
-- pi course_id (sigma semester='Fall' ^ year=2017 (instructor)) - pi course_id (sigma semester='Spring' ^ year=2018 (instructor))

-- 3 same results but diff queries
select instructor.name from instructor left join teaches t on instructor.ID = t.ID where t.ID is null;
select instructor.name from instructor except select instructor.name from instructor join teaches t on instructor.ID = t.ID;
select instructor.name from instructor where instructor.ID NOT IN (select t.ID from teaches t);

-- in this context if u dont use UNION but want same result with 1 where expression than use DISTINCT
select course_id
from section
where semester = 'Fall' and year= 2017
union
select course_id
from section
where semester = 'Spring' and year= 2018;

select distinct course_id
from section
where semester = 'Fall' and year= 2017 OR semester = 'Spring' and year= 2018;

-- Natural join, Cartesian product, join = both are same except natural join doesnt return the ID attribute in takes relation
select * from student natural join takes;
select * from student, takes where student.ID=takes.ID;
select * from student join takes t on student.ID = t.ID;


select * from time_slot;