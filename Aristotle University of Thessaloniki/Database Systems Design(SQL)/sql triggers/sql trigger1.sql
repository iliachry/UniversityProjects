CREATE TRIGGER [dbo].[Low_Availability] ON [dbo].[Pharmacy_Drug]
 AFTER INSERT, UPDATE 
AS
	DECLARE @Amount int, @Pharmacy_Username varchar(20), @Drug_ID int;
	SELECT @Amount=Amount, @Pharmacy_Username = Pharmacy_Username, @Drug_ID = Drug_ID
	FROM inserted i

IF @Amount <5
	  BEGIN
	      UPDATE [dbo].[Pharmacy_Drug]
		  SET Amount = @Amount
		  WHERE Drug_ID=@Drug_ID AND Pharmacy_Username=@Pharmacy_Username
		  PRINT 'Warning: Low Availability of this Drug ,Amount < 5!' 
	  END
