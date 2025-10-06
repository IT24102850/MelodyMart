
CREATE PROCEDURE insertRecord(@showId int,@cName,varchar(50),@noOfTickets int)





as

begin

insert into Booking values(@showId,@cName,@noOfTickets)

update Show
declare @noOfSeats int
set spectators = spectators+noOfTickets
where @showId = @showId
from Theater t,show s
where t,theaterName = 

end



















BEGIN
  SET NOCOUNT ON;

  BEGIN TRAN;

  -- Insert booking
  INSERT INTO dbo.Booking (showId, custName, numTickets)
  VALUES (@showId, @custName, @numTickets);

  -- Update spectators in the Show table
  UPDATE s
    SET spectators = ISNULL(spectators, 0) + @numTickets
  FROM dbo.[Show] AS s
  WHERE s.showId = @showId;

  COMMIT TRAN;
END
GO



