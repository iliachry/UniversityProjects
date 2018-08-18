CREATE VIEW Doctor_View_Patients_Hospital AS
SELECT UN.name, UN.surname, U.IID, H.title AS Hospital, UH.date
FROM [dbo].[User] U
JOIN [dbo].[User_Hospital] UH
     ON U.username = UH.User_Username
JOIN [dbo].[Hospital] H
     ON H.ID = UH.Hospital_ID
JOIN [dbo].[UserName] UN
     ON UN.username = U.username
JOIN [dbo].[User_Doctor] UDOC
     ON U.username = UDOC.User_Username
WHERE UDOC.Doctor_Username = SUSER_NAME()
