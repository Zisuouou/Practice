DROP TABLE WORKS_ON;
DROP TABLE EMPLOYEE;
DROP TABLE DEPARTMENT;
DROP TABLE PROJECT;

CREATE TABLE EMPLOYEE(
            ssn NUMBER(38), PRIMARY KEY(ssn),
            fname VARCHAR2(100),
            lname VARCHAR2(100),
            bdate DATE,
            address VARCHAR2(100),
            sex VARCHAR2(100),
            salary NUMBER(38),
            superssn NUMBER(38) ,
            dno NUMBER(38),
            FOREIGN KEY(superssn) references EMPLOYEE(ssn),
            FOREIGN KEY(dno) references DEPARTMENT(dnumber)
            );
            
CREATE TABLE DEPARTMENT(
             dnumber NUMBER(10),
             dname VARCHAR2(100) not null,
             mgrstartdate DATE,
             dlocation VARCHAR2(30),
             PRIMARY KEY (dnumber));
             
CREATE TABLE WORKS_ON(ssn NUMBER(38),
                     pnumber NUMBER(38),
                     hours NUMBER(38),
                     PRIMARY KEY(ssn, pnumber),
                     FOREIGN KEY(ssn) references EMPLOYEE(ssn),
                     FOREIGN KEY(pnumber) references PROJECT(pnumber));
                     
CREATE TABLE PROJECT(pnumber NUMBER(38),
                    pname VARCHAR2(100),
                    plocation VARCHAR2(100),
                    PRIMARY KEY(pnumber));


SELECT * FROM employee;
                    
                     
            


