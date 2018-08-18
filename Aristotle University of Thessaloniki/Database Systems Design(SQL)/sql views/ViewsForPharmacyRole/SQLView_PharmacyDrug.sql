CREATE VIEW View_PharmacyDrug AS
SELECT D.title,PD.Amount,D.information,P.name,P.surname,PL.address,PL.city,PL.postcode,P.working_hours,P.phone
FROM  Pharmacy P
JOIN Pharmacy_Drug PD
    ON P.username = PD.Pharmacy_Username
JOIn Drug D
    ON D.ID=PD.Drug_ID
JOIN PharmacyLocation PL
    ON P.username = PL.username
