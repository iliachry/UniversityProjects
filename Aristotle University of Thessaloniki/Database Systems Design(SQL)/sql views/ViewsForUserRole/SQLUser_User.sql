CREATE VIEW User_View_User AS
SELECT *
FROM [dbo].[User]
WHERE username = SUSER_SNAME()
