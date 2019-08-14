-- Exercise 2 SQL

-- Task 2.1 table members
-- MEMEBERS table
--      CardNo - 5 characters, primary key,
--      Surname - up to 15 characters,
--      Name – as above,
--      Address –up to 150 characters,
--      Name, Surname, Birthday_date – not null,
--      Gender - 1 char: M or F letter,
--      Phone_No – up to 15 characters

create table members
(
CardNo char(5) primary key,
surname varchar(15),
member_name varchar(15) NOT NULL,
adress varchar(150) NOT NULL,
Birth_date date NOT NULL,
Gender char(1),
Phone_no varchar(15)
);

-- Poznámka: Jak nastavit podminku pro NOT NULL sloupecek
-- ALTER TABLE table_name
-- MODIFY column_name data_type NOT NULL

-- OK



-- Task 2.1 table employees
-- Employees table
--      emp_id - primery key with identity set (seed = 1, incerement=1) ,
--      Surname, Name and Birthday_date are not null,
--      birthday date must be earlier than date of employment (Emp_Date),

spoušteno po jednom:

--krok 1
create sequence employees_seq START WITH 1;

--krok 2
create table employees
(
emp_id int PRIMARY KEY,
surname varchar(15) NOT NULL,
employee_name varchar(15) NOT NULL,
Birth_date DATE NOT NULL,
emp_date DATE
);

--krok 3
create or replace trigger employees_trigger
before insert on employees
for each row
begin 
    select employees_seq.nextval
    into :new.emp_id
    from dual;
end;

alter table employees add constraint check_dates check (Birth_date < emp_date);


-- OK

-- Task 2.1 table publishers
--      pub_id is a primary key with identity set (seed=1, incerement=1),
--      Name, City, - not null, up to 50 characters,
--      Phone_No - up to 15 charakters,

spoušteno po jednom:

--krok 1
create sequence publisher_seq START WITH 1

--krok 2
create table publishers
(
pub_id int PRIMARY KEY,
pub_name varchar(50) NOT NULL,
City varchar(50) NOT NULL,
Phone_No varchar(15)
);

--krok 3
create or replace trigger publisher_trigger
before insert on publishers
for each row
begin 
    select publisher_seq.nextval
    into :new.pub_id
    from dual;
end;

-- OK 

-- Task 2.1 table books
--      BookID - primary key, 5 characters,
--      Pub_ID - foreign key related to Publishers,
--      Type - charaters, must contain one of the following values: novel, historical, for kids, poems, crime, story, science fiction, science
--      Price is a currency field (money), not null,
--      Title - up to 40 characters, not null,
create table books 
( 
    book_id char(5) PRIMARY KEY, 
    pub_id int, 
    Title varchar(40) NOT NULL, 
    Price number(19,4) NOT NULL, 
    PagesNo int, 
    BookType varchar(100), 
    CONSTRAINT fk_publishers FOREIGN KEY (pub_id) REFERENCES publishers(pub_id) 
)

-- OK

-- Task 2.1 table book_loans
--      LoanID - integer with identity set (seed = 1, increment = 1), primary key,
--      CardNo, BookID and emp_id are foreign keys related to Members, Books and Employees,
--      DateOut must be earlier than DueDate,
--      Penalty can't contain negative values, default is set to 0 (zero),

--krok 1
create sequence book_loans_seq START WITH 1

--krok 2
drop table book_loans;
create table book_loans
(
loan_id int PRIMARY KEY,
book_id char(5),
cardNo char(5),
emp_id int,
DateOut date,
DueDate date,
Penalty int default 0,

constraint fk_books_book_loans foreign key (book_ID) REFERENCES books(book_id),
constraint fk_members_book_loans  foreign key (cardNo) REFERENCES members(cardNo),
constraint fk_employees_book_loans  foreign key (emp_ID) REFERENCES employees(emp_id),
constraint check_dates_book_loans  check (DateOut < DueDate),
constraint check_penalty_book_loans  check (penalty > 0)
);


