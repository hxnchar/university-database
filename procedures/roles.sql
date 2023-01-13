CREATE ROLE `studentRole`;
GRANT SELECT ON `examdb`.* TO `studentRole`;
CREATE USER `student1` identified by 'student1pass';
GRANT `studentRole` TO `student1`;
set default role `studentRole` to `student1`;
CREATE USER `student2` identified by 'student2pass';
GRANT `studentRole` TO `student2`;
set default role `studentRole` to `student2`;
CREATE USER `student3` identified by 'student3pass';
GRANT `studentRole` TO `student3`;
set default role `studentRole` to `student3`;

CREATE ROLE `teacherRole`;
GRANT SELECT, UPDATE, INSERT, DELETE ON `examdb`.* TO `teacherRole`;
CREATE USER `teacher1` identified by 'teacher1pass';
GRANT `teacherRole` TO `teacher1`;
set default role `teacherRole` to `teacher1`;
CREATE USER `teacher2` identified by 'teacher2pass';
GRANT `teacherRole` TO `teacher2`;
set default role `teacherRole` to `teacher2`;

CREATE ROLE `adminRole`;
GRANT ALL PRIVILEGES ON `examdb`.* TO `adminRole`;
CREATE USER `admin1` identified by 'admin1pass';
GRANT `adminRole` TO `admin1`;
set default role `adminRole` to `admin1`;
CREATE USER `admin2` identified by 'student2pass';
GRANT `adminRole` TO `admin2`;
set default role `adminRole` to `admin2`;

