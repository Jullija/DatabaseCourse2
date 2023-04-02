-- addReservation procedure - 5a)
create or replace procedure AddReservation(tripID int, personID int)
as
    availablePlaces int;
begin
    if not personExistence(personID) then
        raise_application_error(-20001, 'Person does not exist');
    end if;
    if not tripExistence(tripID) then
        raise_application_error(-20001, 'Trip does not exist');
    end if;
    if not isTheDateCorrect(tripID) then
        raise_application_error(-20001, 'The trip has already taken place');
    end if;


    availablePlaces := getLeftPlaces(tripID);

    if availablePlaces <= 0 then
        raise_application_error(-20001, 'There are no spots for this trip');
    end if;



    insert into Reservation(trip_id, person_id, status)
    values (tripID, personID, 'N');
end;
commit;



-- ModifyReservationStatus procedure - 5b)
create or replace procedure ModifyReservationStatus(reservationID int, newStatus char)
as
    availablePlaces int;
    tripID int;
    currStatus char;
begin

    select trip_id, status into tripID, currStatus from Reservation
    where reservationID=reservation_id;

    availablePlaces := getLeftPlaces(tripID);

    if not reservationExistence(reservationID) then
        raise_application_error(-20001, 'Reservation does not exist');
    end if;
    if not tripExistence(tripID) then
        raise_application_error(-20001, 'Trip does not exist');
    end if;


    case newStatus
        when currStatus then
        raise_application_error(-20001,'Reservation already has this status');

        when 'N' then
        null;

        when 'C' then
        update Trip set MAX_NO_PLACES = MAX_NO_PLACES + 1 where TRIP_ID = tripID;

        when 'P' then
            if currStatus = 'C' then
                if availablePlaces <= 0 then
                    raise_application_error(-20001, 'Not enough places available');
                end if;
            end if;

        else
        raise_application_error(-20001, 'Wrong status given');
    end case;


    update Reservation set status=newStatus where reservation_id=reservationID;

end;
commit;

--ModifyNoPlaces procedure - 5c)
create or replace procedure ModifyNoPlaces(tripID int, noPlaces int)
as
    currPlaces int;
    availablePlaces int;
begin
    select max_no_places into currPlaces from Trip where tripID = trip_id;
    availablePlaces := getLeftPlaces(tripID);

    if not tripExistence(tripID) then
        raise_application_error(-20001, 'Trip with this id does not exist');
    end if;

    if currPlaces - availablePlaces > noPlaces then
        raise_application_error(-20001, 'The amount of booked places is greater than new max_no_places value.');
    end if;


    update Trip set max_no_places = noPlaces where tripID = trip_id;
end;
commit;


--LOG TABLE ADDED - PROCEDURE MODIFICATION
create or replace procedure ModifyReservationStatusMod6(reservationID int, newStatus char)
as
    availablePlaces int;
    tripID int;
    currStatus char;
begin

    select trip_id, status into tripID, currStatus from Reservation
    where reservationID=reservation_id;

    availablePlaces := getLeftPlaces(tripID);

    if not reservationExistence(reservationID) then
        raise_application_error(-20001, 'Reservation does not exist');
    end if;
    if not tripExistence(tripID) then
        raise_application_error(-20001, 'Trip does not exist');
    end if;


    case newStatus
        when currStatus then
        raise_application_error(-20001,'Reservation already has this status');

        when 'N' then
        null;

        when 'C' then
        null;

        when 'P' then
            if currStatus = 'C' then
                if availablePlaces <= 0 then
                    raise_application_error(-20001, 'Not enough places available');
                end if;
            end if;

        else
        raise_application_error(-20001, 'Wrong status given');
    end case;


    update Reservation set status=newStatus where reservation_id=reservationID;

    insert into Log(reservation_id, log_date, status) values
    (reservationID, sysdate, newStatus);

end;
commit;


create or replace procedure AddReservationMod6(tripID int, personID int)
as
    availablePlaces int;
    reservationID int;
begin
    if not personExistence(personID) then
        raise_application_error(-20001, 'Person does not exist');
    end if;
    if not tripExistence(tripID) then
        raise_application_error(-20001, 'Trip does not exist');
    end if;
    if not isTheDateCorrect(tripID) then
        raise_application_error(-20001, 'The trip has already taken place');
    end if;


    availablePlaces := getLeftPlaces(tripID);

    if availablePlaces <= 0 then
        raise_application_error(-20001, 'There are no spots for this trip');
    end if;



    insert into Reservation(trip_id, person_id, status)
    values (tripID, personID, 'N');

    select reservation_id into reservationID from Reservation where trip_id = tripID
    and personID = person_id and status = 'N';

    insert into Log(reservation_id, log_date, status) values
    (reservationID, sysdate, 'N');
end;
commit;

create or replace procedure ModifyNoPlaces(tripID int, noPlaces int)
as
    currPlaces int;
    availablePlaces int;
begin
    select max_no_places into currPlaces from Trip where tripID = trip_id;
    availablePlaces := getLeftPlaces(tripID);

    if not tripExistence(tripID) then
        raise_application_error(-20001, 'Trip with this id does not exist');
    end if;

    if currPlaces - availablePlaces > noPlaces then
        raise_application_error(-20001, 'The amount of booked places is greater than new max_no_places value.');
    end if;


    update Trip set max_no_places = noPlaces where tripID = trip_id;
end;
commit;





--MODIFICATION AFTER TRIGGERS ADDED
create or replace procedure AddReservationAfterTriggerMod(tripID int, personID int)
as
begin
    insert into Reservation(trip_id, person_id, status)
    values (tripID, personID, 'N');
end;
commit;



create or replace procedure ModifyReservationStatusAfterTriggerMod(reservationID int, newStatus char)
as
begin

    if not reservationExistence(reservationID) then
        raise_application_error(-20001, 'Reservation does not exist');
    end if;

    update Reservation set status=newStatus where reservation_id=reservationID;

end;
commit;







-- begin
--     AddReservationAfterTriggerMod(3, 1);
-- end;
-- commit;
--
-- begin
--     ModifyReservationStatusAfterTriggerMod(47, 'P');
-- end;
-- commit;




--STRUCTURE CHANGED
--procedure to count available_places
create or replace procedure countAvailablePlaces(tripID int)
as
    result int;
begin
    select max_no_places - getBookedPlaces(tripID) into result from Trip where tripID = trip_id;

    update Trip set no_available_places = result where trip_id=tripID;

end;
commit;




-- addReservation procedure
create or replace procedure AddReservationChanged(tripID int, personID int)
as
begin

    insert into Reservation(trip_id, person_id, status)
    values (tripID, personID, 'N');

--     update Trip set no_available_places = getAvailablePlaces(tripID)- 1
--     where trip_id = tripID;
end;
commit;


--ModifyNoPlaces procedure
create or replace procedure ModifyNoPlacesChanged(tripID int, noPlaces int)
as
begin
    update Trip set max_no_places = noPlaces where tripID = trip_id;
    begin
        countAvailablePlaces(tripID);
    end;
end;

commit;


create or replace procedure ModifyReservationStatusChanged(reservationID int, newStatus char)
as
begin

    if not reservationExistence(reservationID) then
        raise_application_error(-20001, 'Reservation does not exist');
    end if;

    update Reservation set status=newStatus where reservation_id=reservationID;

end;
commit;




begin
    AddReservationAfterTriggerMod(2, 7);
end;
commit;

select * from AVAILABLETRIPS;
--
begin
    ModifyNoPlacesChanged(2, 1);
end;
commit;
--
begin
    ModifyReservationStatusChanged(142, 'P');
end;
commit;


