-- Exercise 1 SQL

-- Task 1.5
-- Define table named BANDS, which consists of the following columns: band_id – integer, primery key,
-- name – varchar limited to 40 characters, origin_country - varchar limited to 50 characters, formed_year - integer

create table bands
(
band_ID int PRIMARY KEY,
band_name varchar(40),
origin_country varchar(50),
formed_year int
)

-- OK
-- Task 1.6
--Check the number of records in that table using SELECT count(*) … statement.

Select count(*) from bands

-- OK

-- Task 1.7
-- Insert into the table one record: name: The Beatles, origin_country: England, formed_year 1960

insert into bands (band_ID,band_name, origin_country, formed_year) 
values ('1', 'The Beatles', 'England', '1960')

-- OK

-- Task 1.8
-- Display all the data using SELECT statement.
select * from bands

-- OK



-- Task 1.9
-- Check the number of records in that table again.
Select count(*) from bands

-- OK


-- Task 1.10
-- Create another table named MEMBERS consisted of: memeber_id integer incremental from 100 by 1,
-- band_id int, surname varchar limited to 60 characters, name varchar limited to 50 characters.

create sequence members_seq START WITH 100

create table members

(
member_id int,
band_id int,
surname varchar(60),
member_name varchar(50)
)

create or replace trigger members_trigger
before insert on members
for each row
begin 
    select members_seq.nextval
    into :new.member_id
    from dual;
end;

-- OK



-- Task 1.11
-- Insert into that table 2 records for The Beatles band: John Lennon and Paul McCartney
insert into members(surname, member_name)
values ('Lennon', 'John')
insert into members(surname, member_name)
values ('McCartney', 'Paul')

-- OK



-- Task 1.12
-- Insert into BANDS table another record: name: Queen, origin_country: Great Britain, formed_year: 1971
insert into bands (band_ID, band_name, origin_country, formed_year)
values ('2', 'Queen', 'Great Britain', '1971')

-- OK



-- Task 1.13
-- Insert another member: Freddie Mercury.

insert into members(surname, member_name) values ('Freddie', 'Mercury')

-- OK



-- Task 1.14
-- Add constraint, which doesn’t allow entering year earlier than 1920.

alter table bands add check (formed_year > 1920)

-- OK


-- Task 1.15
-- Add another record to ensure that the constraint works properly.

insert into bands(band_ID, band_name, origin_country, formed_year) values ('3', 'Que', 'Britain', '1900')

ORA-02290: check constraint (SQL_YVSMEDTABZKWMINULGNGXNOPP.SYS_C0016729947) violated ORA-06512: at "SYS.DBMS_SQL", line 1721

-- OK, database display error because on column formed_year is defined constrain number > 1920

