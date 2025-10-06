create procedure insertRecord
    (@showID int, @cName varchar(50), @noOfTickets int)
as
begin
    declare @seats int

    -- call procedure to get remaining seats
    exec @seats = DisplayRemainingSeats @showID

    if(@seats >= @noOfTickets)
    begin
        insert into Booking
        values(@showID, @cName, @noOfTickets)

        update Show
        set spectators = spectators + @noOfTickets
        where showId = @showID
    end
end

select * from Booking
select * from Show

exec insertRecord 2,'jhon',10

exec insertRecord 3, 'Martin',20




create trigger checkTheaterSeats
on Booking
for insert
as
begin
    declare @showID int, @theaterCapacity int, @spectators int, @newTickets int;

    -- get values from the inserted row
    select 
        @showID = i.showId,
        @newTickets = i.numTickets
    from inserted i;

    -- get current spectators and capacity
    select 
        @spectators = s.spectators,
        @theaterCapacity = t.capacity
    from Show s
    join Theater t on s.theaterName = t.theaterName
    where s.showId = @showID;

    -- if new booking would exceed capacity, cancel
    if (@spectators + @newTickets > @theaterCapacity)
    begin
        rollback transaction;
        raiserror('Booking exceeds theater capacity!', 16, 1);
    end
end

