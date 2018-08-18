CREATE VIEW Pharmacy_SelfView_PharmacyDrug AS
SELECT PD.Pharmacy_Username, D.title, PD.Amount, D.information
FROM  [dbo].[Pharmacy_Drug] PD
JOIN [dbo].[Drug] D
    ON D.ID = PD.Drug_ID
WHERE Pharmacy_Username = SUSER_SNAME()