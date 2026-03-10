CREATE PROCEDURE [dbo].[spGetYearlyReportMatrixHD]
    @CId INT,
    @Year INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @MatrixId INT
    SELECT @MatrixId = YRMH_Id FROM YearlyRpt_Matrix_HD h WHERE h.YRMH_Year = @Year AND h.YRMH_CID = @CId

SELECT [YRMH_Id]
      ,[YRMH_CreatedBy]
      ,[YR_DateSaved]
      ,[YRMH_CID]
      ,[YRMH_Year]
      ,[YRMH_DateSent]
      ,[YRMH_Sent]
      ,[YRMH_Modif]
      ,[YRMH_DateSentPrev]
      ,[YRMH_Final]
      ,[YRMH_Comments]
  FROM [dbo].[YearlyRpt_Matrix_HD]
    WHERE YRMH_Id = @MatrixId
END
GO