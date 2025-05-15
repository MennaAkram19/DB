Enter password: ****
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 15
Server version: 9.3.0 MySQL Community Server - GPL

Copyright (c) 2000, 2025, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> CREATE DATABASE nursery_system;
Query OK, 1 row affected (0.149 sec)

mysql> use nursery_system;
Database changed
mysql> CREATE TABLE Child (
    ->     ChildID INT AUTO_INCREMENT PRIMARY KEY,
    ->     Name VARCHAR(100),
    ->     Age INT,
    ->     Gender ENUM('Male', 'Female'),
    ->     ParentPhone VARCHAR(15)
    -> );
Query OK, 0 rows affected (0.598 sec)

mysql> CREATE TABLE Classroom (
    ->     ClassID INT AUTO_INCREMENT PRIMARY KEY,
    ->     ClassName VARCHAR(100),
    ->     AgeGroup VARCHAR(50),
    ->     TeacherName VARCHAR(100)
    -> );
Query OK, 0 rows affected (0.502 sec)

mysql> CREATE TABLE Attendance (
    ->     AttendanceID INT AUTO_INCREMENT PRIMARY KEY,
    ->     ChildID INT,
    ->     ClassID INT,
    ->     Date DATE,
    ->     FOREIGN KEY (ChildID) REFERENCES Child(ChildID),
    ->     FOREIGN KEY (ClassID) REFERENCES Classroom(ClassID)
    -> );
Query OK, 0 rows affected (0.763 sec)

mysql> CREATE TABLE Activity (
    ->     ActivityID INT AUTO_INCREMENT PRIMARY KEY,
    ->     Name VARCHAR(100),
    ->     Description TEXT,
    ->     Date DATE,
    ->     ClassID INT,
    ->     ChildID INT,
    ->     FOREIGN KEY (ClassID) REFERENCES Classroom(ClassID),
    ->     FOREIGN KEY (ChildID) REFERENCES Child(ChildID)
    -> );
Query OK, 0 rows affected (0.881 sec)

mysql> CREATE TABLE Feedback (
    ->     FeedbackID INT AUTO_INCREMENT PRIMARY KEY,
    ->     ActivityID INT DEFAULT NULL,
    ->     AttendanceID INT DEFAULT NULL,
    ->     Comment TEXT,
    ->     Date DATE,
    ->     TeacherName VARCHAR(100),
    ->     CHECK (
    ->         (ActivityID IS NOT NULL AND AttendanceID IS NULL) OR
    ->         (ActivityID IS NULL AND AttendanceID IS NOT NULL)
    ->     ),
    ->     FOREIGN KEY (ActivityID) REFERENCES Activity(ActivityID),
    ->     FOREIGN KEY (AttendanceID) REFERENCES Attendance(AttendanceID)
    -> );

Query OK, 0 rows affected (1.155 sec)


mysql> CREATE TABLE BelongTo (
    ->     ChildID INT,
    ->     ClassID INT,
    ->     PRIMARY KEY (ChildID, ClassID),
    ->     FOREIGN KEY (ChildID) REFERENCES Child(ChildID),
    ->     FOREIGN KEY (ClassID) REFERENCES Classroom(ClassID)
    -> );
Query OK, 0 rows affected (0.538 sec)



mysql>
mysql> INSERT INTO Child (Name, Age, Gender, ParentPhone) VALUES
    -> ('Ahmed Ali', 4, 'Male', '01012345678'),
    -> ('Mariam Hassan', 3, 'Female', '01098765432'),
    -> ('Youssef Adel', 4, 'Male', '01123456789'),
    -> ('Salma Tarek', 3, 'Female', '01234567890'),
    -> ('Omar Khaled', 5, 'Male', '01199887766'),
    -> ('Farida Mohamed', 4, 'Female', '01011122334'),
    -> ('Kareem Amr', 5, 'Male', '01229988777'),
    -> ('Nourhan Hany', 4, 'Female', '01055667788'),
    -> ('Ziad Mahmoud', 3, 'Male', '01166554433'),
    -> ('Laila Ahmed', 4, 'Female', '01077889966');
Query OK, 10 rows affected (0.179 sec)
Records: 10  Duplicates: 0  Warnings: 0

mysql> INSERT INTO Classroom (ClassName, AgeGroup, TeacherName) VALUES
    -> ('Class 1/1', '3-4', 'Miss Sara'),
    -> ('Class 1/2', '4-5', 'Miss Mona'),
    -> ('Class 1/3', '3-4', 'Miss Dalia'),
    -> ('Class 1/4', '4-5', 'Miss Heba');
