CREATE VIEW Doctor_SelfView_DoctorLocation AS
SELECT *
FROM [dbo].[DoctorLocation]
WHERE username = SUSER_SNAME()