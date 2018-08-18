CREATE VIEW Doctor_View_Patients_Disease AS
SELECT UN.name, UN.surname, U.IID, D.title, UD.start_day, UD.end_day
FROM [dbo].[User] U
JOIN [dbo].[User_Disease] UD
     ON U.username=UD.User_Username
JOIN [dbo].[Disease] D
     ON D.ID = UD.Disease_ID
JOIN [dbo].[UserName] UN
     ON UN.username = U.username
JOIN [dbo].[User_Doctor] UDOC
     ON U.username = UDOC.User_Username
WHERE UDOC.Doctor_Username = SUSER_NAME()
