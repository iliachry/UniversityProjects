SELECT DISTINCT name, surname
FROM Username U 
JOIN User_Hospital UH 
    ON U.username = UH.User_Username 
JOIN Hospital H
    ON UH.Hospital_ID = H.ID
WHERE title ='Ιπποκράτειο'
