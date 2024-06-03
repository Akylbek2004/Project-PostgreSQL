-- Students: Information about individual students.


create table Students(
                         student_id int primary key,
                         first_name varchar(255),
                         last_name varchar(255),
                         gender varchar(255),
                         years varchar(255),
                         department_id int references Departments(department_id),
                         advisor_id int references Advisors(advisor_id)
);


create or replace function GPA_Calculator(stu_id int)
    returns numeric as $$
declare gpa numeric;
begin
    select coalesce(sum(t.grade * cd.number_credits), 0) / coalesce(sum(cd.number_credits), 1) into gpa
    from students as s
             join transcripts as t on s.student_id = t.student_id
             join courses as c on t.course_id = c.course_id
             join courseDetails as cd on c.course_code = cd.course_code
    where s.student_id = stu_id and t.letter_grade not like 'IP'
    group by s.student_id;
    return coalesce(gpa, 0);
end;
$$ language plpgsql;


select * from Enrollments;


create or replace function admit()
returns trigger as $$
    begin
        insert into Students (student_id, first_name, last_name, gender, years, department_id, advisor_id) values
                        (new.student_id, new.first_name, new.last_name, new.gender, new.years, new.department_id, new.advisor_id);
        insert into StudentContacts(student_id, phone_number, parent_contact, addresses) VALUES
                        (new.student_id, new.phone_number, new.parent_contact, new.addresses);
        return new;
    end;
    $$
language plpgsql;

create or replace trigger Admission_Students
    after insert on Admissions
    for each row
    execute function admit();

--StudentContacts: Contact information for students.

create table StudentContacts(
                                student_contact_id serial primary key,
                                student_id int ,
                                phone_number varchar(8),
                                parent_contact varchar(8),
                                addresses varchar(255),


                                foreign key(student_id) references Students(student_id)

);


--Admissions: Student admission records.
create table Admissions(
                           admission_id serial primary key,
                           student_id int unique ,
                           department_id int  references Departments(department_id),
                           advisor_id int references Advisors(advisor_id),
                           first_name varchar(255),
                           last_name varchar(255),
                           years  varchar(255),
                           gender varchar(255),
                           phone_number varchar(8),
                           parent_contact varchar(8),
                           addresses varchar(255),
                           admission_date date


);

--Enrollments: Student course enrollments.
create table Enrollments(
                        enrollment_id serial primary key,
                        student_id int ,
                        course_id int,
                        enrollment_date date ,

                        foreign key(course_id) references Courses(course_id),
                        foreign key(student_id) references Students(student_id)


);

--Transcripts: Academic records and grades.
drop table Transcripts cascade;
create table Transcripts(
                        transcript_id serial primary key,
                        student_id int,
                        course_id int ,
                        grade numeric constraint grade_const check (grade <= 4 and grade >= 0),
                        letter_grade varchar(2) default 'IP',

                        foreign key (student_id) references Students(student_id),
                        foreign key (course_id) references Courses(course_id)
);
--DegreeProgress: Tracking students' progress towards a degree.
create table DegreeProgress(
                        degree_progress_id serial primary key,
                        student_id int ,
                        degree_name varchar(30),
                        passed_credit_number int,

                        foreign key (student_id) references Students(student_id)

);

--Courses: Information about the courses offered.
create table Courses(
                        course_id int primary key,
                        course_code int ,
                        instructor_id int,
                        department_id int references  Departments(department_id),
                        course_current bool default true,
                        foreign key(instructor_id) references Instructors(instructor_id),
                        foreign key (course_code) references CourseDetails(course_code)

);

create table CourseDetails(
                        course_code varchar(7) primary key,
                        course_name varchar(255),
                        next_course varchar(7) references CourseDetails(course_code),
                        number_credits int ,
                        descriptions text


);

--Instructors: Details of course instructors.
create table Instructors(
                        instructor_id int primary key,
                        member_id int ,
                        office_location varchar(255),
                        office_hours varchar(255),
                        achievements text ,

                        foreign key (member_id) references Staff(member_id)

);


--Departments: Academic departments within the university.


create table Departments(
                        department_id int primary key,
                        department_name varchar(255),
                        faculty_id int ,

                        foreign key (faculty_id) references Faculty(faculty_id)

    --
    --
);


--Advisors: Faculty advisors for students.

