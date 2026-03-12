Imports System.Data
Partial Class htmlReportEditF
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
                sbLoadTableB()
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

            sbEraseWrongDecimSep()
            Dim sValidRes As String = sbValidateInput(True)
            If sValidRes.Trim <> String.Empty Then
                myPageEvents.sbDisplaySimpleMessageBox(sValidRes)
                Exit Sub
            End If
            sbFormatDecimals()

            ' Perform calcs
            sbTableA_Calculations()
            sbTableBCalculations()
            sbLoadTableC()

            lblError.Text = ""
            'btnSend.Enabled = False

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
        Dim objTB As New TextBox
        Dim sContribFld As String
        Try
            sbGetTableA_Contribution(iYear)

            Dim holder As ContentPlaceHolder = CType(Me.Master.FindControl("MainContent"), ContentPlaceHolder)

            For iCounter As Integer = 0 To dsContribution.Tables(0).Rows.Count - 1
                With dsContribution.Tables(0).Rows(iCounter)
                    If .Item("PT_Contrib").ToString <> "0" Then
                        sContribFld = .Item("PT_Field").ToString.Replace("Weight", "Contrib")
                        objTB = DirectCast(holder.FindControl(sContribFld), TextBox)
                        If sContribFld.StartsWith("YR_ContribB") Then
                            objTB.Text = FormatNumber(.Item("PT_Contrib"), 4)
                        Else
                            objTB.Text = FormatNumber(.Item("PT_Contrib"), 3)
                        End If
                    End If
                End With
            Next
        Catch ex As Exception
            lblError.Text = "Error on sbLoadTableA_Contribution - " & ex.Message
        End Try
    End Sub
    Private Sub sbTableA_Calculations()
        Dim objTBW As New TextBox
        Dim objTBC As New TextBox
        Dim objTBEE As New TextBox
        Dim sContribFld As String
        Dim sEEFld As String
        Try
            fSum_TableA = 0
            sbGetTableA_Contribution(txtYear.Text)
            Dim holder As ContentPlaceHolder = CType(Me.Master.FindControl("MainContent"), ContentPlaceHolder)

            For iCounter As Integer = 0 To dsContribution.Tables(0).Rows.Count - 1
                With dsContribution.Tables(0).Rows(iCounter)
                    If .Item("PT_Contrib").ToString <> "0" Then
                        sContribFld = .Item("PT_Field").ToString.Replace("Weight", "Contrib")
                        If .Item("PT_Field").ToString.StartsWith("YR_WeightB") Then
                            sEEFld = .Item("PT_Field").ToString & "_TE"
                        Else
                            sEEFld = .Item("PT_Field").ToString & "_EE"
                        End If
                        objTBW = DirectCast(holder.FindControl(.Item("PT_Field")), TextBox)
                        objTBC = DirectCast(holder.FindControl(sContribFld), TextBox)
                        objTBEE = DirectCast(holder.FindControl(sEEFld), TextBox)

                        If .Item("PT_Field").ToString.StartsWith("YR_WeightA") Then
                            objTBEE.Text = FormatNumber((objTBW.Text * objTBC.Text) / 1000, 2)
                            fSum_TableA += objTBEE.Text
                        Else
                            objTBEE.Text = FormatNumber((objTBW.Text * objTBC.Text), 2)
                        End If
                    End If
                End With
            Next

            'display the sum
            txtSumTableA.Text = FormatNumber(fSum_TableA, 2)

        Catch ex As Exception
            lblError.Text = "Error on sbLoadTableA_Calculations - " & ex.Message
        End Try
    End Sub

    Private Sub sbLoadTableB()
        Dim sTableB_Eisfora As String = System.Configuration.ConfigurationManager.AppSettings("REPORT_TABLE_B_STHATHERI_EISFORA")
        Dim txtEisf As New TextBox
        Try
            'READ THE STATHERI EISFORA
            'Dim cntT As Integer = Me.Master.FindControl("MainContent").Controls.OfType(Of TextBox)().Count(Function(tb) tb.ID.EndsWith("_E"))
            'For i As Integer = 1 To cntT
            '    txtEisf = Me.Master.FindControl("MainContent").FindControl("txtTemaxia_E" & i.ToString.Trim)
            '    txtEisf.Text = sTableB_Eisfora
            'Next

        Catch ex As Exception
            lblError.Text = "Error on sbLoadTableB - " & ex.Message
        End Try
    End Sub
    Private Sub sbTableBCalculations()
        Dim sTableB_Eisfora As String = System.Configuration.ConfigurationManager.AppSettings("REPORT_TABLE_B_STHATHERI_EISFORA")
        Dim txtBoxId As String = String.Empty
        Dim txtTem As New TextBox
        Try
            For Each txtBox As TextBox In Me.Master.FindControl("MainContent").Controls.OfType(Of TextBox)
                If (txtBox.ID.StartsWith("YR_WeightB")) Then
                    If IsNumeric(txtBox.Text) Then
                        txtBox.Text = FormatNumber(txtBox.Text, 2)
                    End If
                End If
                If (txtBox.ID.EndsWith("_TE")) Then
                    txtBoxId = txtBox.ID.ToString
                    txtBoxId = txtBoxId.Replace("_TE", "")
                    txtTem = Me.Master.FindControl("MainContent").FindControl(txtBoxId)
                    If IsNumeric(txtTem.Text) Then
                        txtBox.Text = FormatNumber(Convert.ToDouble(sTableB_Eisfora) * Convert.ToDouble(txtTem.Text), 4)
                        fSum_TableB += txtBox.Text
                    End If
                End If
            Next
            txtSumTableB.Text = FormatNumber(fSum_TableB, 2)

        Catch ex As Exception
            lblError.Text = "Error on sbTableBCalculations - " & ex.Message
        End Try
    End Sub
    Private Sub sbLoadTableC()
        Try
            'Dim sSumC As String
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

    Private Function sbLoadSavedData() As Boolean
        Try
            Dim dsSavedData As New DataSet
            Dim bWithBags As Boolean = (Session(sSession_CompanyBags) = "1")
            Dim objTB As New TextBox

            sbClearFrm()
            sbLoadTableA_Contribution(txtYear.Text)
            sbLoadTableB()
            sbLoadTableC()

            'REPORT DATA - QUANTITIES
            With myReport
                .Year = txtYear.Text
                '.CompanyID = Session(sSession_CompanyID)
                .CompanyID = lblCompanyID.Text
                bRetrieve = .fnGetHTMLReport_SavedData(False, EnumsGlobal.ReportTypeOldNew.Type2024)
                If Not bRetrieve Then
                    lblError.Text = .GetDBError & " " & .GetExecutionError
                    Return False
                End If

                'dtReport = myReport.GetHTML_ReportDT
                dsSavedData = .GetHTML_SavedReportDS
            End With

            Dim myCookie As HttpCookie = Request.Cookies("myCookie")

            myCookie.Values.Add("Year", txtYear.Text)
            myCookie.Values.Add("ULogin", Session(sSession_UserLogin))
            myCookie.Expires = DateTime.Now.AddHours(12)
            Response.Cookies.Add(myCookie)


            lblEtos.Text = dsSavedData.Tables(0).Rows(0).Item("YR_Year").ToString
            lblCDate.Text = FormatDateTime(CDate(dsSavedData.Tables(0).Rows(0).Item("YR_DateSaved")), DateFormat.ShortDate)

            'fill the fields
            '------------TABLE Market-----------------
            txtOneUseSysk.Text = dsSavedData.Tables(0).Rows(0).Item("YR_OneUse").ToString
            txtMultiUseSysk.Text = dsSavedData.Tables(0).Rows(0).Item("YR_MultiUse").ToString
            txtPrimarySysk.Text = dsSavedData.Tables(0).Rows(0).Item("YR_PrimaryTem").ToString
            txtSecondarySysk.Text = dsSavedData.Tables(0).Rows(0).Item("YR_SecondaryTem").ToString
            '------------TABLE A-----------------
            Dim holder As ContentPlaceHolder = CType(Me.Master.FindControl("MainContent"), ContentPlaceHolder)

            For iCounter As Integer = 0 To dsContribution.Tables(0).Rows.Count - 1
                With dsContribution.Tables(0).Rows(iCounter)
                    objTB = DirectCast(holder.FindControl(.Item("PT_Field")), TextBox)
                    objTB.Text = dsSavedData.Tables(0).Rows(0).Item(.Item("PT_Field").ToString).ToString
                End With
            Next

            '------------TABLE B-----------------
            'txtTemaxia.Text = dsSavedData.Tables(0).Rows(0).Item("YR_WeightB").ToString
            'txtTemaxia_E.Text = dsSavedData.Tables(0).Rows(0).Item("YR_ContribB").ToString
            'txtXartiMetaf_T.Text = dsSavedData.Tables(0).Rows(0).Item("YR_WeightB2").ToString
            'txtXartiLoipa_T.Text = dsSavedData.Tables(0).Rows(0).Item("YR_WeightB4").ToString
            'YR_WeightB5_T.Text = dsSavedData.Tables(0).Rows(0).Item("YR_WeightB5").ToString
            'txtPPET_T.Text = dsSavedData.Tables(0).Rows(0).Item("YR_WeightB6").ToString
            'YR_WeightB7_T.Text = dsSavedData.Tables(0).Rows(0).Item("YR_WeightB7").ToString
            'YR_WeightB9_T.Text = dsSavedData.Tables(0).Rows(0).Item("YR_WeightB9").ToString
            'YR_WeightB10_T.Text = dsSavedData.Tables(0).Rows(0).Item("YR_WeightB10").ToString
            'txtDPS_T.Text = dsSavedData.Tables(0).Rows(0).Item("YR_WeightB11").ToString
            'YR_WeightB14_T.Text = dsSavedData.Tables(0).Rows(0).Item("YR_WeightB14").ToString
            'txtPVC_T.Text = dsSavedData.Tables(0).Rows(0).Item("YR_WeightB15").ToString
            'txtAlles_T.Text = dsSavedData.Tables(0).Rows(0).Item("YR_WeightB16").ToString
            'txtAlouminio_T.Text = dsSavedData.Tables(0).Rows(0).Item("YR_WeightB17").ToString
            'txtSidiros_T.Text = dsSavedData.Tables(0).Rows(0).Item("YR_WeightB18").ToString
            'txtYali_T.Text = dsSavedData.Tables(0).Rows(0).Item("YR_WeightB19").ToString
            'txtKsylo_T.Text = dsSavedData.Tables(0).Rows(0).Item("YR_WeightB20").ToString
            'txtSynthetesXarti_T.Text = dsSavedData.Tables(0).Rows(0).Item("YR_WeightB21").ToString
            'txtSynthetesPlast_T.Text = dsSavedData.Tables(0).Rows(0).Item("YR_WeightB22").ToString
            'txtSynthetesGyali_T.Text = dsSavedData.Tables(0).Rows(0).Item("YR_WeightB23").ToString
            'txtXartiMetaf_TE.Text = dsSavedData.Tables(0).Rows(0).Item("YR_ContribB").ToString
            'txtXartiLoipa_TE.Text = dsSavedData.Tables(0).Rows(0).Item("YR_ContribB").ToString
            'txtPET_TE.Text = dsSavedData.Tables(0).Rows(0).Item("YR_ContribB").ToString
            'YR_WeightB5_TE.Text = dsSavedData.Tables(0).Rows(0).Item("YR_ContribB").ToString
            'YR_WeightB7_TE.Text = dsSavedData.Tables(0).Rows(0).Item("YR_ContribB").ToString
            'YR_WeightB9_TE.Text = dsSavedData.Tables(0).Rows(0).Item("YR_ContribB").ToString
            'YR_WeightB10_TE.Text = dsSavedData.Tables(0).Rows(0).Item("YR_ContribB").ToString
            'txtDPS_TE.Text = dsSavedData.Tables(0).Rows(0).Item("YR_ContribB").ToString
            'YR_WeightB14_TE.Text = dsSavedData.Tables(0).Rows(0).Item("YR_ContribB").ToString
            'txtPVC_TE.Text = dsSavedData.Tables(0).Rows(0).Item("YR_ContribB").ToString
            'txtAlles_TE.Text = dsSavedData.Tables(0).Rows(0).Item("YR_ContribB").ToString
            'txtAlouminio_TE.Text = dsSavedData.Tables(0).Rows(0).Item("YR_ContribB").ToString
            'txtSidiros_TE.Text = dsSavedData.Tables(0).Rows(0).Item("YR_ContribB").ToString
            'txtYali_TE.Text = dsSavedData.Tables(0).Rows(0).Item("YR_ContribB").ToString
            'txtKsylo_TE.Text = dsSavedData.Tables(0).Rows(0).Item("YR_ContribB").ToString
            'txtSynthetesXarti_TE.Text = dsSavedData.Tables(0).Rows(0).Item("YR_ContribB").ToString
            'txtSynthetesPlast_TE.Text = dsSavedData.Tables(0).Rows(0).Item("YR_ContribB").ToString
            'txtSynthetesGyali_TE.Text = dsSavedData.Tables(0).Rows(0).Item("YR_ContribB").ToString
            '------------TABLE C-----------------
            txtTblC_EisforaA.Text = dsSavedData.Tables(0).Rows(0).Item("YR_WeightC").ToString

            If Not IsNumeric(dsSavedData.Tables(0).Rows(0).Item("YR_ContribC").ToString) Then
                txtTblC_Multiplier.Text = System.Configuration.ConfigurationManager.AppSettings("REPORT_TABLE_C_MULTIPLIER")
            Else
                txtTblC_Multiplier.Text = dsSavedData.Tables(0).Rows(0).Item("YR_ContribC").ToString
            End If
            txtTblC_Multiplier.Text = FormatNumber(txtTblC_Multiplier.Text, 2)

            '--------SXETIKA ME TI DILWSI--------
            If dsSavedData.Tables(0).Rows(0).Item("YR_Modif").ToString = "0" Then
                chkEdit.Checked = False
                chkNew.Checked = True
                chkNew.Enabled = True
                txtDateSentPrev.Enabled = False
            Else
                chkEdit.Checked = True
                chkNew.Checked = False
                chkNew.Enabled = False
                txtDateSentPrev.Enabled = True
                If dsSavedData.Tables(0).Rows(0).Item("YR_DateSentPrev").ToString.Trim = "" Then
                    txtDateSentPrev.Text = ""
                Else
                    txtDateSentPrev.Text = FormatDateTime(CDate(dsSavedData.Tables(0).Rows(0).Item("YR_DateSentPrev")), DateFormat.ShortDate)
                End If

            End If
            txtNotes.Text = dsSavedData.Tables(0).Rows(0).Item("YR_Comments").ToString

            If dsSavedData.Tables(0).Rows(0).Item("YR_ChkSymet1").ToString = "0" Then
                chkSymet1.Checked = False
            Else
                chkSymet1.Checked = True
            End If
            If dsSavedData.Tables(0).Rows(0).Item("YR_ChkSymet2").ToString = "0" Then
                chkSymet2.Checked = False
            Else
                chkSymet2.Checked = True
            End If
            If dsSavedData.Tables(0).Rows(0).Item("YR_ChkSymet3").ToString = "0" Then
                chkSymet3.Checked = False
            Else
                chkSymet3.Checked = True
            End If

            txtYR_SenderName.Text = dsSavedData.Tables(0).Rows(0).Item("YR_SenderName").ToString

            Return True

        Catch ex As Exception
            lblError.Text = "Error on sbLoadSavedData - " & ex.Message
            Return False
        End Try
    End Function
    Private Function sbSavePackagingData() As Integer
        Try
            Dim bExec As Boolean
            Dim modif As Integer = 0 'new report
            'Dim dateSentPrev As String = Format(Date.Now, "yyyy/MM/dd")
            Dim dateSentPrev As String = String.Empty
            Dim objTB As New TextBox
            Dim iCId As Integer

            If Not Integer.TryParse(lblCompanyID.Text, iCId) Then
                iCId = -1
            End If

            If chkNew.Checked = False Then
                'modified report
                modif = 1
                'get date of 1st report
                If txtDateSentPrev.Text.Trim <> "" Then
                    dateSentPrev = Format(CDate(txtDateSentPrev.Text.Trim), "yyyy/MM/dd")
                End If
            End If

            'Dim iCId As Integer = Session(sSession_CompanyID)

            'If iCId <= 0 Then
            '    iCId = Convert.ToInt32(myCookie.Values("CId"))
            'End If

            If iCId <= 0 Then
                lblError.Text = "Invalid Company Code"
                Return EnumsGlobal.FunctionRes.ErrorResult
            End If

            Dim myCookie As HttpCookie = Request.Cookies("myCookie")
            With myCookie
                .Values("CId") = iCId.ToString
                .Values("Year") = txtYear.Text
                .Values("ULogin") = Session(sSession_UserLogin)
                .Expires = DateTime.Now.AddHours(12)
            End With
            Response.AppendCookie(myCookie)

            Dim rF As New ReportFields2024
            Dim pinfo() As Reflection.PropertyInfo = rF.GetType().GetProperties()
            Dim holder As ContentPlaceHolder = CType(Me.Master.FindControl("MainContent"), ContentPlaceHolder)

            Dim clog As New clErrorLog

            With rF
                ' TableA fields
                For Each [property] As Reflection.PropertyInfo In pinfo
                    If ([property].Name.StartsWith("WeightA") Or [property].Name.StartsWith("WeightB")) Then
                        'If [property].Name.EndsWith("A1") Or [property].Name.EndsWith("A3") Or [property].Name.EndsWith("A8") Or [property].Name.EndsWith("A12") Or [property].Name.EndsWith("A13") _
                        '    Or [property].Name.EndsWith("A10") Or [property].Name.EndsWith("A11") Or [property].Name.EndsWith("A18") Or [property].Name.EndsWith("A19") _
                        '    Or [property].Name.EndsWith("A20") Or [property].Name.EndsWith("A21") Or [property].Name.EndsWith("A22") Or [property].Name.EndsWith("A23") _
                        '    Or [property].Name.EndsWith("A15") Then
                        '    [property].SetValue(rF, "0")
                        'Else
                        Dim sTxtBoxName As String = String.Empty
                        If [property].Name.StartsWith("WeightA") Then
                            sTxtBoxName = "YR_" & [property].Name.ToString
                        ElseIf [property].Name.StartsWith("WeightB") Then
                            sTxtBoxName = "YR_" & [property].Name.ToString
                        End If
                        objTB = DirectCast(holder.FindControl(sTxtBoxName), TextBox)
                        If objTB IsNot Nothing Then
                            [property].SetValue(rF, objTB.Text.Trim)
                        Else
                            [property].SetValue(rF, "0")
                        End If
                    End If
                Next

                ' Remaining fields
                .Year = txtYear.Text
                .CID = iCId
                .Modif = modif
                .DateSentPrev = dateSentPrev
                .DateSaved = String.Empty
                .DateSent = String.Empty
                .Comments = txtNotes.Text.Trim
                .WeightB = 0
                .ContribB = System.Configuration.ConfigurationManager.AppSettings("REPORT_TABLE_B_STHATHERI_EISFORA")
                .WeightC = txtTblC_EisforaA.Text.Trim
                .ContribC = txtTblC_Multiplier.Text.Trim
                .SenderName = txtYR_SenderName.Text.Trim
                .Symet1 = IIf(chkSymet1.Checked = True, 1, 0)
                .Symet2 = IIf(chkSymet2.Checked = True, 1, 0)
                .Symet3 = IIf(chkSymet3.Checked = True, 1, 0)
                .Form2021 = EnumsGlobal.ReportTypeOldNew.Type2024
                .OneUseSysk = txtOneUseSysk.Text.Trim
                .MultiUseSysk = txtMultiUseSysk.Text.Trim
                .PrimarySysk = txtPrimarySysk.Text.Trim
                .SecondarySysk = txtSecondarySysk.Text.Trim
                '.WeightB2 = txtXartiMetaf_T.Text.Trim
                '.WeightB4 = txtXartiLoipa_T.Text.Trim
                '.TemaxiaB3_PET = txtPET_T.Text.Trim
                '.WeightB6 = txtPPET_T.Text.Trim
                '.WeightB7 = txtPP_T.Text.Trim
                '.WeightB9 = txtPE_T.Text.Trim
                '.WeightB10 = txtPS_T.Text.Trim
                '.TemaxiaB8_DPS = txtDPS_T.Text.Trim
                '.WeightB14 = txtPO_T.Text.Trim
                '.TemaxiaB10_PVC = txtPVC_T.Text.Trim
                '.WeightB16 = txtAlles_T.Text.Trim
                '.WeightB17 = txtAlouminio_T.Text.Trim
                '.WeightB18 = txtSidiros_T.Text.Trim
                '.WeightB19 = txtYali_T.Text.Trim
                '.WeightB20 = txtKsylo_T.Text.Trim
                '.WeightB21 = txtSynthetesXarti_T.Text.Trim
                '.TemaxiaB17_SynthetesPlast = txtSynthetesPlast_T.Text.Trim
                '.WeightB23 = txtSynthetesGyali_T.Text.Trim
            End With
            bExec = myReport.fnInsertNewReportDataTbl(rF)

            If Not bExec Then
                lblError.Text = myReport.GetDBError & " " & myReport.GetExecutionError
                Return EnumsGlobal.FunctionRes.ErrorResult
            Else
                Return EnumsGlobal.FunctionRes.OkResult
            End If

        Catch ex As Exception
            Return EnumsGlobal.FunctionRes.ErrorResult
        End Try
    End Function
    Private Sub sbClearFrm()
        Try
            txtTblC_Multiplier.Text = FormatNumber(System.Configuration.ConfigurationManager.AppSettings("REPORT_TABLE_C_MULTIPLIER"), 2)
            InitTextBoxes()

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
    Private Function sbValidateInput(Optional ByVal bOnlyAmts As Boolean = False) As String
        Dim tb As TextBox
        Dim holder As ContentPlaceHolder = CType(Me.Master.FindControl("MainContent"), ContentPlaceHolder)
        Dim sErrMsg As String = System.Configuration.ConfigurationManager.AppSettings("WarningInvalidData")

        Try
            For Each c As Control In holder.Controls.OfType(Of TextBox)
                If (c.ID.StartsWith("YR_Weight") Or c.ID.StartsWith("YR_Contrib") Or c.ID.StartsWith("txtTblC")) Then
                    tb = CType(c, TextBox)
                    If Not IsNumeric(tb.Text) Then
                        Return sErrMsg
                    End If
                End If
            Next

            If bOnlyAmts = False Then
                If txtYR_SenderName.Text.Trim = "" Then
                    sErrMsg = System.Configuration.ConfigurationManager.AppSettings("WarningMissingSender")
                    myPageEvents.sbSetFocus(txtYR_SenderName)
                    Return sErrMsg
                End If
            End If

            Return String.Empty

        Catch ex As Exception
            Return ex.Message
        End Try
    End Function

    Private Sub sbEraseWrongDecimSep()
        Dim tb As TextBox
        Dim holder As ContentPlaceHolder = CType(Me.Master.FindControl("MainContent"), ContentPlaceHolder)

        Try
            For Each c As Control In holder.Controls.OfType(Of TextBox)
                If (c.ID.StartsWith("YR_Weight") Or c.ID.StartsWith("YR_Contrib") Or c.ID.StartsWith("txtTblC") _
                    Or c.ID.EndsWith("Sysk")) Then
                    tb = CType(c, TextBox)
                    tb.Text.Replace(".", "")
                End If
            Next

        Catch ex As Exception
            lblError.Text = "Error on sbEraseWrongDecimSep - " & ex.Message
        End Try
    End Sub
    Private Sub sbFormatDecimals()
        Dim tb As TextBox
        Dim holder As ContentPlaceHolder = CType(Me.Master.FindControl("MainContent"), ContentPlaceHolder)

        Try
            For Each c As Control In holder.Controls.OfType(Of TextBox)
                If c.ID.StartsWith("YR_WeightA") Then
                    tb = CType(c, TextBox)
                    tb.Text = FormatNumber(tb.Text, 2)
                ElseIf c.ID.StartsWith("YR_WeightB") Then
                    tb = CType(c, TextBox)
                    tb.Text = FormatNumber(tb.Text, 0)
                End If
            Next

            txtTblC_EisforaA.Text = FormatNumber(txtTblC_EisforaA.Text, 2)
            txtTblC_Multiplier.Text = FormatNumber(txtTblC_Multiplier.Text, 2)

            txtOneUseSysk.Text = FormatNumber(txtOneUseSysk.Text, 2)
            txtMultiUseSysk.Text = FormatNumber(txtMultiUseSysk.Text, 2)
            txtPrimarySysk.Text = FormatNumber(txtPrimarySysk.Text, 2)
            txtSecondarySysk.Text = FormatNumber(txtSecondarySysk.Text, 2)
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
    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
        Dim iExecRes As Integer

        Try
            lblError.Text = ""
            sbEraseWrongDecimSep()

            Dim sValidRes As String = sbValidateInput()
            If sValidRes.Trim <> String.Empty Then
                myPageEvents.sbDisplaySimpleMessageBox(sValidRes)
                Exit Sub
            End If

            iExecRes = sbSavePackagingData()

            If iExecRes = EnumsGlobal.FunctionRes.OkResult Then
                myPageEvents.sbDisplaySimpleMessageBox("Η καταχώρηση έγινε με επιτυχία")
                'prepare system to load the pdf
                Session(sSession_FileName) = Session(sSession_Year) & "_" & Format(Now, "ddMMyyyyTHHmmss")
                Session(sSession_CompanyName) = lblCompanyName.Text
            End If

        Catch exDum As System.Threading.ThreadAbortException
            ' Do nothing, exception raised from response.redirect
        Catch ex As Exception
            lblError.Text = "Error on btnSave_Click - " & ex.Message
        End Try
    End Sub
    Private Sub sbRetrieve_Data()
        Try
            lblError.Text = ""

            If Not CheckIfSessionActive() Then
                Response.Redirect("~/login.aspx")
            End If

            If sbLoadSavedData() Then
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
    'Private Sub btnTestData_Click(sender As Object, e As EventArgs) Handles btnTestData.Click
    '    Dim tb As TextBox
    '    Dim holder As ContentPlaceHolder = CType(Me.Master.FindControl("MainContent"), ContentPlaceHolder)
    '    Try
    '        For Each c As Control In holder.Controls
    '            If c.[GetType]() = GetType(TextBox) Then
    '                If (c.ID.StartsWith("YR_WeightA")) Then
    '                    tb = CType(c, TextBox)
    '                    tb.Text = "1"
    '                End If
    '            End If
    '            If c.[GetType]() = GetType(TextBox) Then
    '                If (c.ID.StartsWith("YR_WeightB")) Then
    '                    tb = CType(c, TextBox)
    '                    tb.Text = "1000"
    '                End If
    '            End If
    '        Next
    '        txtTblC_EisforaA.Text = "110"
    '        txtYR_SenderName.Text = "at"
    '    Catch ex As Exception
    '        lblError.Text = "Error on InitTextBoxes - " & ex.Message
    '    End Try
    'End Sub
#End Region
    Private Sub InitTextBoxes()
        Dim tb As TextBox
        Dim holder As ContentPlaceHolder = CType(Me.Master.FindControl("MainContent"), ContentPlaceHolder)
        Try
            For Each c As Control In holder.Controls
                If c.[GetType]() = GetType(TextBox) Then
                    If (c.ID.StartsWith("YR_Weight") Or c.ID.StartsWith("txtSumTable") Or c.ID.EndsWith("Sysk") Or c.ID.EndsWith("_TE")) Then
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
End Class

