CREATE VIEW Pharmacy_SelfView_Pharmacy AS
SELECT *
FROM [dbo].[Pharmacy]
WHERE username = SUSER_SNAME()