create table Advisors(
                        advisor_id int primary key,
                        member_id int,
                        office_location varchar(255),

                        foreign key (member_id) references Staff(member_id)
    --
    --
);



--StudentGroups: Student organizations and clubs.

create table StudentGroups(
                      group_id int primary key,
                      group_name varchar(255) ,
                      head_id int ,
                      description text,
                      budget numeric
    --
    --
);

create table GroupJoins(
                       group_join_id int primary key,
                       student_id int ,
                       group_id int,
                       position_name int,

                       foreign key(student_id) references Students(student_id),
                       foreign key(group_id) references StudentGroups(group_id)


);


--Housing: Student housing information.
create table Student_Houses(
                       house_id int primary key,
                       house_name varchar(255),
                       floor_number int,
                       capacity int

);

create table Housing(
                        housing_id int primary key ,
                        student_id int references Students(student_id),
                        house_id int references Student_Houses (house_id),
                        room_number varchar(4),
                        floor int constraint floor_limit check(floor <= (select floor_number from Student_Houses  as SH where Housing.house_id = SH.house_id) && floor >= 1)


);

--MealPlans: Meal plan options for students.
create table MealPlans(
                         meal_plan_id int primary key,
                         student_id int references Students(student_id),
                         meal_plan text ,
                         cost numeric


);
--StudentFees: Fees and charges for students.
create table Fees(
                         fee_id int primary key,
                         fee_name varchar(30),
                         fee numeric ,
                         description text

);

create table StudentFees(

                         student_fee_id serial primary key,
                         student_id int ,
                         fee_id int,
                         is_paid bool default false,


                         foreign key(student_id) references Students(student_id),
                         foreign key (fee_id) references Fees(fee_id)

);

--Library: Library resources and checkouts.
create table Books(
                      book_id int primary key,
                      title varchar(255),
                      author varchar(255),
                      publisher varchar(255),
                      quantity int
);

create table Library(
                        resource_id serial primary key,
                        book_id int references Books(book_id),
                        student_id int references Students(student_id),
                        data_issue date ,
                        data_return date ,
                        is_returned bool
);

--HealthServices: Student health services records.

create table HealthServices(
    health_id serial primary key,
    student_id int references Students(student_id),
    diagnosis varchar(255),
    visit_date date ,
    visit_duration int
);

--StudentAchievements: Records of student achievements and awards.

create table StudentAchievements(
                         achievement_id int primary key,
                         student_id int ,
                         achievement varchar(255) ,
                         description text,

                         foreign key (student_id) references Students(student_id)
    --
    --
);

--Internships: Information about student internships.
create table Internships(
                         internship_id int primary key,
                         student_id int ,
                         course_id int ,
                         place_of_internship varchar(255),

                         foreign key (student_id) references Students(student_id),
                         foreign key (course_id) references Courses(course_id)
    --
    --
);

--StudyAbroad: Records of students studying abroad.
create table StudyAbroad(
                        study_abroad_id int primary key,
                        student_id int ,
                        country_name varchar(255) ,
                        program_start_date date ,
                        program_end_date date ,


                        foreign key (student_id) references Students(student_id)
);

--StudentEvents: Information about campus events.
create table StudentEvents(
                         event_id int primary key,
                         event_name varchar(255),
                         group_id int ,
                         locations varchar(255),
                         event_date date,
                         description text,
                         ticket_cost numeric,

                         foreign key(group_id) references StudentGroups(group_id)
    --
    --
);

--Graduation: Graduation records and ceremony details.

create table Graduation(
                        graduation_id serial primary key,
                        student_id int,
                        degree_name varchar(30),
                        graduation_date date,
                        graduation_location varchar(255),


                        foreign key (student_id) references Students(student_id)


);
select * from Students where years like 'Junior';

--Alumni: Records of former students.
create table Alumni(
                       alumni_id serial primary key,
                       first_name varchar(255),
                       last_name varchar(255),
                       gender varchar(255),
                       department_id int references Departments(department_id),
                       admission_date date,
                       graduation_date date,
                       employment_status varchar(30),
                       phone_number varchar(8)


);

select * from Students where years like 'Senior' or years like 'Junior';
select * from courses;
--Faculty: Information about university faculty.

create table Faculty(

                        faculty_id int primary key,
                        faculty_name varchar(255),
                        dean varchar(255)


    --
    --
);


