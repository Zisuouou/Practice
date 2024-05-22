CREATE TABLE STUDENT(sno NUMBER(30), pno NUMBER(30), 
                    sname VARCHAR2(100), year NUMBER(30), dept VARCHAR2(200), 
                    PRIMARY KEY (sno), 
                    CONSTRAINT STUDENT_FK FOREIGN KEY (pno)
                    REFERENCES PROFESSOR(pno)
                    ON DELETE SET NULL);
                    
INSERT INTO STUDENT VALUES (123, 1127, 'test', 4,'DT');      
INSERT INTO STUDENT VALUES (1212, 1127, 'TEST1', 4, 'CE');
INSERT INTO ENROLL VALUES (1212, 'CS001', 'B', 82);

select * from ENROLL;

CREATE TABLE PROFESSOR(pno NUMBER(30), pname VARCHAR2(100), 
                        pmajor VARCHAR2(200), pdept VARCHAR2(200), 
                        PRIMARY KEY (pno));

CREATE TABLE COURSE(cno VARCHAR2(100), cname VARCHAR2(100), 
                    credit NUMBER(30), sessions NUMBER(30), 
                    PRIMARY KEY (cno));
                    
SELECT * FROM PROFESSOR WHERE PNAME = 'Jonghoon Chun';
SELECT * FROM LECTURE;

INSERT INTO COURSE VALUES ('CS010', 'SCIENCE', 1, 1); 
INSERT INTO LECTURE VALUES ('CS010', 1106, 'MON111', 'YY11');

CREATE TABLE ENROLL (
    sno NUMBER(10),
    cno VARCHAR2(100),
    grade VARCHAR2(10),
    exam NUMBER(10),
    PRIMARY KEY (sno, cno),
    CONSTRAINT ENROLL_FK FOREIGN KEY (sno) REFERENCES STUDENT(sno) ON DELETE SET NULL,
    CONSTRAINT ENROLL_FK2 FOREIGN KEY (cno) REFERENCES COURSE(cno) ON DELETE SET NULL
);
                    
CREATE TABLE LECTURE(
    cno VARCHAR2(100), 
    pno NUMBER(30), 
    lec_time VARCHAR2(100), 
    room VARCHAR2(100),
    PRIMARY KEY(cno, pno),
    CONSTRAINT LECTURE_FK FOREIGN KEY (cno) REFERENCES COURSE(cno) ON DELETE SET NULL,
    CONSTRAINT LECTURE_FK2 FOREIGN KEY (pno) REFERENCES PROFESSOR(pno) ON DELETE SET NULL);

# 1번
SELECT s.sname
FROM STUDENT s
WHERE s.dept = 'DT' AND s.year = 4;

select * from student;

# 2번
SELECT c.cname
FROM COURSE c
JOIN LECTURE l ON c.cno = l.cno
JOIN PROFESSOR p ON l.pno = p.pno
WHERE p.pname = 'Jonghoon Chun';

# 3번
-- A가 하나라도 있는 학생
SELECT S.sname FROM student S
WHERE EXISTS (SELECT *
            FROM ENROLL E
            WHERE E.sno = S.sno
            AND E.grade = 'A'); 
            
SELECT * FROM ENROLL E, STUDENT S
    WHERE E.sno = S.sno
    AND E.grade = 'A';

-- 성적이 전부 A인 학생
SELECT S.sname FROM student S
WHERE NOT EXISTS (SELECT *
            FROM ENROLL E
            WHERE E.sno = S.sno
            AND E.grade != 'A');

-- A가 아닌 애들만
SELECT * FROM ENROLL E, STUDENT S
    WHERE E.sno = S.sno
    AND E.grade != 'A';

# 4번
-- A가 아닌 과목들만 뽑힘
SELECT S.sname, S.dept FROM student S
WHERE EXISTS (SELECT E.grade
            FROM ENROLL E
            WHERE E.sno = S.sno
            AND E.grade != 'A');
            
-- A가 아예 없는 학생들
SELECT E.grade
    FROM ENROLL E, STUDENT S
    WHERE E.sno = S.sno
    AND E.grade != 'A';

-- NOT EXISTS 조건
-- 전과목이 A가 아닌애들
SELECT S.sname FROM student S
WHERE NOT EXISTS (SELECT E.grade
            FROM ENROLL E
            WHERE E.sno = S.sno
            AND E.grade = 'A');




SELECT DISTINCT s.sname, s.dept
FROM STUDENT s
JOIN ENROLL e ON s.sno = e.sno
WHERE e.grade != 'A';

# 5번

ALTER TABLE ENROLL DROP CONSTRAINT ENROLL_FK2;
ALTER TABLE LECTURE DROP CONSTRAINT LECTURE_FK;


DELETE FROM COURSE
WHERE cno IN (
    SELECT c.cno
    FROM COURSE c
    JOIN LECTURE l ON c.cno = l.cno
    JOIN PROFESSOR p ON l.pno = p.pno
    WHERE p.pdept = 'CE'
);


