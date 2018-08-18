CREATE VIEW View_PharmacyLocation AS
SELECT P.name,P.surname,PL.address,PL.city,PL.postcode,P.working_hours,P.phone
FROM  Pharmacy P
JOIN PharmacyLocation PL
    ON P.username = PL.username