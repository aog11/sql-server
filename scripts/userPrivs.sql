-- Creating a user
CREATE USER prueba
WITH PASSWORD = 'Prueba01*';

-- Creating a login
CREATE USER dbadmin
WITH PASSWORD = 'Prueba01*';

-- Assigning SYSADMIN privs to the login
ALTER SERVER ROLE sysadmin
ADD MEMBER dbadmin;

--Changing the password of a user
ALTER USER dbadmin
WITH PASSWORD = 'Prueba02*';

--Changing the password of a login
ALTER LOGIN dbadmin
WITH PASSWORD = 'Prueba02*';

--Assign a login to a user
ALTER USER dbadmin
WITH LOGIN dbadmin;
--Alternate way
EXEC sp_change_users_login 'Update_One', 'dbadmin', 'dbadmin';  
GO