-- Task 2.2 Insert data into generated tables
INSERT INTO members VALUES('SJ123','Smith','Joseph','64101500456',  to_date('1964/10/15','yyyy/mm/dd'), 'M','0427650912');
INSERT INTO members VALUES('WJ090','Wallace','Jennifer','76051900953',to_date('1976/05/19','yyyy/mm/dd'), 'F','0238651112');
INSERT INTO members VALUES('CA009','Carter','Alicia','78070900953',to_date('1978/09/07','yyyy/mm/dd'), 'F','0427770822');
INSERT INTO members VALUES('BA111','Best','Alec','62090200953',to_date('1962/02/09','yyyy/mm/dd'), 'M','0123310345');
INSERT INTO members VALUES('CC212','Chace','Chris','67032000322',to_date('1967/03/20','yyyy/mm/dd'), 'M','0231510885');

INSERT INTO employees (surname,employee_name,birth_date,emp_date) VALUES('Knight','Brad',to_date('1965/10/21','yyyy/mm/dd'),to_date('1999/06/11','yyyy/mm/dd'));
INSERT INTO employees (surname,employee_name,birth_date,emp_date) VALUES('Jones','Adam',to_date('1968/11/21','yyyy/mm/dd'),to_date('1998/10/01','yyyy/mm/dd'));
INSERT INTO employees (surname,employee_name,birth_date,emp_date) VALUES('Grace','Andy',to_date('1975/10/23','yyyy/mm/dd'),to_date('2001/03/05','yyyy/mm/dd'));
INSERT INTO employees (surname,employee_name,birth_date,emp_date) VALUES('King','Ray',to_date('1975/06/02','yyyy/mm/dd'),to_date('2001/10/21','yyyy/mm/dd'));
INSERT INTO employees (surname,employee_name,birth_date,emp_date) VALUES('Reedy','Kate',to_date('1968/12/05','yyyy/mm/dd'),to_date('1998/01/01','yyyy/mm/dd'));
INSERT INTO employees (surname,employee_name,birth_date,emp_date) VALUES('Jarvis','Jill',to_date('1979/05/11','yyyy/mm/dd'),to_date('2001/09/05','yyyy/mm/dd'));
INSERT INTO employees (surname,employee_name,birth_date,emp_date) VALUES('Brown','Marie',to_date('1963/08/14','yyyy/mm/dd'),to_date('1998/01/01','yyyy/mm/dd'));
INSERT INTO employees (surname,employee_name,birth_date,emp_date) VALUES('Bays','Bonnie',to_date('1984/03/18','yyyy/mm/dd'),to_date('2002/03/01','yyyy/mm/dd'));
INSERT INTO employees (surname,employee_name,birth_date,emp_date) VALUES('Small','Elisabeth',to_date('1983/06/07','yyyy/mm/dd'),to_date('2002/09/15','yyyy/mm/dd'));
INSERT INTO employees (surname,employee_name,birth_date,emp_date) VALUES('Brand','Anne',to_date('1970/08/17','yyyy/mm/dd'),to_date('2001/03/04','yyyy/mm/dd'));

INSERT INTO publishers (pub_name, City, Phone_No) VALUES ('Berkley Publishing','Boston','635-12-09');
INSERT INTO publishers (pub_name, City, Phone_No) VALUES ('Course Technology', 'New York','025-22-03');
INSERT INTO publishers (pub_name, City, Phone_No) VALUES ('Touchstone Books', 'Westport CT','635-42-11');
INSERT INTO publishers (pub_name, City, Phone_No) VALUES ('Dom Ksi¹¿ki', 'Poznañ','775-24-92');
INSERT INTO publishers (pub_name, City, Phone_No) VALUES ('Penguin USA', 'New York','305-32-34');

