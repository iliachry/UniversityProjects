CREATE VIEW User_View_User_Drug AS
SELECT UD.User_Username,D.title,UD.start_day,UD.end_day,D.information
FROM User_Drug UD
JOIN Drug D
    ON D.ID = UD.Drug_ID
WHERE User_Username = SUSER_SNAME()