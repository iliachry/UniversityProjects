SELECT name, surname
FROM DoctorLocation DL JOIN Doctor D
ON  D.username = DL.username
WHERE city = 'Τρίκαλα'