--Staff: Information about university staff.

create table Staff(
                      member_id int primary key,
                      first_name varchar(255),
                      last_name varchar(255),
                      department_id int ,
                      position_name int,
                      contact_information varchar(8),
                      salary numeric,

                      foreign key (department_id) references Departments(department_id)
    --
    --
);










--1.List of Students and Their Enrollments
select S.student_id , S.first_name , S.last_name , E.enrollment_id , E.course_id , E.enrollment_date
from Students S
          join Enrollments E on S.student_id = E.student_id ;


--2.Retrieve a list of all students and the courses they are currently enrolled in, including course details.
select S.student_id , S.first_name , S.last_name ,S.department_id, C.course_id, CD.course_code ,C.instructor_id , CD.course_name , CD.number_credits , CD.descriptions
from Students as S
         join Enrollments E on S.student_id = E.student_id
         join Courses C on C.course_id = E.course_id
         join CourseDetails CD on C.course_code = CD.course_code;



--3.Find the students who do not have assigned advisors.
select * from Students where advisor_id  is  null;




--4.Identify the student(s) with the highest GPA and their academic records.

select student_id,first_name ,last_name,department_id , advisor_id  , GPA_Calculator(student_id) from Students
where student_id in
      (select student_id from Students where GPA_Calculator(student_id)  = (select max(GPA_Calculator(student_id)) from Students) LIMIT 1  );





--5.Calculate the average GPA for students in each major.
select D.department_name , avg(GPA_Calculator(S.student_id)) as average_gpa
from Departments as D
left join Students as S on D.department_id = S.department_id
group by D.department_name order by average_gpa desc;


--6.Determine which departments offer the most courses by counting the number of courses offered in each department.
select D.department_name , count(C.course_id) as course_count from Departments as D
                                                       left join Courses C on D.department_id = C.department_id group by D.department_name order by course_count ;




--7.List faculty advisors along with the students they advise.
select Advisors.advisor_id ,student_id from Advisors
                                            left join Students S on Advisors.advisor_id = S.advisor_id
group by Advisors.advisor_id, student_id;



--8.Find the student groups with the most members and list the group names and member counts.

select group_name , count(group_join_id) as count_member from
    StudentGroups left join GroupJoins GJ on StudentGroups.group_id = GJ.group_id
group by group_name order by count_member desc limit 5;


--9.Calculate the occupancy rate of the university's student housing facilities.
select house_name , count(student_id) , SH.capacity as capavity ,cast (count(student_id) as numeric)/SH.capacity as occupancy_rate  from Housing
            right join Student_Houses SH on SH.house_id = Housing.house_id group by house_name, SH.capacity;
--10.Compute the average cost of meal plans for different student groups (e.g., freshmen, sophomores, etc.).

select S.years , avg(coalesce(MP.cost , 0)) as averge_cost from
    Students as S left join MealPlans MP on S.student_id = MP.student_id
group by S.years order by averge_cost;



--11.Calculate the total tuition revenue generated by each academic department.
select D.department_name, sum(coalesce (F.fee,0)) from Departments as D
                                              join Students as S on S.department_id = D.department_id
                                              join StudentFees as SF on SF.student_id = S.student_id
                                              join Fees as F on SF.fee_id = F.fee_id where fee_name like 'Tuition Fee' group by D.department_name
;




--12.Find the number of available library resources and the number checked out by students.
select (select sum(quantity) from Books) as all_resources ,
       (select count (*) from Library where is_returned = false ) as student_check_out ,
       sum((select sum(quantity) from Books) - (select count (*) from Library where is_returned = false )) as available_library_resources ;


--13.Calculate the number of student visits to health services and their average visit duration.

select count(*) as visit_number , avg(visit_duration) as avg_duration from HealthServices;


--14.List student achievements (awards, honors) and group them by the student's department.

select D.department_name , S.student_id ,SA.achievement ,SA.description from Departments as D
    join Students S on D.department_id = S.department_id
    join StudentAchievements SA on S.student_id = SA.student_id
    group by D.department_name,S.student_id,SA.achievement,SA.description order by D.department_name;




--15.Determine the percentage of students who have participated in internships.
select (cast((select count (student_id) from Internships)  as numeric))/ (select count(*) from Students) as percentage_of_students;



--16.Find the countries where students have studied abroad and the number of students in each country.

