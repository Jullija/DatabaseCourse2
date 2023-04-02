
--function to get how many trips are booked
create or replace function getBookedPlaces(tripID int)
    return int
as
    result int;
begin
    select count(r.status) into result
    from reservation r
    where r.trip_id = tripID and r.status != 'C';

    return result;
end;
commit;

--function to get how many places are left
create or replace function getLeftPlaces(tripID int)
    return int
as
    result int;
begin
    select t.max_no_places - getBookedPlaces(tripID) into result
    from trip t where tripID = t.trip_id;

    return result;
end;
commit;


--function to check if the trip exists
create or replace function tripExistence(tripID int)
    return boolean
as
    exist number;
begin
    select case
        when exists(select * from trip where trip.trip_id = tripID) then 1
        else 0
    end
    into exist from dual;

    if exist = 1 then
        return true;
    else
        return false;
    end if;
end;
commit;


--function to check if the person exists
create or replace function personExistence(personID int)
    return boolean
as
    exist number;
begin
    select case
        when exists(select * from person where person.person_id = personID) then 1
        else 0
    end
    into exist from dual;

    if exist = 1 then
        return true;
    else
        return false;
    end if;
end;
commit;

--function to check if the reservation exists
create or replace function reservationExistence(reservationID int)
    return boolean
as
    exist number;
begin
    select case
        when exists(select * from reservation where reservation.reservation_id = reservationID) then 1
        else 0
    end
    into exist from dual;

    if exist = 1 then
        return true;
    else
        return false;
    end if;
end;
commit;



--function to check if the date of the trip is correct
create or replace function isTheDateCorrect(tripID int, givenDate date default SYSDATE)
    return boolean
as
    result date;
begin


    if not tripExistence(tripID) then
        raise_application_error(-2000, 'The trip does not exist');
    end if;

    select trip_date into result from trip where trip_id = tripID;

    if givenDate >= result then --false when the trip has taken place earlier
        return false;
    else
        return true;
    end if;
end;
commit;


create or replace function checkingConditions(tripID int, givenDate date default SYSDATE)
    return boolean
as
    result date;
    exist number;
begin

    select case
        when exists(select * from trip where trip.trip_id = tripID) then 1
        else 0
    end
    into exist from dual;

    if exist = 0 then
        raise_application_error(-2000, 'The trip does not exist');
    end if;

    select trip_date into result from trip where trip_id = tripID;

    if givenDate >= result then --false when the trip has taken place earlier
        return false;
    else
        return true;
    end if;
end;
commit;




--functions returning tables

--function to see the participants of the trip - 4a)
create or replace function TripParticipants(tripID int)
    return TripParticipantsTable
as
    result TripParticipantsTable;
begin
    if not tripExistence(tripID) then
        raise_application_error(-2000, 'There are no such trip in the database');
    end if;

    select TripParticipant(firstname, lastname, person_id, trip_name, trip_date)
        bulk collect into result
    from Reservations
    where tripID = trip_id;

    return result;
end;
commit;

--function to see te person's reservations - 4b)
create or replace function PersonReservations(personID int)
    return PersonReservationsTable
as
    result PersonReservationsTable;
begin
    if not personExistence(personID) then
        raise_application_error(-2000, 'There are no such person in the database');
    end if;

    select PersonReservationsO(trip_name, trip_date, trip_id, country_name, reservation_id, status)
        bulk collect into result
    from Reservations
    where personID=person_id;

    return result;
end;
commit;



--function to get available trip to given country withing given date - 4c)
create or replace function AvailableTripsTo(countryName varchar, dateFrom date, dateTo date)
    return AvailableTripsTable
as
    result AvailableTripsTable;
begin
    if dateFrom > dateTo then raise_application_error(-2000, 'Wrong date given');
    end if;

    if dateFrom < sysdate then raise_application_error(-2000, 'Wrong date given');
    end if;

    select AvailableTripsO(trip_id, trip_name, country_name, tripDate, availablePlaces)
    bulk collect into result
    from AvailableTrips
    where country_name = countryName and tripDate between dateFrom and dateTo;

    return result;
end;
commit;





--STRUCTURE CHANGED
--function to see the participants of the trip
create or replace function TripParticipantsChanged(tripID int)
    return TripParticipantsTable
as
    result TripParticipantsTable;
begin
    if not tripExistence(tripID) then
        raise_application_error(-2000, 'There are no such trip in the database');
    end if;

    select TripParticipant(firstname, lastname, person_id, trip_name, trip_date)
        bulk collect into result
    from ReservationsViewChanged
    where tripID = trip_id;

    return result;
end;
commit;

--function to see te person's reservations
create or replace function PersonReservationsChanged(personID int)
    return PersonReservationsTable
as
    result PersonReservationsTable;
begin
    if not personExistence(personID) then
        raise_application_error(-2000, 'There are no such person in the database');
    end if;

    select PersonReservationsO(trip_name, trip_date, trip_id, country_name, reservation_id, status)
        bulk collect into result
    from ReservationsViewChanged
    where personID=person_id;

    return result;
end;
commit;



--function to get available trip to given country withing given date
create or replace function AvailableTripsToChanged(countryName varchar, dateFrom date, dateTo date)
    return AvailableTripsTable
as
    result AvailableTripsTable;
begin
    if dateFrom > dateTo then raise_application_error(-2000, 'Wrong date given');
    end if;

    if dateFrom < sysdate then raise_application_error(-2000, 'Wrong date given');
    end if;

    select AvailableTripsO(trip_id, trip_name, country_name, tripDate, availablePlaces)
    bulk collect into result
    from AvailableTripsViewChanged
    where country_name = countryName and tripDate between dateFrom and dateTo;

    return result;
end;
commit;

--function to get how many places are available
create or replace function getAvailablePlaces(tripID int)
    return int
as
    result int;
begin
    select no_available_places into result from Trip where tripID=trip_id;

    return result;
end;
commit;






