SELECT information
FROM Drug D
WHERE D.ID= (
SELECT Drug_ID
FROM User_Drug
WHERE User_Drug.User_Username = (SELECT Us.username
                                 FROM [dbo].[User] Us
                                 JOIN UserName UN
                                      ON Us.username = UN.username 
                                 WHERE name = 'Ανδρέας' AND surname = 'Ανδρέου') 
AND start_day>= ('2016-11-01') AND start_day<= ('2016-11-30'))
		