SELECT D.name, D.surname, specialty
FROM UserName U JOIN Doctor D
ON U.username = D.username
