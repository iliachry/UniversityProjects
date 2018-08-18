CREATE VIEW View_HospitalLocation AS
SELECT H.title,HL.address,HL.city,HL.postcode,H.phone
FROM  Hospital H
JOIN HospitalLocation HL
    ON H.ID = HL.ID