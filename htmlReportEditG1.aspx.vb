Imports System.Data
Imports System.Data.SqlClient
Imports System.Drawing.Drawing2D
Partial Class htmlReportEditG1
    Inherits clsPageEvents

    Private myPageEvents As New clsPageEvents
    Private myReport As New clsReport(myDB)

    Private dtReport As New DataTable
    Private dsReport As New DataSet
    Private dsContribution As New DataSet
    Private dsTable_B As New DataSet
    Private dsCData As New DataSet
    Private bRetrieve As Boolean
    Private ReadOnly iCounter As Integer
    Private fSum_TableA As Double = 0
    Private fSum_TableB As Double = 0
    Private fSum_Table_AB As Double = 0


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try

            'If Not Me.Page.User.Identity.IsAuthenticated Then
            '    FormsAuthentication.RedirectToLoginPage()
            'End If

            lblError.Text = ""

            If Not Page.IsPostBack Then
                'sbLoadYears()
                txtYear.Text = Year(Now()) - 1
                '***************************************************************************
                'COMPANY DATA
                '***************************************************************************
                sbLoadCompanyData()
                sbLoadTableA_Contribution()
                sbClearFrm()

                If Not (Request.QueryString("year") Is Nothing) Then
                    If Request.QueryString("year").ToString.Trim() <> String.Empty Then
                        txtYear.Text = Request.QueryString("year").ToString.Trim()
                    End If
                    sbRetrieve_Data()
                    lblError.Text = String.Empty
                End If
            End If
            hlSend.NavigateUrl = "~/reportPDF.aspx?historical=v2024&Cid=" & lblCompanyID.Text & "&Year=" & txtYear.Text
        Catch ex As Exception

        End Try
    End Sub
