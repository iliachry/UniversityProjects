
SELECT username, name,surname,working_hours,phone,title
FROM Drug D 
JOIN Pharmacy_Drug PD
    ON D.ID = PD.Drug_ID
JOIN Pharmacy P 
    ON PD.Pharmacy_Username = P.username
WHERE title = 'Otrivin'
UNION
SELECT username, name,surname,working_hours,phone,title
FROM Drug D 
JOIN Pharmacy_Drug PD 
    ON D.ID = PD.Drug_ID 
JOIN Pharmacy P	
	ON PD.Pharmacy_Username = P.username
WHERE title = 'Dexa-Rhinaspray'
