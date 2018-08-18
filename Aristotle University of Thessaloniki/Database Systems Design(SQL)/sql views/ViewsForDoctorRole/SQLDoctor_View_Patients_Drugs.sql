CREATE VIEW Doctor_View_Patients_Drug AS
SELECT UN.name, UN.surname, U.IID, D.title, UDR.start_day, UDR.end_day
FROM [dbo].[User] U
JOIN [dbo].[User_Drug] UDR
     ON U.username = UDR.User_Username
JOIN [dbo].[Drug] D
     ON D.ID = UDR.Drug_ID
JOIN [dbo].[UserName] UN
     ON UN.username = U.username
JOIN [dbo].[User_Doctor] UDOC
     ON U.username = UDOC.User_Username
WHERE UDOC.Doctor_Username = SUSER_NAME()
