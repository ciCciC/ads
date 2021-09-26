PRAGMA writable_schema = 1;
delete from sqlite_master where type in ('table', 'index', 'trigger');
PRAGMA writable_schema = 0;

create table department(
    dept_name varchar(20) primary key,
    building varchar(20) not null,
    budget decimal
);

create table instructor (
    ID integer primary key autoincrement,
    name varchar(20) not null,
    dept_name varchar(20),
    salary decimal,
    foreign key (dept_name) references department(dept_name) on delete set null on update cascade
);

create table student(
    ID integer primary key,
    name varchar(20),
    dept_name varchar(20),
    tot_cred integer,
    foreign key (dept_name) references department(dept_name) on delete set null on update cascade
);

create table advisor(
    s_id int,
    i_id int,
    primary key (s_id),
    foreign key (s_id) references student(ID) on delete cascade on update cascade,
    foreign key (i_id) references instructor(ID) on delete set null on update cascade
);

create table course(
    course_id int primary key,
    title varchar(20) not null,
    dept_name varchar(20) not null,
    credits integer not null,
    foreign key (dept_name) references department(dept_name) on delete cascade on update cascade
);

create table prereq(
    course_id int,
    prereq_id int,
    primary key (course_id, prereq_id),
    foreign key (course_id, prereq_id) references course(course_id, course_id) on delete cascade on update cascade
);

create table classroom(
    building varchar(20),
    room_no int,
    capacity int,
    primary key (building, room_no)
);

create table teaches(
    ID int,
    course_id int,
    sec_id int,
    semester varchar(20),
    year int CHECK ( year > 2000 ),
    primary key(ID, course_id, sec_id, semester, year),
    foreign key (course_id, sec_id, semester, year) references section(course_id, sec_id, semester, year) on delete cascade on update cascade,
    CONSTRAINT CHECK_SEMESTER_IN_TEACHES CHECK ( semester in ('Q1', 'Q2', 'Q3', 'Q4') )
);

create table section(
    course_id int,
    sec_id int,
    semester varchar(20),
    year int CHECK ( year > 2000 ),
    building varchar(20) not null,
    room_no int not null,
    time_slot_id int,
    primary key (course_id, sec_id, semester, year),
    foreign key (course_id) references course(course_id) on delete cascade on update cascade,
    foreign key (building, room_no) references classroom(building, room_no) on delete cascade on update cascade,
    CONSTRAINT CHECK_SEMESTER_IN_SECTION CHECK ( semester in ('Q1', 'Q2', 'Q3', 'Q4') ),
    CONSTRAINT CHECK_TIME_SLOT CHECK ( time_slot_id in ('A', 'B', 'C', 'D') )
);

create table takes(
    ID int,
    course_id int,
    sec_id int,
    semester varchar(20),
    year int CHECK ( year > 2000 ),
    grade char(2) not null,
    primary key (ID, course_id, sec_id, semester, year),
    foreign key (ID) references student(ID) on delete cascade on update cascade,
    foreign key (course_id, sec_id, semester, year) references section(course_id, sec_id, semester, year) on delete cascade on update cascade,
    CONSTRAINT CHECK_SEMESTER_IN_TAKES CHECK ( semester in ('Q1', 'Q2', 'Q3', 'Q4') )
);