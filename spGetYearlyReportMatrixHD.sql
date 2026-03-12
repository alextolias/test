CREATE PROCEDURE [dbo].[spGetYearlyReportMatrixHD]
    @CId INT,
    @Year INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @MatrixId INT
    SELECT @MatrixId = YRMH_Id FROM YearlyRpt_Matrix_HD h WHERE h.YRMH_Year = @Year AND h.YRMH_CID = @CId

SELECT YRMH_Id
    ,YRMH_CreatedBy
    ,YRMH_DateSaved
    ,YRMH_CID
    ,YRMH_Year
    ,YRMH_DateSent
    ,YRMH_Sent
    ,YRMH_Modif
    ,YRMH_DateSentPrev
    ,YRMH_Final
    ,YRMH_Comments
    ,YRMH_WeightC
    ,YRMH_ContribC
    ,YRMH_ChkSymet1
    ,YRMH_ChkSymet2
    ,YRMH_ChkSymet3
    ,YRMH_SenderName
  FROM [dbo].[YearlyRpt_Matrix_HD]
    WHERE YRMH_Id = @MatrixId
END
GO