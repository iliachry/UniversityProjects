CREATE VIEW User_View_User_Hospital AS
SELECT UH.User_Username,H.title,H.phone,UH.date
FROM User_Hospital UH
JOIN Hospital H  
    ON H.ID = UH.Hospital_ID
WHERE User_Username = SUSER_SNAME()