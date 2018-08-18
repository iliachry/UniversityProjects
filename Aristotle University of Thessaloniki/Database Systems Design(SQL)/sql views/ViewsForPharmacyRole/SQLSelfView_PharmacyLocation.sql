CREATE VIEW Pharmacy_SelfView_PharmacyLocation AS
SELECT *
FROM [dbo].[PharmacyLocation]
WHERE username = SUSER_SNAME()