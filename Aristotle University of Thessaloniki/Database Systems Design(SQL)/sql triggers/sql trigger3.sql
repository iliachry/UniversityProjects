CREATE TRIGGER check_startdayOfDrug ON [dbo].[User_Drug]
  AFTER INSERT, UPDATE 
  
  AS
	DECLARE @start_day date
	SELECT @start_day=start_day
	FROM inserted i
  
  IF( @start_day < ('1900-01-01') )
 BEGIN
    RAISERROR ('Start_date must be later than Jan 1, 1900' , 16,1);
	RETURN

END;