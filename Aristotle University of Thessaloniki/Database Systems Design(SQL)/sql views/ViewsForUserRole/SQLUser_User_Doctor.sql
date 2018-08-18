CREATE VIEW User_View_User_Doctor AS
SELECT UD.User_Username, D.name,D.surname,D.specialty,D.phone,UD.date
FROM [dbo].[User_Doctor] UD
JOIN [dbo].[Doctor] D
    ON UD.Doctor_Username=D.username
WHERE User_Username = SUSER_SNAME()