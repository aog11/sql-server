-- Creating a user
CREATE USER prueba
WITH PASSWORD = 'Prueba01*';

-- Creating a login
CREATE USER dbadmin
WITH PASSWORD = 'Prueba01*';

-- Assigning SYSADMIN privs to the login
ALTER SERVER ROLE sysadmin
ADD MEMBER dbadmin;