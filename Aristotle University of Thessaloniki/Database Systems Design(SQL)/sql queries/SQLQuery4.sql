SELECT * 
FROM Pharmacy 
WHERE working_hours LIKE '%10:00 - 18:00%'
INTERSECT 
SELECT username, password, name, surname, working_hours, phone 
FROM Pharmacy P JOIN Pharmacy_Drug PD
ON P.username = PD.Pharmacy_Username
JOIN Drug D
ON D.ID = PD.Drug_ID
WHERE title = 'Otrivin'



