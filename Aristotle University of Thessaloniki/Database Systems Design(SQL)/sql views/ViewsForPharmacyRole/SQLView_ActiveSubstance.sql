CREATE VIEW View_ActiveSubstance AS
SELECT ACS.title,D.information,D.title AS DrugTitle /*That's because the view would have two cols with the same name*/
FROM [Active Substance] ACS
 JOIN Drug_ActiveSubstance DA
    ON DA.ActiveSubstance_ID = ACS.ID
JOIN Drug D
    ON D.ID = DA.Drug_ID