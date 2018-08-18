CREATE VIEW View_DoctorLocation AS
SELECT D.name,D.surname,D.specialty,DL.address,DL.city,DL.postcode,D.phone
FROM  Doctor D
JOIN DoctorLocation DL
    ON D.username=DL.username