#Region "<LOCAL FUNCTIONS>"
    Private Sub PerformReportCalculations(Optional bRetrieve As Boolean = False)
        Try

            'sbEraseWrongDecimSep()
            'Dim sValidRes As String = sbValidateInput(True)
            Dim bValidRes As Boolean = ValidateMatrixInputs
            'If sValidRes.Trim <> String.Empty Then
            '    myPageEvents.sbDisplaySimpleMessageBox(sValidRes)
            '    Exit Sub
            'End If
            'sbFormatDecimals()

            '' Perform calcs
            sbTableA_Calculations()
            'sbTableBCalculations()
            sbLoadTableC()

            'lblError.Text = ""
            ''btnSend.Enabled = False

        Catch ex As Exception
            lblError.Text = "Error on PerformReportCalculations - " & ex.Message
        End Try
    End Sub
    Private Sub sbLoadCompanyData()
        Try
            'REPORT DATA - QUANTITIES
            bRetrieve = myReport.fnGetHTMLReport_CompanyData(Session(sSession_CompanyID))
            If Not bRetrieve Then
                lblError.Text = myReport.GetDBError & " " & myReport.GetExecutionError
                Exit Sub
            End If
            'get the value
            dsCData = myReport.GetHTML_CompanyData
            lblCompanyName.Text = dsCData.Tables(0).Rows(0).Item("C_Name").ToString
            lblCompanyID.Text = Session(sSession_CompanyID)
            lblKodikosSimvasi.Text = dsCData.Tables(0).Rows(0).Item("C_ContractID").ToString
            lblAdrress.Text = dsCData.Tables(0).Rows(0).Item("C_Address").ToString
            lblTel.Text = dsCData.Tables(0).Rows(0).Item("C_Phone").ToString
            lblFax.Text = dsCData.Tables(0).Rows(0).Item("C_Fax").ToString
            lblEmail.Text = dsCData.Tables(0).Rows(0).Item("C_Email").ToString
            lblAFM.Text = dsCData.Tables(0).Rows(0).Item("C_TaxID").ToString
            lblDOY.Text = dsCData.Tables(0).Rows(0).Item("C_TaxName").ToString
            lblEtos.Text = txtYear.Text
            lblCDate.Text = FormatDateTime(Date.Today, DateFormat.ShortDate)
            lblYpeuthinos.Text = dsCData.Tables(0).Rows(0).Item("C_ContPerson").ToString
            'lblYpeuthinosEnd.Text = dsCData.Tables(0).Rows(0).Item("C_ContPerson")

        Catch ex As Exception
            lblError.Text = "Error on sbLoadCompanyData - " & ex.Message
        End Try
    End Sub
    Private Sub sbGetTableA_Contribution(Optional ByVal iYear As Integer = -1)
        Try
            'REPORT DATA - CONTRIBUTION
            If iYear > 0 Then
                bRetrieve = myReport.fnGetHTMLReport_Contribution(iYear)
            Else
                bRetrieve = myReport.fnGetHTMLReport_Contribution(Request.QueryString("year").ToString.Trim())
            End If
            If Not bRetrieve Then
                lblError.Text = myReport.GetDBError & " " & myReport.GetExecutionError
                Exit Sub
            End If
            dsContribution = myReport.GetHTML_Contribution
        Catch ex As Exception

        End Try
    End Sub
    Private Sub sbLoadTableA_Contribution(Optional ByVal iYear As Integer = -1)
        Try
            sbGetTableA_Contribution(iYear)

            Dim holder As ContentPlaceHolder = CType(Me.Master.FindControl("MainContent"), ContentPlaceHolder)

            For Each row As DataRow In dsContribution.Tables(0).Rows
                Dim controlName As String = "txtEisfW_" & row(0).ToString()

                Dim ctrl As Control = holder.FindControl(controlName)

                If TypeOf ctrl Is TextBox Then
                    CType(ctrl, TextBox).Text = FormatNumber(row(1).ToString(), 2)
                End If
            Next
        Catch ex As Exception
            lblError.Text = "Error on sbLoadTableA_Contribution - " & ex.Message
        End Try
    End Sub
    Private Sub sbTableA_Calculations()
        Dim objTBW As New TextBox
        Dim objTBC As New TextBox
        Dim objTBEE As New TextBox

        Try
            fSum_TableA = 0
            'sbGetTableA_Contribution(txtYear.Text)
            Dim holder As ContentPlaceHolder = CType(Me.Master.FindControl("MainContent"), ContentPlaceHolder)
            Dim allTextBoxes As List(Of TextBox) = FindAllTextBoxes(holder)

            Dim values() As Integer = {1, 2, 3, 5}
            Dim i As Integer
            Dim rows As List(Of MatrixRowDef) = GetMatrixDefinition()
            For Each item As MatrixRowDef In rows
                Dim rowTotal As Decimal = 0

                If (Not item.IsGroupHeader) And (Not item.IsGroupTotal) Then
                    Dim val As Decimal
                    For Each i In values
                        objTBW = DirectCast(holder.FindControl("txtWeight_" & item.MaterialCode & "_" & i.ToString), TextBox)
                        If objTBW IsNot Nothing Then
                            If Decimal.TryParse(objTBW.Text, Val) Then
                                rowTotal += val
                            End If
                        End If
                    Next
                End If

                if item.IsGroupTotal Then
                    Dim grpsumW As Decimal = 0D
                    Dim grpsumQ As Decimal = 0D

                    'Line items = any textbox whose ID ends with _<key> excluding totals
                    For Each lineTb As TextBox In allTextBoxes
                        If lineTb.ID Is Nothing Then Continue For
                        If lineTb.ID.StartsWith("txtWeightT_", StringComparison.OrdinalIgnoreCase) Then Continue For
                        If lineTb.ID.StartsWith("txtQtyT_", StringComparison.OrdinalIgnoreCase) Then Continue For

                        If lineTb.ID.EndsWith("_" & key, StringComparison.OrdinalIgnoreCase) Then
                            If lineTb.ID.StartsWith("txtWeight_", StringComparison.OrdinalIgnoreCase) Then
                                grpsumW += ParseDecimalSafe(lineTb.Text)
                            ElseIf If lineTb.ID.StartsWith("txtQty_", StringComparison.OrdinalIgnoreCase) Then
                                grpsumQ += ParseDecimalSafe(lineTb.Text)
                            End if
                        End If
                    Next
                end if

                dim totalTbW as textbox = DirectCast(holder.FindControl("txtWeightT_" & item.MaterialCode), TextBox)
                If totalTbW IsNot Nothing Then
                    totalTbW.Text = grpsumW.ToString("0.00", CultureInfo.InvariantCulture)
                End If
                dim totalTbQ as textbox = DirectCast(holder.FindControl("txtWeightT_" & item.MaterialCode), TextBox)
                If totalTbQ IsNot Nothing Then
                    totalTbQ.Text = grpsumQ.ToString("0.00", CultureInfo.InvariantCulture)
                End If
            Next

        Catch ex As Exception
            lblError.Text = "Error on sbLoadTableA_Calculations - " & ex.Message
        End Try
    End Sub
    Private Function CalculateGroupTotals (rows As List(Of MatrixRowDef))
            Try
            For Each item As MatrixRowDef In rows
                Dim rowTotal As Decimal = 0

                If (Not item.IsGroupHeader) And (Not item.IsGroupTotal) Then
                    Dim val As Decimal
                    For Each i In values
                        objTBW = DirectCast(holder.FindControl("txtWeight_" & item.MaterialCode & "_" & i.ToString), TextBox)
                        If objTBW IsNot Nothing Then
                            If Decimal.TryParse(objTBW.Text, Val) Then
                                rowTotal += val
                            End If
                        End If
                    Next
                End If
            Catch ex As Exception
            lblError.Text = "Error on sbLoadTableA_Calculations - " & ex.Message
        End Try
    end Function
    ' Private Sub sbTableBCalculations()
    '     Dim sTableB_Eisfora As String = System.Configuration.ConfigurationManager.AppSettings("REPORT_TABLE_B_STHATHERI_EISFORA")
    '     Dim txtBoxId As String = String.Empty
    '     Dim txtTem As New TextBox
    '     Try
    '         For Each txtBox As TextBox In Me.Master.FindControl("MainContent").Controls.OfType(Of TextBox)
    '            If (txtBox.ID.StartsWith("YR_WeightB")) Then
    '                If IsNumeric(txtBox.Text) Then
    '                    txtBox.Text = FormatNumber(txtBox.Text, 2)
    '                End If
    '            End If
    '            If (txtBox.ID.EndsWith("_TE")) Then
    '                txtBoxId = txtBox.ID.ToString
    '                txtBoxId = txtBoxId.Replace("_TE", "")
    '                txtTem = Me.Master.FindControl("MainContent").FindControl(txtBoxId)
    '                If IsNumeric(txtTem.Text) Then
    '                    txtBox.Text = FormatNumber(Convert.ToDouble(sTableB_Eisfora) * Convert.ToDouble(txtTem.Text), 4)
    '                    fSum_TableB += txtBox.Text
    '                End If
    '            End If
    '         Next
    '         txtSumTableB.Text = FormatNumber(fSum_TableB, 2)

    '     Catch ex As Exception
    '         lblError.Text = "Error on sbTableBCalculations - " & ex.Message
    '     End Try
    ' End Sub
    Private Sub sbLoadTableC()
        Try
            Dim sSumC As String
            Dim fSiskeuasies_EE As Double

            fSiskeuasies_EE = Convert.ToDouble(txtTblC_EisforaA.Text) * Convert.ToDouble(txtTblC_Multiplier.Text)
            txtTblC_EpimEisfora.Text = FormatNumber(fSiskeuasies_EE, 2)

            fSum_Table_AB = fSum_TableA + fSum_TableB
            txtSumTable_AB.Text = FormatNumber(fSum_Table_AB, 2)

            txtSumTableC.Text = FormatNumber(txtTblC_EpimEisfora.Text, 2)
            txtSumTable_ABC.Text = FormatNumber(fSum_Table_AB + fSiskeuasies_EE, 2)

        Catch ex As Exception
            lblError.Text = "Error on sbLoadTableC - " & ex.Message
        End Try
    End Sub

    ' Private Function sbLoadSavedData() As Boolean
    '     Try
    '         Dim dsSavedData As New DataSet
    '         Dim bWithBags As Boolean = (Session(sSession_CompanyBags) = "1")
    '         Dim objTB As New TextBox



    '         sbClearFrm()
    '         sbLoadTableA_Contribution(txtYear.Text)
    '         sbLoadTableC()

    '         'REPORT DATA - QUANTITIES
    '         With myReport
    '             .Year = txtYear.Text
    '             '.CompanyID = Session(sSession_CompanyID)
    '             .CompanyID = lblCompanyID.Text
    '             bRetrieve = .fnGetHTMLReport_SavedData(False, EnumsGlobal.ReportTypeOldNew.Type2024)
    '             If Not bRetrieve Then
    '                 lblError.Text = .GetDBError & " " & .GetExecutionError
    '                 Return False
    '             End If

    '             'dtReport = myReport.GetHTML_ReportDT
    '             dsSavedData = .GetHTML_SavedReportDS
    '         End With

    '         Dim myCookie As HttpCookie = Request.Cookies("myCookie")

    '         myCookie.Values.Add("Year", txtYear.Text)
    '         myCookie.Values.Add("ULogin", Session(sSession_UserLogin))
    '         myCookie.Expires = DateTime.Now.AddHours(12)
    '         Response.Cookies.Add(myCookie)


    '         lblEtos.Text = dsSavedData.Tables(0).Rows(0).Item("YR_Year").ToString
    '         lblCDate.Text = FormatDateTime(CDate(dsSavedData.Tables(0).Rows(0).Item("YR_DateSaved")), DateFormat.ShortDate)

    '         ------------TABLE C-----------------
    '         txtTblC_EisforaA.Text = dsSavedData.Tables(0).Rows(0).Item("YR_WeightC").ToString

    '         If Not IsNumeric(dsSavedData.Tables(0).Rows(0).Item("YR_ContribC").ToString) Then
    '            txtTblC_Multiplier.Text = System.Configuration.ConfigurationManager.AppSettings("REPORT_TABLE_C_MULTIPLIER")
    '         Else
    '            txtTblC_Multiplier.Text = dsSavedData.Tables(0).Rows(0).Item("YR_ContribC").ToString
    '         End If
    '         txtTblC_Multiplier.Text = FormatNumber(txtTblC_Multiplier.Text, 2)

    '         '--------SXETIKA ME TI DILWSI--------
    '         If dsSavedData.Tables(0).Rows(0).Item("YR_Modif").ToString = "0" Then
    '            chkEdit.Checked = False
    '            chkNew.Checked = True
    '            chkNew.Enabled = True
    '            txtDateSentPrev.Enabled = False
    '         Else
    '            chkEdit.Checked = True
    '            chkNew.Checked = False
    '            chkNew.Enabled = False
    '            txtDateSentPrev.Enabled = True
    '            If dsSavedData.Tables(0).Rows(0).Item("YR_DateSentPrev").ToString.Trim = "" Then
    '                txtDateSentPrev.Text = ""
    '            Else
    '                txtDateSentPrev.Text = FormatDateTime(CDate(dsSavedData.Tables(0).Rows(0).Item("YR_DateSentPrev")), DateFormat.ShortDate)
    '            End If

    '         End If
    '         txtNotes.Text = dsSavedData.Tables(0).Rows(0).Item("YR_Comments").ToString

    '         If dsSavedData.Tables(0).Rows(0).Item("YR_ChkSymet1").ToString = "0" Then
    '            chkSymet1.Checked = False
    '         Else
    '            chkSymet1.Checked = True
    '         End If
    '         If dsSavedData.Tables(0).Rows(0).Item("YR_ChkSymet2").ToString = "0" Then
    '            chkSymet2.Checked = False
    '         Else
    '            chkSymet2.Checked = True
    '         End If
    '         If dsSavedData.Tables(0).Rows(0).Item("YR_ChkSymet3").ToString = "0" Then
    '            chkSymet3.Checked = False
    '         Else
    '            chkSymet3.Checked = True
    '         End If

    '         txtYR_SenderName.Text = dsSavedData.Tables(0).Rows(0).Item("YR_SenderName").ToString

    '         Return True

    '     Catch ex As Exception
    '         lblError.Text = "Error on sbLoadSavedData - " & ex.Message
    '         Return False
    '     End Try
    ' End Function
    ' Private Function sbSavePackagingData() As Integer
    '     Try
    '         Dim bExec As Boolean
    '         Dim modif As Integer = 0 'new report
    '         'Dim dateSentPrev As String = Format(Date.Now, "yyyy/MM/dd")
    '         Dim dateSentPrev As String = String.Empty
    '         Dim objTB As New TextBox
    '         Dim iCId As Integer

    '         If Not Integer.TryParse(lblCompanyID.Text, iCId) Then
    '            iCId = -1
    '         End If

    '         If chkNew.Checked = False Then
    '            'modified report
    '            modif = 1
    '            'get date of 1st report
    '            If txtDateSentPrev.Text.Trim <> "" Then
    '                dateSentPrev = Format(CDate(txtDateSentPrev.Text.Trim), "yyyy/MM/dd")
    '            End If
    '         End If

    '         'Dim iCId As Integer = Session(sSession_CompanyID)

    '         'If iCId <= 0 Then
    '         '    iCId = Convert.ToInt32(myCookie.Values("CId"))
    '         'End If

    '         If iCId <= 0 Then
    '            lblError.Text = "Invalid Company Code"
    '            Return EnumsGlobal.FunctionRes.ErrorResult
    '         End If

    '         Dim myCookie As HttpCookie = Request.Cookies("myCookie")
    '         With myCookie
    '            .Values("CId") = iCId.ToString
    '            .Values("Year") = txtYear.Text
    '            .Values("ULogin") = Session(sSession_UserLogin)
    '            .Expires = DateTime.Now.AddHours(12)
    '         End With
    '         Response.AppendCookie(myCookie)

    '         Dim rF As New ReportFields2024
    '         Dim pinfo() As Reflection.PropertyInfo = rF.GetType().GetProperties()
    '         Dim holder As ContentPlaceHolder = CType(Me.Master.FindControl("MainContent"), ContentPlaceHolder)

    '         Dim clog As New clErrorLog

    '         With rF
    '            ' TableA fields
    '            For Each [property] As Reflection.PropertyInfo In pinfo
    '                If ([property].Name.StartsWith("WeightA") Or [property].Name.StartsWith("WeightB")) Then
    '                    'If [property].Name.EndsWith("A1") Or [property].Name.EndsWith("A3") Or [property].Name.EndsWith("A8") Or [property].Name.EndsWith("A12") Or [property].Name.EndsWith("A13") _
    '                    '    Or [property].Name.EndsWith("A10") Or [property].Name.EndsWith("A11") Or [property].Name.EndsWith("A18") Or [property].Name.EndsWith("A19") _
    '                    '    Or [property].Name.EndsWith("A20") Or [property].Name.EndsWith("A21") Or [property].Name.EndsWith("A22") Or [property].Name.EndsWith("A23") _
    '                    '    Or [property].Name.EndsWith("A15") Then
    '                    '    [property].SetValue(rF, "0")
    '                    'Else
    '                    Dim sTxtBoxName As String = String.Empty
    '                    If [property].Name.StartsWith("WeightA") Then
    '                        sTxtBoxName = "YR_" & [property].Name.ToString
    '                    ElseIf [property].Name.StartsWith("WeightB") Then
    '                        sTxtBoxName = "YR_" & [property].Name.ToString
    '                    End If
    '                    objTB = DirectCast(holder.FindControl(sTxtBoxName), TextBox)
    '                    If objTB IsNot Nothing Then
    '                        [property].SetValue(rF, objTB.Text.Trim)
    '                    Else
    '                        [property].SetValue(rF, "0")
    '                    End If
    '                End If
    '            Next

    '            ' Remaining fields
    '            .Year = txtYear.Text
    '            .CID = iCId
    '            .Modif = modif
    '            .DateSentPrev = dateSentPrev
    '            .DateSaved = String.Empty
    '            .DateSent = String.Empty
    '            .Comments = txtNotes.Text.Trim
    '            .WeightB = 0
    '            .ContribB = System.Configuration.ConfigurationManager.AppSettings("REPORT_TABLE_B_STHATHERI_EISFORA")
    '            .WeightC = txtTblC_EisforaA.Text.Trim
    '            .ContribC = txtTblC_Multiplier.Text.Trim
    '            .SenderName = txtYR_SenderName.Text.Trim
    '            .Symet1 = IIf(chkSymet1.Checked = True, 1, 0)
    '            .Symet2 = IIf(chkSymet2.Checked = True, 1, 0)
    '            .Symet3 = IIf(chkSymet3.Checked = True, 1, 0)
    '            .Form2021 = EnumsGlobal.ReportTypeOldNew.Type2024
    '            .OneUseSysk = txtOneUseSysk.Text.Trim
    '            .MultiUseSysk = txtMultiUseSysk.Text.Trim
    '            .PrimarySysk = txtPrimarySysk.Text.Trim
    '            .SecondarySysk = txtSecondarySysk.Text.Trim
    '            '.WeightB2 = txtXartiMetaf_T.Text.Trim
    '            '.WeightB4 = txtXartiLoipa_T.Text.Trim
    '            '.TemaxiaB3_PET = txtPET_T.Text.Trim
    '            '.WeightB6 = txtPPET_T.Text.Trim
    '            '.WeightB7 = txtPP_T.Text.Trim
    '            '.WeightB9 = txtPE_T.Text.Trim
    '            '.WeightB10 = txtPS_T.Text.Trim
    '            '.TemaxiaB8_DPS = txtDPS_T.Text.Trim
    '            '.WeightB14 = txtPO_T.Text.Trim
    '            '.TemaxiaB10_PVC = txtPVC_T.Text.Trim
    '            '.WeightB16 = txtAlles_T.Text.Trim
    '            '.WeightB17 = txtAlouminio_T.Text.Trim
    '            '.WeightB18 = txtSidiros_T.Text.Trim
    '            '.WeightB19 = txtYali_T.Text.Trim
    '            '.WeightB20 = txtKsylo_T.Text.Trim
    '            '.WeightB21 = txtSynthetesXarti_T.Text.Trim
    '            '.TemaxiaB17_SynthetesPlast = txtSynthetesPlast_T.Text.Trim
    '            '.WeightB23 = txtSynthetesGyali_T.Text.Trim
    '         End With
    '         bExec = myReport.fnInsertNewReportDataTbl(rF)

    '         If Not bExec Then
    '            lblError.Text = myReport.GetDBError & " " & myReport.GetExecutionError
    '            Return EnumsGlobal.FunctionRes.ErrorResult
    '         Else
    '            Return EnumsGlobal.FunctionRes.OkResult
    '         End If

    '     Catch ex As Exception
    '         Return EnumsGlobal.FunctionRes.ErrorResult
    '     End Try
    ' End Function
    Private Sub sbClearFrm()
        Try
            txtTblC_Multiplier.Text = FormatNumber(System.Configuration.ConfigurationManager.AppSettings("REPORT_TABLE_C_MULTIPLIER"), 2)

            txtTblC_EisforaA.Text = "0"
            txtTblC_EpimEisfora.Text = "0"

            chkNew.Checked = True
            chkEdit.Checked = False
            txtYR_SenderName.Text = ""
            txtDateSentPrev.Enabled = False
            txtTblC_Multiplier.Enabled = False
            'txtTblC_EisforaA.Enabled = False

        Catch ex As Exception
            lblError.Text = "Error on sbClearFrm - " & ex.Message
        End Try
    End Sub
    ' Private Function sbValidateInput(Optional ByVal bOnlyAmts As Boolean = False) As String
    '     Dim tb As TextBox
    '     Dim holder As ContentPlaceHolder = CType(Me.Master.FindControl("MainContent"), ContentPlaceHolder)
    '     Dim sErrMsg As String = System.Configuration.ConfigurationManager.AppSettings("WarningInvalidData")

    '     Try
    '         For Each c As Control In holder.Controls.OfType(Of TextBox)
    '            If (c.ID.StartsWith("YR_Weight") Or c.ID.StartsWith("YR_Contrib") Or c.ID.StartsWith("txtTblC")) Then
    '                tb = CType(c, TextBox)
    '                If Not IsNumeric(tb.Text) Then
    '                    Return sErrMsg
    '                End If
    '            End If
    '         Next

    '         If bOnlyAmts = False Then
    '            If txtYR_SenderName.Text.Trim = "" Then
    '                sErrMsg = System.Configuration.ConfigurationManager.AppSettings("WarningMissingSender")
    '                myPageEvents.sbSetFocus(txtYR_SenderName)
    '                Return sErrMsg
    '            End If
    '         End If

    '         Return String.Empty

    '     Catch ex As Exception
    '         Return ex.Message
    '     End Try
    ' End Function

    Private Sub sbEraseWrongDecimSep()
        Dim tb As TextBox
        Dim holder As ContentPlaceHolder = CType(Me.Master.FindControl("MainContent"), ContentPlaceHolder)

        Try
            'For Each c As Control In holder.Controls.OfType(Of TextBox)
            '    If (c.ID.StartsWith("YR_Weight") Or c.ID.StartsWith("YR_Contrib") Or c.ID.StartsWith("txtTblC") _
            '        Or c.ID.EndsWith("Sysk")) Then
            '        tb = CType(c, TextBox)
            '        tb.Text.Replace(".", "")
            '    End If
            'Next

        Catch ex As Exception
            lblError.Text = "Error on sbEraseWrongDecimSep - " & ex.Message
        End Try
    End Sub
    Private Sub sbFormatDecimals()
        Dim tb As TextBox
        Dim holder As ContentPlaceHolder = CType(Me.Master.FindControl("MainContent"), ContentPlaceHolder)

        Try
            'For Each c As Control In holder.Controls.OfType(Of TextBox)
            '    If c.ID.StartsWith("YR_WeightA") Then
            '        tb = CType(c, TextBox)
            '        tb.Text = FormatNumber(tb.Text, 2)
            '    ElseIf c.ID.StartsWith("YR_WeightB") Then
            '        tb = CType(c, TextBox)
            '        tb.Text = FormatNumber(tb.Text, 0)
            '    End If
            'Next

            'txtTblC_EisforaA.Text = FormatNumber(txtTblC_EisforaA.Text, 2)
            'txtTblC_Multiplier.Text = FormatNumber(txtTblC_Multiplier.Text, 2)

            'txtOneUseSysk.Text = FormatNumber(txtOneUseSysk.Text, 2)
            'txtMultiUseSysk.Text = FormatNumber(txtMultiUseSysk.Text, 2)
            'txtPrimarySysk.Text = FormatNumber(txtPrimarySysk.Text, 2)
            'txtSecondarySysk.Text = FormatNumber(txtSecondarySysk.Text, 2)
        Catch ex As Exception
            lblError.Text = "Error on sbFormatDecimals - " & ex.Message
        End Try
    End Sub
