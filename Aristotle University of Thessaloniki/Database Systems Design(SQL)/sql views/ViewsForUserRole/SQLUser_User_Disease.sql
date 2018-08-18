CREATE VIEW User_View_User_Disease AS
SELECT UD.User_Username,UD.start_day,UD.end_day,D.title
FROM [dbo].[User_Disease] UD
JOIN [dbo].[Disease] D
     ON D.ID = UD.Disease_ID
WHERE UD.User_Username = SUSER_SNAME()