CREATE TABLE dbo.YearlyRpt_Matrix_DT
(
    YRMD_Id  			INT IDENTITY(1,1) PRIMARY KEY,
    YRMH_Id        		INT NOT NULL,
    YRMD_MaterialId     VARCHAR(10) NOT NULL,
    YRMD_PairNo         TINYINT NOT NULL,   -- 1..6
    YRMD_WeightValue    DECIMAL(18,3) NULL,
    YRMD_QuantityValue  DECIMAL(18,3) NULL,

    CONSTRAINT FK_YearlyRpt_Matrix_DT_YRHD_Id
        FOREIGN KEY (YRMH_Id) REFERENCES dbo.YearlyRpt_Matrix_HD(YRMH_Id),

    --CONSTRAINT FK_YearlyRpt_Matrix_DT_Material
    --    FOREIGN KEY (YRMD_MaterialId) REFERENCES dbo.Packaging_Types(PT_ID),

    CONSTRAINT UQ_YearlyRpt_Matrix_DT UNIQUE (YRMH_Id, YRMD_MaterialId, YRMD_PairNo),

    CONSTRAINT CHK_YearlyRpt_Matrix_DT_PairNo CHECK (YRMD_PairNo BETWEEN 1 AND 6)
);