#End Region

#Region "<CHECK_BOXES>"
    Protected Sub chkNew_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles chkNew.CheckedChanged
        Try
            If chkNew.Checked = True Then
                chkEdit.Checked = False
                txtDateSentPrev.Text = ""
                txtDateSentPrev.Enabled = False
            End If
        Catch ex As Exception

        End Try
    End Sub
    Protected Sub chkEdit_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles chkEdit.CheckedChanged
        Try
            If chkEdit.Checked = True Then
                chkNew.Checked = False
                txtDateSentPrev.Enabled = True
            Else
                txtDateSentPrev.Text = ""
                txtDateSentPrev.Enabled = False
            End If
        Catch ex As Exception

        End Try
    End Sub

#End Region

#Region "<BUTTONS>"
    'Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
    '    Dim iExecRes As Integer

    '    Try
    '        lblError.Text = ""
    '        sbEraseWrongDecimSep()

    '        Dim sValidRes As String = sbValidateInput()
    '        If sValidRes.Trim <> String.Empty Then
    '            myPageEvents.sbDisplaySimpleMessageBox(sValidRes)
    '            Exit Sub
    '        End If

    '        iExecRes = sbSavePackagingData()

    '        If iExecRes = EnumsGlobal.FunctionRes.OkResult Then
    '            myPageEvents.sbDisplaySimpleMessageBox("Η καταχώρηση έγινε με επιτυχία")
    '            'prepare system to load the pdf
    '            Session(sSession_FileName) = Session(sSession_Year) & "_" & Format(Now, "ddMMyyyyTHHmmss")
    '            Session(sSession_CompanyName) = lblCompanyName.Text
    '        End If

    '    Catch exDum As System.Threading.ThreadAbortException
    '        ' Do nothing, exception raised from response.redirect
    '    Catch ex As Exception
    '        lblError.Text = "Error on btnSave_Click - " & ex.Message
    '    End Try
    'End Sub
    Private Sub sbRetrieve_Data()
        Try
            lblError.Text = ""

            If Not CheckIfSessionActive() Then
                Response.Redirect("~/login.aspx")
            End If

            'If sbLoadSavedData() Then
            If LoadMatrix() Then
                sbLoadTableA_Contribution()
                PerformReportCalculations()
                'prepare system to load the pdf
                Session(sSession_Year) = txtYear.Text
                Session(sSession_FileName) = Session(sSession_Year) & "_" & Format(Now, "ddMMyyyyTHHmmss")
                Session(sSession_CompanyName) = lblCompanyName.Text
            End If
            'btnSend.Enabled = False

        Catch exDum As System.Threading.ThreadAbortException
            ' Do nothing, exception raised from response.redirect
        Catch ex As Exception
            lblError.Text = "Error on sbRetrieve_Data() - " & ex.Message
        End Try
    End Sub
    'Protected Sub ddlYear_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlYear.SelectedIndexChanged
    '    lblEtos.Text = ddlYear.SelectedValue
    '    sbClearFrm()
    'End Sub
    Protected Sub btnCalculations_Click(sender As Object, e As EventArgs) Handles btnCalculations.Click
        'If Not CheckIfSessionActive() Then
        '    Response.Redirect("login.aspx")
        'End If
        PerformReportCalculations()
    End Sub