select country_name ,count(student_id) from StudyAbroad group by country_name;


--17.List the upcoming campus events and their details, sorted by date.

select SE.event_name, SG.group_name as Organizers, SE.locations, SE.event_date, SE.description, SE.ticket_cost from StudentEvents as SE
    join StudentGroups SG on SE.group_id = SG.group_id group by SE.event_id,Organizers,SE.event_date,SE.event_name,SE.locations, SE.event_date, SE.description, SE.ticket_cost order by SE.event_date;


--18.Determine which departments produce the most employed alumni.

select D.department_name, count(alumni_id) as employed_alumni
from Departments as D
         join Alumni A on D.department_id = A.department_id where A.employment_status like 'Employed' group by D.department_name order by employed_alumni desc;



--19.Identify faculty members who have expertise in specific research areas, based on their academic records.

select first_name,last_name ,position_name ,achievements from Instructors as I
    join Staff S on I.member_id = S.member_id where achievements is not null;


--20.Analyze the historical enrollment data to identify trends in student enrollment over the past few years.
select extract(years from admission_date) as year  , count(student_id) as count_of_admission from Admissions group by year order by year desc;




--21.Verify if students enrolling in advanced courses meet the prerequisites by checking their transcript records.
select S.student_id , CD.next_course as may_taken_course from CourseDetails as CD
    join Courses C on CD.course_code = C.course_code
    join Enrollments E on C.course_id = E.course_id
    join Students S on E.student_id = S.student_id
    join Transcripts T on S.student_id = T.student_id
    where T.grade >= 2 and Cd.next_course is not null;
--22.List students with outstanding fees, including the total amount owed.
select S.student_id , S.first_name ,S.last_name , sum(fee) as Total_outstanding_fee from Students as S
    join StudentFees as SF on S.student_id = SF.student_id
    join Fees F on SF.fee_id = F.fee_id
    where SF.is_paid = false group by S.student_id, S.first_name, S.last_name order by Total_outstanding_fee desc;


--23.Identify instructors who are teaching multiple courses in the same term and list the courses they are teaching.
select I.instructor_id ,C.course_code from Instructors as I
    join Courses C on I.instructor_id = C.instructor_id
    where course_current = true and (select count(CO.course_code) from Courses as CO where CO.instructor_id = I.instructor_id  group by instructor_id) > 1 group by I.instructor_id ,course_code;



--24.Calculate statistics on student diversity, such as the distribution of gender, ethnicity, or nationality.

select gender,(cast(count(*) as numeric)*100)/(select count(*) from Students) from Students group by gender;



--25.Find the most popular combinations of courses (sets of courses taken together) among students.

select SC.course_set ,count(SC.student_id) AS popularity  from
    (select student_id,array_agg(course_id) as course_set from Enrollments group by student_id) as SC
group by SC.course_set order by popularity desc;


--26.Compare the academic performance (GPA) of students based on their faculty advisors.

select student_id , advisor_id , GPA_Calculator(student_id) as gpa from Students
                                                            group by student_id , advisor_id order by gpa desc;


--27.Identify student groups that have members from a wide range of majors, promoting interdisciplinary collaboration.
select SG.group_name , count(GJ.student_id) as diversity from StudentGroups as SG
    join GroupJoins GJ on SG.group_id = GJ.group_id
    group by SG.group_name
    having count(GJ.student_id) > 1;

--28.List courses with consistently high enrollment, helping with scheduling and resource allocation.
select C.course_id, C.course_code , count(coalesce(E.student_id,0)) as enrollments  from Courses C
    left join Enrollments E on C.course_id = E.course_id
    group by C.course_id order by enrollments desc ;


--29.Calculate the average time it takes students to graduate, considering their major and any changes in degree programs.
select G.degree_name , department_name , avg(extract(years from G.graduation_date) - extract(years from A.admission_date)) from Graduation as G
    join Students S on G.student_id = S.student_id
    join Admissions A on S.student_id = A.student_id
    join Departments D on S.department_id = D.department_id
    group by G.degree_name, department_name;


--30.Determine if students who complete internships have a higher graduation rate compared to those who do not.

select (cast((select count(I.student_id) from Internships as I
                                join Students S on I.student_id = S.student_id
                                join Graduation G on S.student_id = G.student_id) as numeric)*100)/(select count(student_id) from Graduation) as precent_of_intership;