Query OK, 4 rows affected (0.102 sec)
Records: 4  Duplicates: 0  Warnings: 0


mysql> INSERT INTO Activity (Name, Description, Date, ClassID, ChildID) VALUES
    -> ('Coloring', 'Coloring shapes with crayons', '2025-05-08', 2, 1),
    -> ('Story Time', 'Listening to a short story', '2025-05-08', 1, 2),
    -> ('Lego Play', 'Building towers with Legos', '2025-05-09', 2, 3),
    -> ('Drawing', 'Free drawing session', '2025-05-09', 3, 4),
    -> ('Music', 'Singing and clapping rhythms', '2025-05-09', 4, 5),
    ->
    -> ('Coloring', 'Coloring animals', '2025-05-10', 2, 6),
    -> ('Puzzle Solving', 'Solving shape puzzles', '2025-05-10', 4, 7),
    -> ('Clay Modeling', 'Making objects from clay', '2025-05-10', 3, 8),
    -> ('Story Time', 'Story about kindness', '2025-05-10', 1, 9),
    -> ('Counting', 'Counting objects activity', '2025-05-10', 2, 10);
Query OK, 10 rows affected (0.119 sec)
Records: 10  Duplicates: 0  Warnings:



mysql> INSERT INTO Attendance (ChildID, ClassID, Date) VALUES
    -> (1, 2, '2025-05-08'),
    -> (2, 1, '2025-05-08'),
    -> (3, 2, '2025-05-08'),
    -> (4, 3, '2025-05-08'),
    -> (5, 4, '2025-05-08'),
    ->
    -> (1, 2, '2025-05-09'),
    -> (2, 1, '2025-05-09'),
    -> (3, 2, '2025-05-09'),
    -> (4, 3, '2025-05-09'),
    -> (5, 4, '2025-05-09'),
    ->
    -> (6, 2, '2025-05-10'),
    -> (7, 4, '2025-05-10'),
    -> (8, 3, '2025-05-10'),
    -> (9, 1, '2025-05-10'),
    -> (10,2, '2025-05-10');
Query OK, 15 rows affected (0.139 sec)
Records: 15  Duplicates: 0  Warnings: 0


mysql> INSERT INTO Feedback (ActivityID, Comment, Date, TeacherName) VALUES
    -> (1, 'Ahmed was very focused during coloring.', '2025-05-08', 'Miss Mona'),
    -> (2, 'Mariam enjoyed the story and asked questions.', '2025-05-08', 'Miss Sara'),
    -> (3, 'Youssef showed creativity with Lego.', '2025-05-09', 'Miss Mona'),
    -> (5, 'Omar participated well in the music session.', '2025-05-09', 'Miss Heba'),
    -> (10, 'Laila was quick in counting and very attentive.', '2025-05-10', 'Miss Mona');
