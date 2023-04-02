create view Reservations
as
    select c.country_name, t.trip_date, t.trip_name, t.trip_id,
           p.firstname, p.lastname, p.person_id, r.reservation_id,
           r.status, GETLEFTPLACES(t.trip_id) as AvailablePlaces

    from reservation r inner join trip t on r.trip_id = t.trip_id
        inner join country c on t.country_id = c.country_id
        inner join person p on r.person_id = p.person_id;
commit;



create view Trips
as
    select c.country_name, t.trip_date as tripDate, t.trip_name, t.trip_id,
           getBookedPlaces(t.trip_id) as bookedPlaces,
           getLeftPlaces(t.trip_id) as availablePlaces
    from country c inner join trip t on c.country_id = t.country_id;
commit;




create view AvailableTrips
as
    select country_name, tripDate, trip_name, trip_id, bookedPlaces, availablePlaces from Trips
    where availablePlaces > 0 and tripDate > SYSDATE;
commit;




--STRUCTURE CHANGED
create view ReservationsViewChanged
as
    select c.country_name, t.trip_date, t.trip_name, t.trip_id,
           p.firstname, p.lastname, p.person_id, r.reservation_id,
           r.status, t.no_available_places as AvailablePlaces

    from reservation r inner join trip t on r.trip_id = t.trip_id
        inner join country c on t.country_id = c.country_id
        inner join person p on r.person_id = p.person_id;
commit;


create view TripsViewChanged
as
    select c.country_name, t.trip_date as tripDate, t.trip_name, t.trip_id,
           t.max_no_places - t.no_available_places as bookedPlaces,
           t.no_available_places as availablePlaces
    from country c inner join trip t on c.country_id = t.country_id;
commit;

create view AvailableTripsViewChanged
as
    select country_name, tripDate, trip_name, trip_id, bookedPlaces, availablePlaces from  TripsViewChanged
    where availablePlaces > 0 and tripDate > SYSDATE;
commit;


--tests
select * from ReservationsViewChanged;
select * from TripsViewChanged;
select * from AvailableTripsViewChanged;

select * from Trips;


