USE msdb ;
GO

EXEC sp_add_schedule
    @schedule_name = N'Weekly-Ola' ,
    @freq_type = 8,
    @freq_interval = 64,
    @active_start_time = 000000,
	 @freq_recurrence_factor = 1 ;
GO


EXEC sp_attach_schedule
   @job_name = N'CommandLog Cleanup',
   @schedule_name = N'Weekly-Ola' ;
GO


EXEC sp_attach_schedule
   @job_name = N'Output File Cleanup',
   @schedule_name = N'Weekly-Ola' ;
GO

EXEC sp_attach_schedule
   @job_name = N'sp_delete_backuphistory',
   @schedule_name = N'Weekly-Ola' ;
GO

EXEC sp_attach_schedule
   @job_name = N'sp_purge_jobhistory',
   @schedule_name = N'Weekly-Ola' ;
GO

EXEC sp_add_schedule
    @schedule_name = N'Weekly-Ola_Integrity' ,
    @freq_type = 8,
    @freq_interval = 64,
    @active_start_time = 191500,
	 @freq_recurrence_factor = 1 ;
GO

EXEC sp_attach_schedule
   @job_name = N'DatabaseIntegrityCheck - SYSTEM_DATABASES',
   @schedule_name = N'Weekly-Ola_Integrity' ;
GO

EXEC sp_attach_schedule
   @job_name = N'DatabaseIntegrityCheck - USER_DATABASES',
   @schedule_name = N'Weekly-Ola_Integrity' ;
GO

EXEC sp_add_schedule
    @schedule_name = N'Weekly-Ola_Optimize' ,
    @freq_type = 8,
    @freq_interval = 1,
    @active_start_time = 041500,
	 @freq_recurrence_factor = 1 ;
GO

EXEC sp_attach_schedule
   @job_name = N'IndexOptimize - SYSTEM_DATABASES',
   @schedule_name = N'Weekly-Ola_Optimize' ;
GO

EXEC sp_attach_schedule
   @job_name = N'IndexOptimize - USER_DATABASES',
   @schedule_name = N'Weekly-Ola_Optimize' ;
GO

EXEC sp_add_schedule
    @schedule_name = N'Weekly-Ola_Backup' ,
    @freq_type = 8,
    @freq_interval = 1,
    @active_start_time = 191500,
	 @freq_recurrence_factor = 1 ;
GO


EXEC sp_add_schedule
    @schedule_name = N'Hourly-Ola_Backup',
    @freq_type = 4,
    @freq_interval = 1,
	@freq_subday_type = 8,
	@freq_subday_interval=1, 
     @active_start_time=001500, 
	 @active_end_time=231400,
	 @freq_recurrence_factor = 1;
GO

--2019-06-21 - jpoad - Adding new Every5Minutes schedule for Log backups
EXEC sp_add_schedule 
	@schedule_name=N'Every5Minutes', 
	@freq_type=4, 
	@freq_interval=1, 
	@freq_subday_type=4, 
	@freq_subday_interval=5, 
	@freq_relative_interval=0, 
	@freq_recurrence_factor=1, 
	@active_start_time=0, 
	@active_end_time=235959
GO

EXEC sp_attach_schedule
   @job_name = N'DatabaseBackup - USER_DATABASES - LOG',
   --@schedule_name = N'Hourly-Ola_Backup' ;
   @schedule_name = N'Every5Minutes' ;
GO

EXEC sp_attach_schedule
   @job_name = N'DatabaseBackup - SYSTEM_DATABASES - LOG',
   @schedule_name = N'Weekly-Ola' ;
GO

/*
EXEC sp_attach_schedule
   @job_name = N'DatabaseBackup - ALL_DATABASES - LOG',
   @schedule_name = N'Hourly-Ola_Backup' ;
GO
*/


EXEC sp_add_schedule
    @schedule_name = N'Nightly-Ola_Backup',
    @freq_type = 8,
    @freq_interval = 126,
	@freq_subday_type=1, 
	@freq_subday_interval=0, 
	@freq_relative_interval=0, 
    @active_start_time = 231500,
	@freq_recurrence_factor = 1 ;
GO

EXEC sp_attach_schedule
   @job_name = N'DatabaseBackup - SYSTEM_DATABASES - FULL',
   @schedule_name = N'Nightly-Ola_Backup' ;
GO

EXEC sp_attach_schedule
   @job_name = N'DatabaseBackup - USER_DATABASES - FULL',
   @schedule_name = N'Nightly-Ola_Backup' ;
GO

/*
EXEC sp_attach_schedule
   @job_name = N'DatabaseBackup - USER_DATABASES - DIFF',
   @schedule_name = N'Nightly-Ola_Backup' ;
GO
*/