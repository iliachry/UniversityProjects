CREATE VIEW Doctor_View_ActiveSubstanceOfDoctors AS
SELECT D.name,D.surname,D.specialty,A.title AS ActiveSubstance, DR.title AS drug_name ,DA.date
FROM [dbo].[Doctor] D
JOIN [dbo].[Doctor_ActiveSubstance] DA
ON D.username=DA.Doctor_Username
JOIN [dbo].[Drug_ActiveSubstance] DRAC
ON DRAC.ActiveSubstance_ID=DA.ActiveSubstance_ID
JOIN [dbo].[Drug] DR
ON DR.ID=DRAC.Drug_ID
JOIN [dbo].[Active Substance] A
ON A.ID=DA.ActiveSubstance_ID