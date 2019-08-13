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
Phone_No NUMBER(15)
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