INSERT INTO Books VALUES(1,1,'Electric Light',45.50,320,'science');
INSERT INTO Books VALUES(2,2,'A Guide to SQL',68.90, 240,'science');
INSERT INTO Books VALUES(3,3,'Travels with Charley',39.90, 120, 'novel');
INSERT INTO Books VALUES(4,3,'Band of Brothers', 62.70, 359,'historical');
INSERT INTO Books VALUES(5,3,'Shortest Poems', 55.20, 322,'poems');
INSERT INTO Books VALUES(6,4,'Harry Potter and the Prisoner of Azkaban',29.00, 102, 'science fiction');
INSERT INTO Books VALUES(7,4,'Harry Potter and the Goblet of Fire', 21.30, 89, 'science fiction');
INSERT INTO Books VALUES(8,5,'Little Wind', 19.20, 55, 'for kids');
INSERT INTO Books VALUES(9,5,'Nine Stories', 15.90, 35, 'for kids');
INSERT INTO Books VALUES(10,2,'SQL for Dummies', 85.90, 210, 'science');
INSERT INTO Books VALUES(11,3,'East of Eden', 23.20, 384, 'novel');
INSERT INTO Books VALUES(12,3,'Van Gogh and Gauguin', 25.40, 245, 'historical');

INSERT INTO Book_loans VALUES(1,'SJ123',4,to_date('2008/03/01','yyyy/mm/dd'),to_date('2008/07/28','yyyy/mm/dd'), 25.50);
INSERT INTO Book_loans VALUES(2,'WJ090',2,to_date('2008/03/04','yyyy/mm/dd'),to_date('2008/06/18','yyyy/mm/dd'),5.20);
INSERT INTO Book_loans (BookID,CardNo,emp_id,DateOut,DueDate) VALUES(3,'CA009',2,to_date('2008/03/04','yyyy/mm/dd'),to_date('2008/03/20','yyyy/mm/dd'));
INSERT INTO Book_loans (BookID,CardNo,emp_id,DateOut,DueDate) VALUES(8,'CA009',1,to_date('2008/03/20','yyyy/mm/dd'),to_date('2008/04/10','yyyy/mm/dd'));
INSERT INTO Book_loans (BookID,CardNo,emp_id,DateOut,DueDate) VALUES(8,'WJ090',1,to_date('2008/04/12','yyyy/mm/dd'),to_date('2008/04/30','yyyy/mm/dd'));
INSERT INTO Book_loans (BookID,CardNo,emp_id,DateOut,DueDate) VALUES(4,'BA111',6,to_date('2008/04/15','yyyy/mm/dd'),to_date('2008/06/12','yyyy/mm/dd'));
INSERT INTO Book_loans (BookID,CardNo,emp_id,DateOut,DueDate) VALUES(5,'BA111',6,to_date('2008/04/15','yyyy/mm/dd'),to_date('2008/06/12','yyyy/mm/dd'));
INSERT INTO Book_loans (BookID,CardNo,emp_id,DateOut,DueDate) VALUES(5,'CC212',6,to_date('2008/06/21','yyyy/mm/dd'),to_date('2008/07/29','yyyy/mm/dd'));
INSERT INTO Book_loans (BookID,CardNo,emp_id,DateOut,DueDate) VALUES(10,'CC212',6,to_date('2008/06/21','yyyy/mm/dd'),to_date('2008/08/08','yyyy/mm/dd'));
INSERT INTO Book_loans VALUES(10,'SJ123',7,to_date('2008/08/21','yyyy/mm/dd'),to_date('2008/11/09','yyyy/mm/dd'),8.80);
INSERT INTO Book_loans VALUES(4,'CA009',7,to_date('2008/08/22','yyyy/mm/dd'),to_date('2008/12/18','yyyy/mm/dd'),7.5);
INSERT INTO Book_loans (BookID,CardNo,emp_id,DateOut,DueDate) VALUES(2,'CC212',8,to_date('2008/11/16','yyyy/mm/dd'),to_date('2009/01/19','yyyy/mm/dd'));
INSERT INTO Book_loans (BookID,CardNo,emp_id,DateOut,DueDate) VALUES(2,'CC212',8,to_date('2008/11/17','yyyy/mm/dd'), NULL);
INSERT INTO Book_loans (BookID,CardNo,emp_id,DateOut,DueDate) VALUES(11,'WJ090',9,to_date('2008/11/21','yyyy/mm/dd'), NULL);
