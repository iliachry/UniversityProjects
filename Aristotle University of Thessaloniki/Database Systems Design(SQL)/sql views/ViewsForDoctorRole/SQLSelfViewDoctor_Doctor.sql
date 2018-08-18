CREATE VIEW Doctor_SelfView_Doctor AS
SELECT *
FROM [dbo].[Doctor]
WHERE username = SUSER_SNAME()