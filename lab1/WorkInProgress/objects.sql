create or replace type TripParticipant as object(
    firstname varchar(50),
    lastname varchar(50),
    person_id int,
    trip_name varchar(100),
    trip_date date
);

create or replace type TripParticipantsTable is table of TripParticipant;


create or replace type PersonReservationsO as object(
    trip_name varchar(100),
    trip_date date,
    trip_id int,
    country_name varchar(50),
    reservation_id int,
    status char(1)
);

create or replace type PersonReservationsTable is table of PersonReservationsO;

commit;

create or replace type AvailableTripsO as object(
    trip_id int,
    trip_name varchar(100),
    country_name varchar(50),
    tripDate date,
    availablePlaces int
);

create or replace type AvailableTripsTable is table of AvailableTripsO;

commit;