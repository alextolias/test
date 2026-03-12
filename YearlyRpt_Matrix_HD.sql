CREATE TABLE [dbo].[YearlyRpt_Matrix_HD]
(
	[YRMH_Id] INT IDENTITY(1,1) PRIMARY KEY, 
    [YRMH_CreatedBy] VARCHAR(50) NULL, 
    [YRMH_DateSaved] DATETIME2 NULL, 
    [YRMH_CID] INT NULL, 
    [YRMH_Year] INT NULL, 
    [YRMH_DateSent] DATETIME2 NULL, 
    [YRMH_Sent] TINYINT NULL DEFAULT 0, 
    [YRMH_Modif] TINYINT NULL DEFAULT 0, 
    [YRMH_DateSentPrev] DATETIME2 NULL, 
    [YRMH_Final] TINYINT NULL DEFAULT 0, 
    [YRMH_Comments] TEXT NULL,
	[YRMH_WeightC] [decimal](15, 2) NULL,
	[YRMH_ContribC] [decimal](15, 2) NULL,
	[YRMH_ChkSymet1] [tinyint] NULL,
	[YRMH_ChkSymet2] [tinyint] NULL,
	[YRMH_ChkSymet3] [tinyint] NULL,
	[YRMH_SenderName] [varchar](255) NULL
)

GO

CREATE INDEX [IX_YearlyRpt_Matrix_HD_Unique] ON [dbo].[YearlyRpt_Matrix_HD] ([YRMH_CID], [YRMH_Year])
