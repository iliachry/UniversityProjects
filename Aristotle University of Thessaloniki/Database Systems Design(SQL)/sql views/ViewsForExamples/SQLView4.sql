CREATE VIEW UrologistThessaloniki_View AS
SELECT phone
FROM Doctor D JOIN DoctorLocation DL
ON D.username = DL.username
WHERE specialty = 'Ουρολόγος' AND city = 'Θεσσαλονίκη'
