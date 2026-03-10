CREATE PROCEDURE [dbo].[spInsertYearlyReportMatrix]
(
    @CreatedBy      NVARCHAR(100),
    @CId            INT,
    @Year           INT,
    @Comments       Text,
    @Details        dbo.YRMatrixDetailType READONLY
)
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRAN;

    DECLARE @MatrixId INT;

    INSERT INTO dbo.YearlyRpt_Matrix_HD (YRMH_CreatedBy, YRMH_CID, YRMH_Year, YRMH_Comments, YR_DateSaved)
    VALUES (@CreatedBy, @CId, @Year, @Comments, GETDATE());

    SET @MatrixId = SCOPE_IDENTITY();

    INSERT INTO dbo.YearlyRpt_Matrix_DT
    (
        YRMH_Id,
        YRMD_MaterialId,
        YRMD_PairNo,
        YRMD_WeightValue,
        YRMD_QuantityValue
    )
    SELECT
        @MatrixId,
        p.PT_ID,
        d.PairNo,
        d.WeightValue,
        d.QuantityValue
    FROM @Details d
    INNER JOIN dbo.Packaging_Types p
        ON (p.PT_ID = d.MaterialCode
        AND p.PT_YearValid = @Year);

    COMMIT TRAN;

    SELECT @MatrixId AS MatrixId;
END
GO