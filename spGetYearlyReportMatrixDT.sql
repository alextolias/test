CREATE PROCEDURE [dbo].[spGetYearlyReportMatrixDT]
(
    @CId INT,
    @Year INT
)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @MatrixId INT

    SELECT @MatrixId = YRMH_Id FROM YearlyRpt_Matrix_HD h WHERE h.YRMH_Year = @Year AND h.YRMH_CID = @CId

    SELECT
        h.YRMH_Id,
        h.YRMH_CreatedBy,
        h.YRMH_Comments,
        d.YRMD_MaterialId,
        p.PT_ID,
        d.YRMD_PairNo,
        d.YRMD_WeightValue,
        d.YRMD_QuantityValue
    FROM dbo.YearlyRpt_Matrix_HD h
    INNER JOIN dbo.YearlyRpt_Matrix_DT d
        ON h.YRMH_Id = d.YRMH_Id
    INNER JOIN dbo.Packaging_Types p
        ON (d.YRMD_MaterialId = p.PT_ID AND p.PT_YearValid = @Year)
    WHERE h.YRMH_Id = @MatrixId
    ORDER BY p.PT_DisplayOrder, d.YRMD_PairNo;
END
GO
