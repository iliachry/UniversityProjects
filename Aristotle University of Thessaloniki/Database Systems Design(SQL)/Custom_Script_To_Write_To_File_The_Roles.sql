-- IF YOU GOT AN ERROR RUN THIS, ONLY ONCE AND ALONE
--sp_configure 'show advanced options', 1;	
--GO 
--RECONFIGURE; 
--GO 
--sp_configure 'Ole Automation Procedures', 1; 
--GO 
--RECONFIGURE; 
--GO 

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

declare @RoleName varchar(50) = 'Advisors'

declare @Script varchar(max) = 'CREATE ROLE ' + @RoleName + char(13)
select @script = @script + 'GRANT ' + prm.permission_name + ' ON ' + OBJECT_NAME(major_id) + ' TO ' + rol.name + char(13) COLLATE Latin1_General_CI_AS 
from sys.database_permissions prm
    join sys.database_principals rol on
        prm.grantee_principal_id = rol.principal_id
where rol.name = @RoleName

print @script




DECLARE @OLE            INT 
DECLARE @FileID         INT 
declare @File varchar(2000) = 'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\'+@RoleName+'Role.sql'

EXECUTE sp_OACreate 'Scripting.FileSystemObject', @OLE OUT 
       
EXECUTE sp_OAMethod @OLE, 'OpenTextFile', @FileID OUT, @File , 8, 1 
     
EXECUTE sp_OAMethod @FileID, 'WriteLine', Null, @script
 
EXECUTE sp_OADestroy @FileID 
EXECUTE sp_OADestroy @OLE 
