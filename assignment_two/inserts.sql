pragma foreign_keys = on;

-- 1st add departments
insert into department values ('CS', 'Computer Science', 10000);
insert into department values ('DS', 'Data Science', 10000);

select * from department;

-- add 4 students to student relation
insert into student (name, dept_name, tot_cred) values ('Jan', 'CS', 10);
insert into student (name, dept_name, tot_cred) values ('Kees', 'DS', 8);
insert into student (name, dept_name, tot_cred) values ('Peter', 'CS', 7);
insert into student (name, dept_name, tot_cred) values ('Klaas', 'DS', 9);

select * from student;

-- add 4 instructors to instructor relation
insert into instructor (name, dept_name, salary) VALUES ('Daalon', 'CS', 2800);
insert into instructor (name, dept_name, salary) VALUES ('Henk', 'DS', 2800);
insert into instructor (name, dept_name, salary) VALUES ('Jeffrey', 'CS', 3500);
insert into instructor (name, dept_name, salary) VALUES ('Rick', 'DS', 2800);

select * from instructor;

-- add 4 advisors to advisor relation
insert into advisor (s_id, i_id) VALUES (1, 2);
insert into advisor (s_id, i_id) VALUES (2, 1);
insert into advisor (s_id, i_id) VALUES (3, 4);
insert into advisor (s_id, i_id) VALUES (4, 3);

select * from advisor;

-- Display student names and their advisor name
select s1.name student_name, s2.name advisor_name from advisor s
    inner join student s1 on s.s_id = s1.ID
    inner join instructor s2 on s.s_id = s2.ID;