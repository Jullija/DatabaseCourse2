--trigger after adding reservation - 7a) --dodać procedurę
create or replace trigger AddReservationTrigger
    after insert on Reservation
    for each row
    begin
        insert into Log(reservation_id, log_date, status)
        values (:new.reservation_id, sysdate, :new.status);
    end;
commit;


--trigger after modifying reservation's status - 7b)
create or replace trigger ModifyReservationStatusTrigger
    after update of status on Reservation
    for each row
    begin
        if :new.status != :old.status then
            insert into Log(reservation_id, log_date, status)
            values (:new.reservation_id, sysdate, :new.status);
        end if;
    end;
commit;



--trigger before adding reservation
create or replace trigger BeforeAddingReservationTrigger
    before insert on Reservation
    for each row
    declare availablePlaces int;
    begin
        if not personExistence(:NEW.person_id) then
            raise_application_error(-20001, 'Person does not exist');
        end if;
        if not tripExistence(:new.trip_id) then
            raise_application_error(-20001, 'Trip does not exist');
        end if;
        if not isTheDateCorrect(:new.trip_id) then
            raise_application_error(-20001, 'The trip has already taken place');
        end if;

        availablePlaces := getLeftPlaces(:new.trip_id);

        if availablePlaces = 0 then
            raise_application_error(-20001, 'There are no spots for this trip');
        end if;
    end;
commit;



--trigger before changing reservation's status
create or replace trigger BeforeChangingReservationStatus
    before update of status on Reservation
    for each row
    declare
        pragma autonomous_transaction;
        availablePlaces int;
    begin
        availablePlaces := getLeftPlaces(:new.trip_id);

        case :new.status
        when :old.status then
        raise_application_error(-20001,'Reservation already has this status');

        when 'N' then
        null;

        when 'C' then
        null;

        when 'P' then
            if :old.status = 'C' then
                if availablePlaces = 0 then
                    raise_application_error(-20001, 'Not enough places available');
                end if;
            end if;

        else
        raise_application_error(-20001, 'Wrong status given');
    end case;
    end;
commit;





--STRUCTURE CHANGED
--trigger after adding reservation
create or replace trigger AddReservationTrigger
    after insert on Reservation
    for each row
    begin
        insert into Log(reservation_id, log_date, status)
        values (:new.reservation_id, sysdate, :new.status);

        update Trip set no_available_places = no_available_places - 1
        where trip_id = :new.trip_id;

    end;
commit;


create or replace trigger ModifyReservationStatusTrigger
    after update of status on Reservation
    for each row
    begin
        if :new.status != :old.status then
            insert into Log(reservation_id, log_date, status)
            values (:new.reservation_id, sysdate, :new.status);
        end if;

        if :new.status = 'C' then
            update Trip set no_available_places = no_available_places + 1
        where trip_id = :new.trip_id;
        end if;

    end;
commit;



--trigger before adding reservation
create or replace trigger BeforeAddingReservationTrigger
    before insert on Reservation
    for each row
    declare availablePlaces int;
    begin
        if not personExistence(:NEW.person_id) then
            raise_application_error(-20001, 'Person does not exist');
        end if;
        if not tripExistence(:new.trip_id) then
            raise_application_error(-20001, 'Trip does not exist');
        end if;
        if not isTheDateCorrect(:new.trip_id) then
            raise_application_error(-20001, 'The trip has already taken place');
        end if;

        availablePlaces := getAvailablePlaces(:new.trip_id);

        if availablePlaces = 0 then
            raise_application_error(-20001, 'There are no spots for this trip');
        end if;
    end;
commit;


--trigger before changing reservation's status
create or replace trigger BeforeChangingReservationStatusTrigger
    before update of status on Reservation
    for each row
    declare
        pragma autonomous_transaction;
        availablePlaces int;
    begin
        availablePlaces := getAvailablePlaces(:new.trip_id);

        case :new.status
        when :old.status then
        raise_application_error(-20001,'Reservation already has this status');

        when 'N' then
        null;

        when 'C' then
        null;

        when 'P' then
            if :old.status = 'C' then
                if availablePlaces = 0 then
                    raise_application_error(-20001, 'Not enough places available');
                end if;
            end if;

        else
        raise_application_error(-20001, 'Wrong status given');
    end case;
    end;
commit;



--trigger before changing max_places
create or replace trigger BeforeChangingMaxPlacesTrigger
    before update of max_no_places on Trip
    for each row
    declare
        pragma autonomous_transaction;
        availablePlaces int;
    begin
        availablePlaces := getAvailablePlaces(:new.trip_id);

        if not tripExistence(:new.trip_id) then
            raise_application_error(-20001, 'Trip with this id does not exist');
        end if;

        if :new.max_no_places <= 0 then
            raise_application_error(-20001, 'Wrong number of mx places given');
        end if;

        if :old.max_no_places - availablePlaces > :new.max_no_places then
            raise_application_error(-20001, 'The amount of booked places is greater than new max_no_places value.');
        end if;


    end;
commit;