CREATE VIEW Doctor_View_Doctor AS
SELECT D.name,D.surname,D.specialty,DL.address,DL.city,DL.postcode,D.phone
FROM [dbo].[Doctor] D
JOIN [dbo].[DoctorLocation] DL
ON D.username=DL.username