
CREATE TRIGGER check_dateofDisease ON [dbo].[User_Disease]
  AFTER INSERT, UPDATE 
  
  AS
	DECLARE @start_day date
	SELECT @start_day=start_day
	FROM inserted i
  
  IF( @start_day < ('1900-01-01') OR @start_day >)
 BEGIN
    RAISERROR ('Start_date must be later than Jan 1, 1900' , 16,1);
	RETURN

END;