Query OK, 5 rows affected (0.100 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> INSERT INTO Feedback (AttendanceID, Comment, Date, TeacherName) VALUES
    -> (1, 'Ahmed arrived early and participated well.', '2025-05-08', 'Miss Mona'),
    -> (4, 'Salma was a bit shy but attentive.', '2025-05-08', 'Miss Dalia'),
    -> (14, 'Ziad was cheerful and played nicely.', '2025-05-10', 'Miss Sara');
Query OK, 3 rows affected (0.103 sec)
Records: 3  Duplicates: 0  Warnings: 0


mysql> INSERT INTO BelongTo (ChildID, ClassID) VALUES
    -> (1, 2),
    -> (2, 1),
    -> (3, 2),
    -> (4, 3),
    -> (5, 4),
    -> (6, 2),
    -> (7, 4),
    -> (8, 3),
    -> (9, 1),
    -> (10, 2);
Query OK, 10 rows affected (0.099 sec)
Records: 10  Duplicates: 0  Warnings: 0

mysql> SELECT Child.Name, Activity.Name AS ActivityName, Activity.Description, Activity.Date
    -> FROM Activity
    -> JOIN Child ON Activity.ChildID = Child.ChildID
    -> WHERE Child.Name = 'Mariam Hassan';
+---------------+--------------+----------------------------+------------+
| Name          | ActivityName | Description                | Date       |
+---------------+--------------+----------------------------+------------+
| Mariam Hassan | Story Time   | Listening to a short story | 2025-05-08 |
+---------------+--------------+----------------------------+------------+
1 row in set (0.020 sec)

mysql> SELECT Child.Name, Attendance.Date, Classroom.ClassName
    -> FROM Attendance
    -> JOIN Child ON Attendance.ChildID = Child.ChildID
    -> JOIN Classroom ON Attendance.ClassID = Classroom.ClassID
    -> WHERE Child.Name = 'Ahmed Ali';
+-----------+------------+-----------+
| Name      | Date       | ClassName |
+-----------+------------+-----------+
| Ahmed Ali | 2025-05-08 | Class 1/2 |
| Ahmed Ali | 2025-05-09 | Class 1/2 |
+-----------+------------+-----------+
2 rows in set (0.011 sec)

mysql> SELECT Feedback.Comment, Feedback.Date, Activity.Name AS ActivityName, Child.Name AS ChildName
    -> FROM Feedback
    -> JOIN Activity ON Feedback.ActivityID = Activity.ActivityID
    -> JOIN Child ON Activity.ChildID = Child.ChildID;
+-------------------------------------------------+------------+--------------+---------------+
| Comment                                         | Date       | ActivityName | ChildName     |
+-------------------------------------------------+------------+--------------+---------------+
| Very creative work!                             | 2025-05-08 | Coloring     | Ahmed Ali     |
| Ahmed was very focused during coloring.         | 2025-05-08 | Coloring     | Ahmed Ali     |
| Good listening skills.                          | 2025-05-08 | Story Time   | Mariam Hassan |
| Mariam enjoyed the story and asked questions.   | 2025-05-08 | Story Time   | Mariam Hassan |
| Excellent building skills!                      | 2025-05-09 | Lego Play    | Youssef Adel  |
| Youssef showed creativity with Lego.            | 2025-05-09 | Lego Play    | Youssef Adel  |
| Omar participated well in the music session.    | 2025-05-09 | Music        | Omar Khaled   |
| Laila was quick in counting and very attentive. | 2025-05-10 | Counting     | Laila Ahmed   |
+-------------------------------------------------+------------+--------------+---------------+
8 rows in set (0.040 sec)

mysql> SELECT
    ->     Child.Name AS ChildName,
    ->     Classroom.ClassName,
    ->     Classroom.TeacherName
    -> FROM BelongTo
    -> JOIN Child ON BelongTo.ChildID = Child.ChildID
    -> JOIN Classroom ON BelongTo.ClassID = Classroom.ClassID;
+----------------+-----------+-------------+
| ChildName      | ClassName | TeacherName |
+----------------+-----------+-------------+
| Mariam Hassan  | Class 1/1 | Miss Sara   |
| Ziad Mahmoud   | Class 1/1 | Miss Sara   |
| Ahmed Ali      | Class 1/2 | Miss Mona   |
| Youssef Adel   | Class 1/2 | Miss Mona   |
| Farida Mohamed | Class 1/2 | Miss Mona   |
| Laila Ahmed    | Class 1/2 | Miss Mona   |
| Salma Tarek    | Class 1/1 | Miss Sara   |
| Nourhan Hany   | Class 1/1 | Miss Sara   |
| Omar Khaled    | Class 1/2 | Miss Mona   |
| Kareem Amr     | Class 1/2 | Miss Mona   |
+----------------+-----------+-------------+
10 rows in set (0.081 sec)

mysql> SELECT
    ->     Feedback.Comment,
    ->     Feedback.Date,
    ->     Child.Name AS ChildName,
    ->     Classroom.ClassName,
    ->     Attendance.Date AS AttendanceDate
    -> FROM Feedback
    -> JOIN Attendance ON Feedback.AttendanceID = Attendance.AttendanceID
    -> JOIN Child ON Attendance.ChildID = Child.ChildID
    -> JOIN Classroom ON Attendance.ClassID = Classroom.ClassID;
+--------------------------------------------+------------+--------------+-----------+----------------+
| Comment                                    | Date       | ChildName    | ClassName | AttendanceDate |
+--------------------------------------------+------------+--------------+-----------+----------------+
| Ahmed arrived early and participated well. | 2025-05-08 | Ahmed Ali    | Class 1/2 | 2025-05-08     |
| Salma was a bit shy but attentive.         | 2025-05-08 | Salma Tarek  | Class 1/1 | 2025-05-08     |
| Ziad was cheerful and played nicely.       | 2025-05-10 | Ziad Mahmoud | Class 1/1 | 2025-05-10     |
+--------------------------------------------+------------+--------------+-----------+----------------+
3 rows in set (0.029 sec)

mysql> SELECT
    ->     Activity.Date,
    ->     COUNT(*) AS TotalActivities
    -> FROM Activity
    -> GROUP BY Activity.Date
    -> ORDER BY Activity.Date;
+------------+-----------------+
| Date       | TotalActivities |
+------------+-----------------+
| 2025-05-08 |               2 |
| 2025-05-09 |               3 |
| 2025-05-10 |               5 |
+------------+-----------------+
3 rows in set (0.027 sec)

mysql> SELECT
    ->     c.ChildID,
    ->     c.Name AS ChildName,
    ->     c.Age,
    ->     c.Gender,
    ->     c.ParentPhone,
    ->     cl.ClassName,
    ->     cl.TeacherName,
    ->     a.Date AS AttendanceDate,
    ->     act.Name AS ActivityName,
    ->     act.Description AS ActivityDescription,
    ->     act.Date AS ActivityDate,
    ->     f.Comment AS FeedbackComment,
    ->     f.Date AS FeedbackDate,
    ->     f.TeacherName AS FeedbackTeacher
    -> FROM Child c
    -> LEFT JOIN BelongTo b ON c.ChildID = b.ChildID
    -> LEFT JOIN Classroom cl ON b.ClassID = cl.ClassID
    -> LEFT JOIN Attendance a ON c.ChildID = a.ChildID
    -> LEFT JOIN Activity act ON c.ChildID = act.ChildID
    -> LEFT JOIN Feedback f ON (f.ActivityID = act.ActivityID OR f.AttendanceID = a.AttendanceID)
    -> WHERE c.Name = 'Ahmed Ali';
+---------+-----------+------+--------+-------------+-----------+-------------+----------------+--------------+------------------------------+--------------+--------------------------------------------+--------------+-----------------+
| ChildID | ChildName | Age  | Gender | ParentPhone | ClassName | TeacherName | AttendanceDate | ActivityName | ActivityDescription          | ActivityDate | FeedbackComment                            | FeedbackDate | FeedbackTeacher |
+---------+-----------+------+--------+-------------+-----------+-------------+----------------+--------------+------------------------------+--------------+--------------------------------------------+--------------+-----------------+
|       1 | Ahmed Ali |    4 | Male   | 01012345678 | Class 1/2 | Miss Mona   | 2025-05-08     | Coloring     | Coloring shapes with crayons | 2025-05-08   | Very creative work!                        | 2025-05-08   | Miss Mona       |
|       1 | Ahmed Ali |    4 | Male   | 01012345678 | Class 1/2 | Miss Mona   | 2025-05-08     | Coloring     | Coloring shapes with crayons | 2025-05-08   | Ahmed was very focused during coloring.    | 2025-05-08   | Miss Mona       |
|       1 | Ahmed Ali |    4 | Male   | 01012345678 | Class 1/2 | Miss Mona   | 2025-05-08     | Coloring     | Coloring shapes with crayons | 2025-05-08   | Ahmed arrived early and participated well. | 2025-05-08   | Miss Mona       |
|       1 | Ahmed Ali |    4 | Male   | 01012345678 | Class 1/2 | Miss Mona   | 2025-05-09     | Coloring     | Coloring shapes with crayons | 2025-05-08   | Very creative work!                        | 2025-05-08   | Miss Mona       |
|       1 | Ahmed Ali |    4 | Male   | 01012345678 | Class 1/2 | Miss Mona   | 2025-05-09     | Coloring     | Coloring shapes with crayons | 2025-05-08   | Ahmed was very focused during coloring.    | 2025-05-08   | Miss Mona       |
|      11 | Ahmed Ali |    4 | Male   | 01012345678 | NULL      | NULL        | NULL           | NULL         | NULL                         | NULL         | NULL                                       | NULL         | NULL            |
+---------+-----------+------+--------+-------------+-----------+-------------+----------------+--------------+------------------------------+--------------+--------------------------------------------+--------------+-----------------+
6 rows in set (0.036 sec)

mysql> SELECT
    ->     (SELECT COUNT(*) FROM Child) AS TotalChildren,
    ->     (SELECT COUNT(*) FROM Classroom) AS TotalClasses,
    ->     (SELECT COUNT(*) FROM Activity) AS TotalActivities,
    ->     (SELECT COUNT(*) FROM Feedback) AS TotalFeedbacks;
+---------------+--------------+-----------------+----------------+
| TotalChildren | TotalClasses | TotalActivities | TotalFeedbacks |
+---------------+--------------+-----------------+----------------+
|            20 |            6 |              10 |             11 |
+---------------+--------------+-----------------+----------------+
1 row in set (0.184 sec)


