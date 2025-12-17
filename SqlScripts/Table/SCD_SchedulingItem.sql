
--<<FileName:SCD_SchedulingItem.sql>>--
--<< TABLE DEFINITION >>--

IF OBJECT_ID('SCD.SchedulingItem') IS NULL
CREATE TABLE [SCD].[SchedulingItem](
	[SchedulingItemId] [int] NOT NULL,
	[SchedulingRef] [int] NOT NULL,	
	[DateTime] [datetime] NOT NULL
) ON [PRIMARY]

GO
--<< ADD CLOLUMNS >>--

--<<Sample>>--
/*IF NOT EXISTS (SELECT 1 FROM SYS.COLUMNS WHERE OBJECT_ID = OBJECT_ID('SCD.SchedulingItem') AND
				[NAME] = 'COLUMNNAME')
BEGIN
    ALTER TABLE SCD.SchedulingItem ADD COLUMNNAME DATATYPE NULLABLE
END
GO*/

--<< ALTER COLUMNS >>--

--<< PRIMARYKEY DEFINITION >>--

If NOT EXISTS (SELECT 1 FROM sys.objects where name = 'PK_SchedulingItem')
ALTER TABLE [SCD].[SchedulingItem] ADD  CONSTRAINT [PK_SchedulingItem] PRIMARY KEY CLUSTERED 
(
	[SchedulingItemId] ASC
) ON [PRIMARY]
GO

--<< DEFAULTS CHECKS DEFINITION >>--

--<< RULES DEFINITION >>--

--<< INDEXES DEFINITION >>--

IF NOT EXISTS(SELECT 1 FROM SYS.Indexes WHERE name = 'UQ_SchedulingItem_DateTime')
BEGIN
	ALTER TABLE [SCD].[SchedulingItem] 
	ADD CONSTRAINT [UQ_SchedulingItem_DateTime] UNIQUE NONCLUSTERED
		(
			[SchedulingRef],
			[DateTime]
		)
END
GO

--<< FOREIGNKEYS DEFINITION >>--
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE Name = 'FK_SchedulingItem_SchedulingRef')
	BEGIN
		ALTER TABLE [SCD].[SchedulingItem] ADD CONSTRAINT [FK_SchedulingItem_SchedulingRef] FOREIGN KEY([SchedulingRef])
		REFERENCES [SCD].[Scheduling] ([SchedulingId])
		ON DELETE CASCADE
	END
GO

--<< DROP OBJECTS >>--