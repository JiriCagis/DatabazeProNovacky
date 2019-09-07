--Sada 1

--Task 1.5
--Define table named BANDS, which consists of the following columns: band_id – integer, primery key, name – varchar limited to 40 characters, origin_country - varchar limited to 50 characters, formed_year – integer

create table bands
(
    band_id int primary key,
    band_name varchar(40),
    origin_country varchar(50),
    formed_year int
)

--OK


--Task 1.6
--Check the number of records in that table using SELECT count(*) … statement.

Select count(*) from bands

--OK


--Task 1.7
--Insert into the table one record: name: The Beatles, origin_country: England, formed_year 1960

insert into bands (band_ID, band_name, origin_country, formed_year)
values ('1', 'The Beatles', 'England', '1960')

--OK


--Task 1.8
--Display all the data using SELECT statement.

select * from bands

--OK


--Task 1.9
--Check the number of records in that table again.

Select count(*) from bands

--OK


--Task 1.10
--Create another table named MEMBERS consisted of: memeber_id integer incremental from 100 by 1.
--Band_id int, surname varchar limited to 60 characters, name varchar limited to 50 characters.

--krok 1
create sequence members_seq START WITH 100

--krok 2
create table members
(
    member_id int primary key,
    band_id int,
    surname varchar(60),
    member_name varchar(50),
    constraint fk_members foreign key (band_id) references bands(band_id)
) 

--krok 3
create or replace trigger members_trigger
before insert on members
for each row
	begin select members_seq.nextval
	into :new.member_id
	from dual;
end;

--OK


--Task 1.11
--Insert into that table 2 records for The Beatles band: John Lennon and Paul McCartney

insert into members(band_id, surname, member_name) values ('1', 'Lennon', 'John')
insert into members(band_id, surname, member_name) values ('1', 'McCartney', 'Paul')

--OK


--Task 1.12
--Insert into BANDS table another record: name: Queen, origin_country: Great Britain, formed_year: 1971

insert into bands (band_ID, band_name, origin_country, formed_year)
values ('2', 'Queen', 'Great Britain', '1971')

--OK


--Task 1.13
--Insert another member: Freddie Mercury.

insert into members(band_id, surname, member_name)
values ('2', 'Freddie', 'Mercury')

--OK

--Task 1.14
--Add constraint, which doesn’t allow entering year earlier than 1920.

alter table bands add check (formed_year >= 1920)

--OK

--Task 1.15
--Add another record to ensure that the constraint works properly.

insert into bands(band_ID, band_name, origin_country, formed_year)
values ('3', 'Que', 'Britain', '1900')

ORA-02290: check constraint (SQL_YVSMEDTABZKWMINULGNGXNOPP.SYS_C0016729947) violated ORA-06512: at "SYS.DBMS_SQL", line 1721

--OK

--Poznamka:
--Ano je to tak, v predeslem kroku si vytvorila integritni omezeni na formed_year vetsi nez 1920 a ted se pokousis vlozit zaznam mensi nez dane omezeni.
--Databaze spravne vypsala vyse zminenou chybu.