CREATE VIEW User_View_User_Pharmacy AS
SELECT UP.User_Username,UP.date, P.name,P.surname,PL.address,PL.city,PL.postcode,P.working_hours,P.phone
FROM User_Pharmacy UP
JOIN  Pharmacy P
    ON P.username = UP.Pharmacy_Username
JOIN PharmacyLocation PL
    ON PL.username = UP.Pharmacy_Username
WHERE User_Username = SUSER_SNAME()