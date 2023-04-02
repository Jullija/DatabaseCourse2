--country
insert into country(country_name)
values ('Polska');

insert into country(country_name)
values ('Francja');

insert into country(country_name)
values ('Czechy');





-- trip

insert into trip(trip_name, country_id, trip_date, max_no_places)
values ('Ahoj przygodo', 1, to_date('2022-06-10','YYYY-MM-DD'), 10);

insert into trip(trip_name, country_id, trip_date,  max_no_places)
values (N'Łoscypek', 1, to_date('2023-07-03','YYYY-MM-DD'), 4);

insert into trip(trip_name, country_id, trip_date,  max_no_places)
values (N'Żelipapą', 2, to_date('2023-05-01','YYYY-MM-DD'), 5);

insert into trip(trip_name, country_id, trip_date,  max_no_places)
values ('Krecik puka w taborecik', 3, to_date('2023-05-01','YYYY-MM-DD'), 2);



-- person

insert into person(firstname, lastname)
values (N'Paweł', N'Gaweł');

insert into person(firstname, lastname)
values ('Joanna', N'Bułeczka');

insert into person(firstname, lastname)
values ('Katarzyna', 'Pierzyna');

insert into person(firstname, lastname)
values ('Adam', 'Padam');

insert into person(firstname, lastname)
values  ('Jakub', N'Burak');

insert into person(firstname, lastname)
values ('Piotr', N'Łotr');

insert into person(firstname, lastname)
values ('Anna', 'Wanna');

insert into person(firstname, lastname)
values ('Helena', 'Polena');

insert into person(firstname, lastname)
values ('Dominik', N'Chałka');

insert into person(firstname, lastname)
values ('Szymon', 'Dywan');


-- reservation
-- trip 1
insert into reservation(trip_id, person_id, status)
values (1, 1, 'P');

insert into reservation(trip_id, person_id, status)
values (1, 2, 'N');

-- trip 2
insert into reservation(trip_id, person_id, status)
values (2, 1, 'P');

insert into reservation(trip_id, person_id, status)
values (2, 4, 'C');

-- trip 3
insert into reservation(trip_id, person_id, status)
values (3, 9, 'P');

-- trip 4
insert into reservation(trip_id, person_id, status)
values (4, 10, 'P');

commit;








