use MelodyMart

ALTER LOGIN [sa] ENABLE;

SELECT name, is_disabled 
FROM sys.server_principals 
WHERE name = 'sa';


ALTER LOGIN sa WITH PASSWORD = '1234';
