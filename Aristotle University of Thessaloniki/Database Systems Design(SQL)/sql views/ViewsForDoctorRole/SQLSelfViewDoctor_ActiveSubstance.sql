CREATE VIEW Doctor_SelfView_Doctor_ActiveSubstance AS
SELECT *
FROM [dbo].[Doctor_ActiveSubstance]
WHERE Doctor_Username = SUSER_SNAME()