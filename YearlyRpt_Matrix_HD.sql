CREATE TABLE [dbo].[YearlyRpt_Matrix_HD]
(
	[YRMH_Id] INT IDENTITY(1,1) PRIMARY KEY, 
    [YRMH_CreatedBy] VARCHAR(50) NULL, 
    [YR_DateSaved] DATETIME2 NULL, 
    [YRMH_CID] INT NULL, 
    [YRMH_Year] INT NULL, 
    [YRMH_DateSent] DATETIME2 NULL, 
    [YRMH_Sent] TINYINT NULL DEFAULT 0, 
    [YRMH_Modif] TINYINT NULL DEFAULT 0, 
    [YRMH_DateSentPrev] DATETIME2 NULL, 
    [YRMH_Final] TINYINT NULL DEFAULT 0, 
    [YRMH_Comments] TEXT NULL
)
