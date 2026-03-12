CREATE PROCEDURE [dbo].[spInsertYearlyReportMatrix]
(
    @CId            INT,
    @Year           INT,
    @Header         dbo.YRMatrixHeaderType READONLY,
    @Details        dbo.YRMatrixDetailType READONLY
)
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRAN;

    DECLARE @MatrixId INT;


    INSERT INTO dbo.YearlyRpt_Matrix_HD
        (YRMH_CreatedBy
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
        ,YRMH_SenderName)
    SELECT CreatedBy    
        ,DateSaved   
        ,@CId         
        ,@Year 
        ,DateSent    
        ,IsSent      
        ,IsModif     
        ,DateSentPrev
        ,IsFinal     
        ,Comments    
        ,WeightC
        ,ContribC
        ,ChkSymet1   
        ,ChkSymet2   
        ,ChkSymet3   
        ,SenderName 
        FROM @Header

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