#End Region
    Private Sub InitTextBoxes()
        Dim tb As TextBox
        Dim holder As ContentPlaceHolder = CType(Me.Master.FindControl("MainContent"), ContentPlaceHolder)
        Try
            For Each c As Control In holder.Controls
                If c.[GetType]() = GetType(TextBox) Then
                    If (c.ID.StartsWith("txtWeight_") Or c.ID.StartsWith("txtQty_")) Then
                        tb = CType(c, TextBox)
                        tb.Text = "0"
                    End If
                End If
            Next
        Catch ex As Exception
            lblError.Text = "Error on InitTextBoxes - " & ex.Message
        End Try
    End Sub
    Private Function CheckIfSessionActive() As Boolean
        Try
            If (clsPageEvents.IsSessionExpired) Or (Session(sSession_CompanyID) Is Nothing) Then
                HttpContext.Current.Session.Abandon()
                HttpContext.Current.Session.Clear()
                Response.Cookies.Clear()
                Return False
            End If

            Return True
        Catch ex As Exception
            Return False
        End Try
    End Function
    'Public Function formatUrl() As String
    '    Return "~/reportPDF.aspx?historical=v2024&Cid=" & lblCompanyID.Text & "&Year=" & txtYear.Text
    'End Function

#Region "<MATRIX>"
    Private Class MatrixRowDef
        Public Property IsGroupHeader As Boolean
        Public Property IsGroupTotal As Boolean
        Public Property Title As String
        Public Property MaterialCode As String
        Public Property Contribution As Decimal
    End Class

    Protected Sub Page_Init(sender As Object, e As EventArgs) Handles Me.Init

        BuildMatrixTable()
    End Sub
    Private Sub BuildMatrixHeaders()

        ' **********   BASIC HEADER R1 **********
        Dim tr1 As New TableRow()
        Dim td1 As New TableCell()
        With td1
            .Text = "Είδος Συσκευασιών που διατέθηκαν στην Αγορά"
            .CssClass = "TableHeader2026"
            .Style.Item("width") = "15%"
            .ColumnSpan = 1
            .RowSpan = 3
        End With
        tr1.Cells.Add(td1)

        Dim td2 As New TableCell()
        With td2
            .Text = "Συσκευασίες Μίας Χρήσης"
            .CssClass = "TableHeader2026"
            .Style.Item("width") = "20%"
            .ColumnSpan = 4
        End With
        tr1.Cells.Add(td2)

        Dim td3 As New TableCell()
        With td3
            .Text = "Επαναχρησιμοποιήσιμες Συσκευασίες"
            .CssClass = "TableHeader2026"
            .Style.Item("width") = "45%"
            .ColumnSpan = 8
        End With
        tr1.Cells.Add(td3)

        Dim td4 As New TableCell()
        With td4
            .Text = "ΧΡΗΜΑΤΙΚΗ ΕΙΣΦΟΡΑ"
            .CssClass = "TableHeader2026"
            .Style.Item("width") = "20%"
            .ColumnSpan = 4
            .RowSpan = 2
        End With
        tr1.Cells.Add(td4)
        QuantityDataA1.Rows.Add(tr1)

        ' **********   BASIC HEADER R2 **********
        Dim tr2 As New TableRow()
        Dim td5 As New TableCell()
        With td5
            .Text = "Πρωτογενείς Συσκευασίες (Συσκευασίες προς Πώληση)"
            .CssClass = "TableHeader2026"
            .Style.Item("width") = "10%"
            .ColumnSpan = 2
            .RowSpan = 2
        End With
        tr2.Cells.Add(td5)

        Dim td6 As New TableCell()
        With td6
            .Text = "Δευτερογενείς Συσκευασίες (Ομαδοποιημένες Συσκευασίες) / Τριτογενείς Συσκευασίες (Συσκευασίες Μεταφοράς)"
            .CssClass = "TableHeader2026"
            .Style.Item("width") = "10%"
            .ColumnSpan = 2
            .RowSpan = 2
        End With
        tr2.Cells.Add(td6)

        Dim td7 As New TableCell()
        With td7
            .Text = "Πρωτογενείς Συσκευασίες (Συσκευασίες προς Πώληση)"
            .CssClass = "TableHeader2026"
            .Style.Item("width") = "20%"
            .ColumnSpan = 4
        End With
        tr2.Cells.Add(td7)

        Dim td8 As New TableCell()
        With td8
            .Text = "Δευτερογενείς Συσκευασίες (Ομαδοποιημένες Συσκευασίες) / Τριτογενείς Συσκευασίες (Συσκευασίες Μεταφοράς)"
            .CssClass = "TableHeader2026"
            .Style.Item("width") = "20%"
            .ColumnSpan = 4
        End With
        tr2.Cells.Add(td8)
        QuantityDataA1.Rows.Add(tr2)

        ' **********   BASIC HEADER R3 **********
        Dim tr3 As New TableRow()
        Dim td9 As New TableCell()
        With td9
            .Text = "Διατέθηκαν Πρώτη φορά στην Αγορά"
            .CssClass = "TableHeader2026"
            .Style.Item("width") = "10%"
            .ColumnSpan = 2
        End With
        tr3.Cells.Add(td9)

        Dim td10 As New TableCell()
        With td10
            .Text = "Σύνολο που διατέθηκε στην Αγορά"
            .CssClass = "TableHeader2026"
            .Style.Item("width") = "10%"
            .ColumnSpan = 2
        End With
        tr3.Cells.Add(td10)

        Dim td11 As New TableCell()
        With td11
            .Text = "Διατέθηκαν Πρώτη φορά στην Αγορά"
            .CssClass = "TableHeader2026"
            .Style.Item("width") = "10%"
            .ColumnSpan = 2
        End With
        tr3.Cells.Add(td11)

        Dim td12 As New TableCell()
        With td12
            .Text = "Σύνολο που διατέθηκε στην Αγορά"
            .CssClass = "TableHeader2026"
            .Style.Item("width") = "10%"
            .ColumnSpan = 2
        End With
        tr3.Cells.Add(td12)

        ' EISFORA
        For i As Integer = 1 To 4
            Dim thC As New TableCell()
            With thC
                .CssClass = "TableHeader2026"
                .Style.Item("width") = "10%"
                If i = 1 Or i = 3 Then
                    .Text = "ΟΡΙΣΜΕΝΗ ΕΙΣΦΟΡΑ ΒΑΡΟΥΣ / ΥΛΙΚΟ ΣΥΣΚ."
                ElseIf i = 2 Or i = 4 Then
                    .Text = "ΣΥΝΟΛΙΚΗ ΕΙΣΦΟΡΑ ΒΑΡΟΥΣ / ΥΛΙΚΟ ΣΥΣΚ."
                End If
                .ColumnSpan = 1
            End With
            tr3.Cells.Add(thC)
        Next
        QuantityDataA1.Rows.Add(tr3)
        ' ********** COLUMN HEADERS *************
        Dim tr4 As New TableRow()
        Dim thMaterial As New TableHeaderCell()
        With thMaterial
            .Text = "Υλικό Συσκευασίας"
            .CssClass = "TableRowHeader2026"
            .Style.Item("width") = "15%"
        End With
        tr4.Cells.Add(thMaterial)

        For i As Integer = 1 To 6
            Dim thW As New TableHeaderCell()
            With thW
                .CssClass = "TableRowHeader2026"
                .Style.Item("width") = "5%"
                .Text = "Βάρος συσκ.(kg)"
            End With
            tr4.Cells.Add(thW)

            Dim thQ As New TableHeaderCell()
            With thQ
                .CssClass = "TableRowHeader2026"
                .Style.Item("width") = "5%"
                .Text = "Τεμάχια συσκ."
            End With
            tr4.Cells.Add(thQ)
        Next
        For i As Integer = 1 To 4
            Dim thC As New TableHeaderCell()
            With thC
                .CssClass = "TableRowHeader2026"
                .Style.Item("width") = "5%"
                If i = 1 Then
                    .Text = "Εισφορά"
                ElseIf i = 3 Then
                    .Text = "Σταθερή Εισφορά (€/τμχ.)"
                Else
                    .Text = "Επιμέρους Εισφορά"
                End If
            End With
            tr4.Cells.Add(thC)
        Next
        QuantityDataA1.Rows.Add(tr4)
    End Sub
    Private Sub BuildMatrixTable()
        Dim rows As List(Of MatrixRowDef) = GetMatrixDefinition()

        QuantityDataA1.Rows.Clear()

        'AddHeaderRow()
        BuildMatrixHeaders()

        For Each item As MatrixRowDef In rows
            If item.IsGroupHeader Then
                AddGroupRow(item.Title)
            ElseIf item.IsGroupTotal Then
                AddTotalRow(item.MaterialCode, item.Title)
            Else
                AddMaterialRow(item.MaterialCode, item.Title)
            End If
        Next
    End Sub

    Private Sub AddHeaderRow()
        Dim tr As New TableRow()

        Dim thMaterial As New TableHeaderCell()
        thMaterial.Text = "Material"
        tr.Cells.Add(thMaterial)

        For i As Integer = 1 To 6
            Dim thW As New TableHeaderCell()
            thW.Text = "Weight" & i.ToString()
            tr.Cells.Add(thW)

            Dim thQ As New TableHeaderCell()
            thQ.Text = "Quantity" & i.ToString()
            tr.Cells.Add(thQ)
        Next

        QuantityDataA1.Rows.Add(tr)
    End Sub
    Private Sub AddGroupRow(title As String)
        Dim tr As New TableRow()
        tr.CssClass = "TableHeader2026"

        Dim td As New TableCell()
        td.Text = Server.HtmlEncode(title)
        td.ColumnSpan = 17

        tr.Cells.Add(td)
        QuantityDataA1.Rows.Add(tr)
    End Sub
    Private Sub AddTotalRow(materialCode As String, title As String)
        Dim tr As New TableRow()

        Dim thMaterial As New TableHeaderCell()
        With thMaterial
            .CssClass = "TableRowHeader2026"
            .Style.Item("width") = "15%"
            .Text = Server.HtmlEncode(title)
        End With
        tr.Cells.Add(thMaterial)

        Dim tdWeight As New TableCell()
        With tdWeight
            .CssClass = "mLabelCenter"
            .Style.Item("width") = "5%"
            Dim txtWeight As New TextBox()
            txtWeight.ID = "txtWeightT_" & CleanId(materialCode)
            txtWeight.CssClass = "mTextBoxFlat2026"
            .Controls.Add(txtWeight)
        End With
        tr.Cells.Add(tdWeight)

        Dim tdQty As New TableCell()
        With tdQty
            .CssClass = "mLabelCenter"
            .Style.Item("width") = "5%"
            Dim txtQty As New TextBox()
            txtQty.ID = "txtQtyT_" & CleanId(materialCode)
            txtQty.CssClass = "mTextBoxFlat2026"
            .Controls.Add(txtQty)
        End With
        tr.Cells.Add(tdQty)

        Dim td As New TableCell()
        td.ColumnSpan = 14
        tr.Cells.Add(td)

        QuantityDataA1.Rows.Add(tr)
    End Sub
    Private Sub AddMaterialRow(materialCode As String, title As String)
        Dim tr As New TableRow()

        Try

            Dim tdMaterial As New TableCell()
            With tdMaterial
                .CssClass = "TableRowHeader2026"
                .Style.Item("width") = "15%"
                .Text = Server.HtmlEncode(title)
            End With
            tr.Cells.Add(tdMaterial)

            'Dim hf As New HiddenField()
            'hf.ID = "hfMaterial_" & CleanId(materialCode)
            'hf.Value = materialCode
            'tdMaterial.Controls.Add(hf)

            For i As Integer = 1 To 6
                Dim tdWeight As New TableCell()
                tdWeight.CssClass = "mLabelCenterxs"
                tdWeight.Style.Item("width") = "5%"
                Dim txtWeight As New TextBox()
                txtWeight.ID = "txtWeight_" & CleanId(materialCode) & "_" & i.ToString()
                txtWeight.CssClass = "mTextBoxFlat2026"
                txtWeight.Text = "0"
                tdWeight.Controls.Add(txtWeight)
                tr.Cells.Add(tdWeight)

                Dim tdQty As New TableCell()
                tdQty.CssClass = "mLabelCenterxs"
                tdQty.Style.Item("width") = "5%"
                Dim txtQty As New TextBox()
                txtQty.ID = "txtQty_" & CleanId(materialCode) & "_" & i.ToString()
                txtQty.CssClass = "mTextBoxFlat2026"
                txtQty.Text = "0"
                tdQty.Controls.Add(txtQty)
                tr.Cells.Add(tdQty)
            Next

            Dim tdEisfW As New TableCell()
            tdEisfW.CssClass = "mLabelCenterxs"
            tdEisfW.Style.Item("width") = "5%"
            Dim txtEisfW As New TextBox()
            txtEisfW.ID = "txtEisfW_" & CleanId(materialCode)
            txtEisfW.CssClass = "mTextBoxFlat2026"
            txtEisfW.Text = "0"
            tdEisfW.Controls.Add(txtEisfW)
            tr.Cells.Add(tdEisfW)

            Dim tdEisfWT As New TableCell()
            tdEisfWT.CssClass = "mLabelCenterxs"
            tdEisfWT.Style.Item("width") = "5%"
            Dim txtEisfWT As New TextBox()
            txtEisfWT.ID = "txtEisfWT_" & CleanId(materialCode)
            txtEisfWT.CssClass = "mTextBoxFlat2026"
            txtEisfWT.Text = "0"
            tdEisfWT.Controls.Add(txtEisfWT)
            tr.Cells.Add(tdEisfWT)

            Dim tdEisfQ As New TableCell()
            tdEisfQ.CssClass = "mLabelCenterxs"
            tdEisfQ.Style.Item("width") = "5%"
            Dim txtEisfQ As New TextBox()
            txtEisfQ.ID = "txtEisfQ_" & CleanId(materialCode)
            txtEisfQ.CssClass = "mTextBoxFlat2026"
            txtEisfQ.Text = "0,0004"
            tdEisfQ.Controls.Add(txtEisfQ)
            tr.Cells.Add(tdEisfQ)

            Dim tdEisfQT As New TableCell()
            tdEisfQT.CssClass = "mLabmLabelCenterxselCenter"
            tdEisfQT.Style.Item("width") = "5%"
            Dim txtEisfQT As New TextBox()
            txtEisfQT.ID = "txtEisfQT_" & CleanId(materialCode)
            txtEisfQT.CssClass = "mTextBoxFlat2026"
            txtEisfQT.Text = "0"
            tdEisfQT.Controls.Add(txtEisfQT)
            tr.Cells.Add(tdEisfQT)

            QuantityDataA1.Rows.Add(tr)

        Catch ex As Exception
            lblError.Text = "Error on AddMaterialRow - " & ex.Message
        End Try
    End Sub

    Private Function GetMatrixDefinition() As List(Of MatrixRowDef)
        Dim list As New List(Of MatrixRowDef)()
        Dim dt As New DataTable()

        Try
            Using conn As New SqlConnection(ConfigurationManager.AppSettings("SQL_CONNSTR"))
                Using cmd As New SqlCommand("spGetPTRecords", conn)
                    cmd.CommandType = CommandType.StoredProcedure

                    cmd.Parameters.AddWithValue("@Year", Request.QueryString("year").ToString.Trim())

                    Dim da As New SqlDataAdapter(cmd)
                    da.Fill(dt)
                End Using
            End Using

            For Each row As DataRow In dt.Rows
                Dim id As String = row(0).ToString.Trim
                Dim descr As String = row(1).ToString().Trim
                Dim contrib As Decimal
                Decimal.TryParse(row(2), contrib)

                If row(5) = 1 Then
                    list.Add(New MatrixRowDef With {.IsGroupHeader = True, .MaterialCode = id, .Title = descr})
                ElseIf row(5) = 2 Then
                    list.Add(New MatrixRowDef With {.IsGroupTotal = True, .MaterialCode = id, .Title = descr})
                Else
                    list.Add(New MatrixRowDef With {.MaterialCode = id, .Title = descr, .Contribution = contrib})
                End If
            Next

            Return list
        Catch ex As Exception
            lblError.Text = "Error on GetMatrixDefinition - " & ex.Message
            Return Nothing
        End Try
    End Function

    Private Function CleanId(value As String) As String
        Return value.Replace(".", "_").Replace(" ", "_")
    End Function
    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
        Try
            Dim details As New DataTable()
            details.Columns.Add("MaterialCode", GetType(String))
            details.Columns.Add("PairNo", GetType(Byte))
            details.Columns.Add("WeightValue", GetType(Decimal))
            details.Columns.Add("QuantityValue", GetType(Decimal))

            For Each item As MatrixRowDef In GetMatrixDefinition()
                If item.IsGroupHeader Then
                    Continue For
                End If

                Dim materialCode As String = item.MaterialCode
                Dim safeId As String = CleanId(materialCode)

                For i As Integer = 1 To 6
                    Dim txtWeight As TextBox = CType(QuantityDataA1.FindControl("txtWeight_" & safeId & "_" & i.ToString()), TextBox)
                    Dim txtQty As TextBox = CType(QuantityDataA1.FindControl("txtQty_" & safeId & "_" & i.ToString()), TextBox)

                    Dim weightObj As Object = DBNull.Value
                    Dim qtyObj As Object = DBNull.Value

                    Dim weightVal As Decimal
                    If txtWeight IsNot Nothing AndAlso Decimal.TryParse(txtWeight.Text.Trim(), weightVal) Then
                        weightObj = weightVal
                    End If

                    Dim qtyVal As Decimal
                    If txtQty IsNot Nothing AndAlso Decimal.TryParse(txtQty.Text.Trim(), qtyVal) Then
                        qtyObj = qtyVal
                    End If

                    If weightObj IsNot DBNull.Value OrElse qtyObj IsNot DBNull.Value Then
                        Dim dr As DataRow = details.NewRow()
                        dr("MaterialCode") = materialCode
                        dr("PairNo") = CByte(i)

                        If weightObj Is DBNull.Value Then
                            dr("WeightValue") = DBNull.Value
                        Else
                            dr("WeightValue") = weightObj
                        End If

                        If qtyObj Is DBNull.Value Then
                            dr("QuantityValue") = DBNull.Value
                        Else
                            dr("QuantityValue") = qtyObj
                        End If

                        details.Rows.Add(dr)
                    End If
                Next
            Next

            Dim matrixId As Integer = SaveMatrix(details)

            BuildMatrixTable()

        Catch ex As Exception
            lblError.Text = "Error on Save: " & ex.Message
        End Try
    End Sub

    Private Function ValidateSave() as Integer
        Dim iCId As Integer
        Dim sessionValue As String = TryCast(Session(sSession_CompanyID), String)
        Dim labelValue As String = lblCompanyID.Text

        If Not Integer.TryParse(If(sessionValue, String.Empty).Trim(), iCId) AndAlso _
        Not Integer.TryParse(If(labelValue, String.Empty).Trim(), iCId) Then

            lblError.Text = "Invalid Company Code"
            Return EnumsGlobal.FunctionRes.ErrorResult
        End If

        If iCId <= 0 Then
            lblError.Text = "Invalid Company Code"
            Return EnumsGlobal.FunctionRes.ErrorResult
        End If

        If NOT(chkNew.Checked) Then
            'modified report
            modif = 1
            'get date of 1st report
            If txtDateSentPrev.Text.Trim <> "" Then
                dateSentPrev = Format(CDate(txtDateSentPrev.Text.Trim), "yyyy/MM/dd")
            End If
        End If

        Dim myCookie As HttpCookie = Request.Cookies("myCookie")
        With myCookie
            .Values("CId") = iCId.ToString
            .Values("Year") = txtYear.Text
            .Values("ULogin") = Session(sSession_UserLogin)
            .Expires = DateTime.Now.AddHours(12)
        End With
        Response.AppendCookie(myCookie)
    end Function

    Private Function SaveMatrix(details As DataTable) As Integer
        Try
            if ValidateSave>0 Then Return -1

            Using con As New SqlConnection(ConfigurationManager.AppSettings("SQL_CONNSTR"))
                Using cmd As New SqlCommand("dbo.spInsertYearlyReportMatrix", con)
                    cmd.CommandType = CommandType.StoredProcedure

                    cmd.Parameters.AddWithValue("@CId", cId)
                    cmd.Parameters.AddWithValue("@Year", year)

                    If String.IsNullOrWhiteSpace(createdBy) Then
                        cmd.Parameters.AddWithValue("@CreatedBy", "Unknown")
                    Else
                        cmd.Parameters.AddWithValue("@CreatedBy", Session(sSession_UserLogin))
                    End If

                    If String.IsNullOrWhiteSpace(comments) Then
                        cmd.Parameters.AddWithValue("@Comments", DBNull.Value)
                    Else
                        cmd.Parameters.AddWithValue("@Comments", txtNotes.Text.Trim)
                    End If

                    Dim pDetails As SqlParameter = cmd.Parameters.AddWithValue("@Details", details)
                    pDetails.SqlDbType = SqlDbType.Structured
                    pDetails.TypeName = "dbo.YRMatrixDetailType"

                    con.Open()
                    Dim result As Object = cmd.ExecuteScalar()
                    Return Convert.ToInt32(result)
                End Using
            End Using
        Catch ex As Exception
            Return -1
            lblError.Text = "Error on SaveMatrix: " & ex.Message
        End Try
    End Function
    Private Function UpdateMatrix(createdBy As String, cId As Integer, year As Integer, comments As String, details As DataTable) As Integer
        Try

            Using con As New SqlConnection(ConfigurationManager.AppSettings("SQL_CONNSTR"))
                Using cmd As New SqlCommand("dbo.usp_UpdateMatrix", con)
                    cmd.CommandType = CommandType.StoredProcedure

                    cmd.Parameters.AddWithValue("@CId", cId)
                    cmd.Parameters.AddWithValue("@Year", year)

                    If String.IsNullOrWhiteSpace(createdBy) Then
                        cmd.Parameters.AddWithValue("@CreatedBy", "Unknown")
                    Else
                        cmd.Parameters.AddWithValue("@CreatedBy", createdBy)
                    End If

                    If String.IsNullOrWhiteSpace(comments) Then
                        cmd.Parameters.AddWithValue("@Comments", DBNull.Value)
                    Else
                        cmd.Parameters.AddWithValue("@Comments", comments)
                    End If

                    Dim pDetails As SqlParameter = cmd.Parameters.AddWithValue("@Details", details)
                    pDetails.SqlDbType = SqlDbType.Structured
                    pDetails.TypeName = "dbo.YRMatrixDetailType"

                    con.Open()
                    Dim result As Object = cmd.ExecuteScalar()
                    Return Convert.ToInt32(result)
                End Using
            End Using
        Catch ex As Exception
            Return -1
            lblError.Text = "Error on SaveMatrix: " & ex.Message
        End Try
    End Function
    Private Function LoadMatrix() As Boolean

        Try
            ' Always rebuild first so the textboxes exist
            BuildMatrixTable()

            Using con As New SqlConnection(ConfigurationManager.AppSettings("SQL_CONNSTR"))
                con.Open()

                ' Load header
                Using cmdHeader As New SqlCommand("dbo.spGetYearlyReportMatrixHD", con)
                    cmdHeader.CommandType = CommandType.StoredProcedure
                    cmdHeader.Parameters.AddWithValue("@CId", lblCompanyID.Text)
                    cmdHeader.Parameters.AddWithValue("@Year", txtYear.Text)

                    Using rdr As SqlDataReader = cmdHeader.ExecuteReader()
                        If rdr.Read() Then
                            txtNotes.Text = If(IsDBNull(rdr("YRMH_Comments")), "", rdr("YRMH_Comments").ToString())
                        Else
                            Throw New Exception("MatrixId not found.")
                        End If
                    End Using
                End Using

                ' Load details
                Using cmdDetail As New SqlCommand("dbo.spGetYearlyReportMatrixDT", con)
                    cmdDetail.CommandType = CommandType.StoredProcedure
                    cmdDetail.Parameters.AddWithValue("@CId", lblCompanyID.Text)
                    cmdDetail.Parameters.AddWithValue("@Year", txtYear.Text)

                    Using rdr As SqlDataReader = cmdDetail.ExecuteReader()
                        While rdr.Read()
                            Dim materialCode As String = rdr("YRMD_MaterialId").ToString()
                            Dim pairNo As Integer = Convert.ToInt32(rdr("YRMD_PairNo"))
                            Dim safeId As String = CleanId(materialCode)

                            Dim txtWeight As TextBox = TryCast(FindRecursive(QuantityDataA1, "txtWeight_" & safeId & "_" & pairNo.ToString()), TextBox)
                            Dim txtQty As TextBox = TryCast(FindRecursive(QuantityDataA1, "txtQty_" & safeId & "_" & pairNo.ToString()), TextBox)

                            If txtWeight IsNot Nothing AndAlso Not IsDBNull(rdr("YRMD_WeightValue")) Then
                                txtWeight.Text = Convert.ToDecimal(rdr("YRMD_WeightValue")).ToString("0.###")
                            Else
                                txtWeight.Text = "0"
                            End If

                            If txtQty IsNot Nothing AndAlso Not IsDBNull(rdr("YRMD_QuantityValue")) Then
                                txtQty.Text = Convert.ToDecimal(rdr("YRMD_QuantityValue")).ToString("0.###")
                            Else
                                txtQty.Text = "0"
                            End If
                        End While
                    End Using

                    'hfMatrixId.Value = matrixId.ToString()
                    'txtMatrixId.Text = matrixId.ToString()
                End Using
            End Using

            Dim myCookie As HttpCookie = Request.Cookies("myCookie")

            myCookie.Values.Add("Year", txtYear.Text)
            myCookie.Values.Add("ULogin", Session(sSession_UserLogin))
            myCookie.Expires = DateTime.Now.AddHours(12)
            Response.Cookies.Add(myCookie)

            Return True
        Catch ex As Exception
            lblError.Text = "Error on LoadMatrix: " & ex.Message
            Return False
        End Try
    End Function
    Private Function FindRecursive(parent As Control, id As String) As Control
        If parent Is Nothing Then Return Nothing

        If parent.ID = id Then
            Return parent
        End If

        For Each child As Control In parent.Controls
            Dim result As Control = FindRecursive(child, id)
            If result IsNot Nothing Then
                Return result
            End If
        Next

        Return Nothing
    End Function

    Private Function ParseDecimalValue(value As String, ByRef result As Decimal) As Boolean
        If String.IsNullOrWhiteSpace(value) Then
            Return False
        End If

        Dim normalized As String = value.Trim().Replace(",", ".")

        Return Decimal.TryParse(
        normalized,
        Globalization.NumberStyles.Any,
        Globalization.CultureInfo.InvariantCulture,
        result
    )
    End Function

    Private Function IsNumericValue(value As String) As Boolean
        Dim d As Decimal
        Return ParseDecimalValue(value, d)
    End Function

    Private Sub ClearValidationStyles()
        For Each item As MatrixRowDef In GetMatrixDefinition()
            If item.IsGroupHeader Then Continue For

            Dim materialCode As String = item.MaterialCode
            Dim safeId As String = CleanId(materialCode)

            For i As Integer = 1 To 6
                Dim txtWeight As TextBox = TryCast(FindRecursive(QuantityDataA1, "txtWeight_" & safeId & "_" & i.ToString()), TextBox)
                Dim txtQty As TextBox = TryCast(FindRecursive(QuantityDataA1, "txtQty_" & safeId & "_" & i.ToString()), TextBox)

                If txtWeight IsNot Nothing Then
                    txtWeight.CssClass = "num-box"
                End If

                If txtQty IsNot Nothing Then
                    txtQty.CssClass = "num-box"
                End If
            Next
        Next
    End Sub

    Private Function ValidateMatrixInputs(ByRef errorMessage As String) As Boolean
        ClearValidationStyles()

        For Each item As MatrixRowDef In GetMatrixDefinition()
            If item.IsGroupHeader Then
                Continue For
            End If

            Dim materialCode As String = item.MaterialCode
            Dim safeId As String = CleanId(materialCode)

            For i As Integer = 1 To 6
                Dim txtWeight As TextBox = TryCast(FindRecursive(QuantityDataA1, "txtWeight_" & safeId & "_" & i.ToString()), TextBox)
                Dim txtQty As TextBox = TryCast(FindRecursive(QuantityDataA1, "txtQty_" & safeId & "_" & i.ToString()), TextBox)

                If txtWeight IsNot Nothing Then
                    Dim weightText As String = txtWeight.Text.Trim()

                    If weightText <> "" AndAlso Not IsNumericValue(weightText) Then
                        txtWeight.CssClass = "num-box invalid-box"
                        errorMessage = "Invalid numeric value in " & materialCode & ", Weight" & i.ToString() & "."
                        Return False
                    End If
                End If

                If txtQty IsNot Nothing Then
                    Dim qtyText As String = txtQty.Text.Trim()

                    If qtyText <> "" AndAlso Not IsNumericValue(qtyText) Then
                        txtQty.CssClass = "num-box invalid-box"
                        errorMessage = "Invalid numeric value in " & materialCode & ", Quantity" & i.ToString() & "."
                        Return False
                    End If
                End If
            Next
        Next

        Return True
    End Function
    Private Function FindAllTextBoxes(root As Control) As List(Of TextBox)
        Dim results As New List(Of TextBox)()
        Dim stack As New Stack(Of Control)()
        stack.Push(root)

        While stack.Count > 0
            Dim current As Control = stack.Pop()

            Dim tb As TextBox = TryCast(current, TextBox)
            If tb IsNot Nothing Then results.Add(tb)

            For Each child As Control In current.Controls
                stack.Push(child)
            Next
        End While

        Return results
    End Function
    Private Function ParseDecimalSafe(input As String) As Decimal
        If String.IsNullOrWhiteSpace(input) Then Return 0D

        Dim s As String = input.Trim()

        'If your users type comma decimals, normalize:
        s = s.Replace(",", ".")

        Dim value As Decimal
        If Decimal.TryParse(s, NumberStyles.Any, CultureInfo.InvariantCulture, value) Then
            Return value
        End If

        Return 0D
    End Function
#End Region

End Class

