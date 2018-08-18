CREATE VIEW User_View_UserName AS
SELECT *
FROM [dbo].[UserName]
WHERE username = SUSER_SNAME()