Imports System.Data
Imports System.Data.SqlClient
Imports System.Globalization
Imports System.Runtime.CompilerServices
Imports System.Text.RegularExpressions
Imports AjaxControlToolkit.HtmlEditor.ToolbarButtons
Imports DataReaderExtensions
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
        Dim errMsg As String = String.Empty
        Try

            'sbEraseWrongDecimSep()
            'If Not (ValidateMatrixInputs(errMsg)) Then
            '    myPageEvents.sbDisplaySimpleMessageBox(errMsg)
            '    Exit Sub
            'End If

            'sbFormatDecimals()

            '' Perform calcs
            sbTableA_Calculations()
            sbLoadTableC()

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
                            If Decimal.TryParse(objTBW.Text, val) Then
                                rowTotal += val
                            End If
                        End If
                    Next

                    rowTotal = rowTotal * item.Contribution

                    objTBEE = DirectCast(holder.FindControl("txtEisfWT_" & item.MaterialCode), TextBox)
                    If objTBEE IsNot Nothing Then
                        objTBEE.Text = rowTotal.ToString()
                    End If
                    fSum_TableA += rowTotal

                ElseIf item.IsGroupTotal Then
                    Dim grpsumW As Decimal = 0D
                    Dim grpsumQ As Decimal = 0D

                    'Line items = any textbox whose ID ends with _<key> excluding totals
                    Dim pattern As String = "_" & item.MaterialCode.Remove(item.MaterialCode.Length - 1) & "\d*_1"
                    'Dim hasMatch As Boolean = allTextBoxes.Any(Function(tb) Regex.IsMatch(tb.ID, pattern))
                    Dim matches = allTextBoxes.Where(Function(tb) Regex.IsMatch(tb.ID, pattern)).ToList()

                    For Each lineTb As TextBox In matches
                        If lineTb.ID Is Nothing Then Continue For
                        If lineTb.ID.StartsWith("txtWeightT_", StringComparison.OrdinalIgnoreCase) Then Continue For
                        If lineTb.ID.StartsWith("txtQtyT_", StringComparison.OrdinalIgnoreCase) Then Continue For

                        If lineTb.ID.StartsWith("txtWeight_", StringComparison.OrdinalIgnoreCase) Then
                            grpsumW += ParseDecimalSafe(lineTb.Text)
                        ElseIf lineTb.ID.StartsWith("txtQty_", StringComparison.OrdinalIgnoreCase) Then
                            grpsumQ += ParseDecimalSafe(lineTb.Text)
                        End If
                    Next

                    Dim totalTbW As TextBox = DirectCast(holder.FindControl("txtWeightT_" & item.MaterialCode), TextBox)
                    If totalTbW IsNot Nothing Then
                        totalTbW.Text = grpsumW.ToString("0.00", CultureInfo.InvariantCulture)
                    End If
                    Dim totalTbQ As TextBox = DirectCast(holder.FindControl("txtQtyT_" & item.MaterialCode), TextBox)
                    If totalTbQ IsNot Nothing Then
                        totalTbQ.Text = grpsumQ.ToString("0.00", CultureInfo.InvariantCulture)
                    End If
                End If
            Next

            'display the sum
            txtSumTableA.Text = FormatNumber(fSum_TableA, 2)

        Catch ex As Exception
            lblError.Text = "Error on sbLoadTableA_Calculations - " & ex.Message
        End Try
    End Sub
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
                AddGroupRow(item.MaterialCode, item.Title)
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
    Private Sub AddGroupRow(materialCode As String, title As String)
        Dim tr As New TableRow()
        tr.CssClass = "TableHeader2026"

        Dim td As New TableCell()
        td.Text = Server.HtmlEncode(title)
        tr.Cells.Add(td)

        td = New TableCell()
        With td
            .Text = "ΠΕΡΙΕΧΟΝΤΑΙ ΦΙΑΛΕΣ ΠΟΤΩΝ ΜΙΑΣ ΧΡΗΣΗΣ;"
            .ColumnSpan = 4
        End With
        tr.Cells.Add(td)

        td = New TableCell()
        With td
            .CssClass = "mLabelCenterTotals"
            .Style.Item("width") = "5%"
            Dim rbB As New RadioButtonList()
            rbB.ID = "rbWeight1_" & CleanId(materialCode)
            rbB.RepeatDirection = RepeatDirection.Horizontal
            rbB.Items.Add(New ListItem("Ναι", "1"))
            rbB.Items.Add(New ListItem("Όχι", "0"))
            rbB.CssClass = "mChkRbFlat2026"
            .ColumnSpan = 2
            .Controls.Add(rbB)
        End With
        tr.Cells.Add(td)

        td = New TableCell()
        With td
            .Text = "ΠΕΡΙΕΧΟΝΤΑΙ ΚΥΠΕΛΑΚΙΑ & ΠΕΡΙΕΚΤΕΣ ΤΡΟΦΙΜΩΝ ΠΟΤΩΝ ΜΙΑΣ ΧΡΗΣΗΣ;"
            .ColumnSpan = 4
        End With
        tr.Cells.Add(td)

        td = New TableCell()
        With td
            .CssClass = "mLabelCenterTotals"
            .Style.Item("width") = "5%"
            Dim rbC As New RadioButtonList()
            rbC.ID = "rbWeight2_" & CleanId(materialCode)
            rbC.RepeatDirection = RepeatDirection.Horizontal
            rbC.Items.Add(New ListItem("Ναι", "1"))
            rbC.Items.Add(New ListItem("Όχι", "0"))
            rbC.CssClass = "mChkRbFlat2026"
            .ColumnSpan = 2
            .Controls.Add(rbC)
        End With
        tr.Cells.Add(td)

        td = New TableCell()
        td.ColumnSpan = 14
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
            .CssClass = "mLabelCenterTotals"
            .Style.Item("width") = "5%"
            Dim txtWeight As New TextBox()
            txtWeight.ID = "txtWeightT_" & CleanId(materialCode)
            txtWeight.CssClass = "mTextBoxFlat2026"
            txtWeight.Text = "0"
            .Controls.Add(txtWeight)
        End With
        tr.Cells.Add(tdWeight)

        Dim tdQty As New TableCell()
        With tdQty
            .CssClass = "mLabelCenterTotals"
            .Style.Item("width") = "5%"
            Dim txtQty As New TextBox()
            txtQty.ID = "txtQtyT_" & CleanId(materialCode)
            txtQty.CssClass = "mTextBoxFlat2026"
            txtQty.Text = "0"
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
                tdWeight.CssClass = "mLabelCenter"
                tdWeight.Style.Item("width") = "5%"
                Dim txtWeight As New TextBox()
                txtWeight.ID = "txtWeight_" & CleanId(materialCode) & "_" & i.ToString()
                txtWeight.CssClass = "mTextBoxFlat2026"
                txtWeight.Text = "0"
                tdWeight.Controls.Add(txtWeight)
                tr.Cells.Add(tdWeight)

                Dim tdQty As New TableCell()
                tdQty.CssClass = "mLabelCenter"
                tdQty.Style.Item("width") = "5%"
                Dim txtQty As New TextBox()
                txtQty.ID = "txtQty_" & CleanId(materialCode) & "_" & i.ToString()
                txtQty.CssClass = "mTextBoxFlat2026"
                txtQty.Text = "0"
                tdQty.Controls.Add(txtQty)
                tr.Cells.Add(tdQty)
            Next

            Dim tdEisfW As New TableCell()
            tdEisfW.CssClass = "mLabelCenter"
            tdEisfW.Style.Item("width") = "5%"
            Dim txtEisfW As New TextBox()
            txtEisfW.ID = "txtEisfW_" & CleanId(materialCode)
            txtEisfW.CssClass = "mTextBoxFlat2026"
            txtEisfW.Text = "0"
            tdEisfW.Controls.Add(txtEisfW)
            tr.Cells.Add(tdEisfW)

            Dim tdEisfWT As New TableCell()
            tdEisfWT.CssClass = "mLabelCenter"
            tdEisfWT.Style.Item("width") = "5%"
            Dim txtEisfWT As New TextBox()
            txtEisfWT.ID = "txtEisfWT_" & CleanId(materialCode)
            txtEisfWT.CssClass = "mTextBoxFlat2026"
            txtEisfWT.Text = "0"
            tdEisfWT.Controls.Add(txtEisfWT)
            tr.Cells.Add(tdEisfWT)

            Dim tdEisfQ As New TableCell()
            tdEisfQ.CssClass = "mLabelCenter"
            tdEisfQ.Style.Item("width") = "5%"
            Dim txtEisfQ As New TextBox()
            txtEisfQ.ID = "txtEisfQ_" & CleanId(materialCode)
            txtEisfQ.CssClass = "mTextBoxFlat2026"
            txtEisfQ.Text = "0,0004"
            tdEisfQ.Controls.Add(txtEisfQ)
            tr.Cells.Add(tdEisfQ)

            Dim tdEisfQT As New TableCell()
            tdEisfQT.CssClass = "mLabmLabelCenterelCenter"
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

            Dim header As New DataTable
            With header
                .Columns.Add("CreatedBy", GetType(String))
                .Columns.Add("DateSaved", GetType(Date))
                .Columns.Add("DateSent", GetType(Date))
                .Columns.Add("IsSent", GetType(Byte))
                .Columns.Add("IsModif", GetType(Byte))
                .Columns.Add("DateSentPrev", GetType(Date))
                .Columns.Add("IsFinal", GetType(Byte))
                .Columns.Add("Comments", GetType(String))
                .Columns.Add("WeightC", GetType(Decimal))
                .Columns.Add("ContribC", GetType(Decimal))
                .Columns.Add("ChkSymet1", GetType(Byte))
                .Columns.Add("ChkSymet2", GetType(Byte))
                .Columns.Add("ChkSymet3", GetType(Byte))
                .Columns.Add("SenderName", GetType(String))
            End With

            Dim details As New DataTable()
            With details
                .Columns.Add("MaterialCode", GetType(String))
                .Columns.Add("PairNo", GetType(Byte))
                .Columns.Add("WeightValue", GetType(Decimal))
                .Columns.Add("QuantityValue", GetType(Decimal))
            End With

            For Each item As MatrixRowDef In GetMatrixDefinition()
                If item.IsGroupHeader Then
                    for i as Integer =1 to 2
                        Dim dr As DataRow = details.NewRow()
                        Dim rbW As RadioButtonList = CType(QuantityDataA1.FindControl("rbWeightB" & i.ToString & "_" & materialCode), RadioButtonList)
                        If txtWeight IsNot Nothing Then
                            dr("MaterialCode") = materialCode
                            dr("PairNo") = CByte(i)
                            dr("WeightValue") = rbW.SelectedItem.Value
                            details.Rows.Add(dr)
                        end if
                    next
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

            Dim drh As DataRow = header.NewRow()
            drh("CreatedBy") = Session(sSession_UserLogin)
            drh("DateSaved") = Format(DateAndTime.Now, "yyyy-MM-dd")
            drh("DateSent") = DBNull.Value
            drh("IsSent") = DBNull.Value
            drh("IsFinal") = DBNull.Value
            drh("Comments") = txtNotes.Text.Trim
            drh("WeightC") = txtTblC_EisforaA.Text.Trim
            drh("ContribC") = txtTblC_Multiplier.Text.Trim
            drh("ChkSymet1") = IIf(chkSymet1.Checked = True, 1, 0)
            drh("ChkSymet2") = IIf(chkSymet2.Checked = True, 1, 0)
            drh("ChkSymet3") = IIf(chkSymet3.Checked = True, 1, 0)
            drh("SenderName") = txtYR_SenderName.Text.Trim

            If Not (chkNew.Checked) Then
                'modified report
                drh("IsModif") = 1
                'get date of 1st report
                If txtDateSentPrev.Text.Trim <> "" Then
                    drh("DateSentPrev") = Format(CDate(txtDateSentPrev.Text.Trim), "yyyy-MM-dd")
                End If
            End If
            header.Rows.Add(drh)

            Dim matrixId As Integer = SaveMatrix(details, header)

            BuildMatrixTable()

        Catch ex As Exception
            lblError.Text = "Error on Save: " & ex.Message
        End Try
    End Sub

    Private Function ValidateSave() As Integer
        Dim iCId As Integer
        Dim sessionValue As String = TryCast(Session(sSession_CompanyID), String)
        Dim labelValue As String = lblCompanyID.Text

        Try
            If Not Integer.TryParse(If(sessionValue, String.Empty).Trim(), iCId) AndAlso
                Not Integer.TryParse(If(labelValue, String.Empty).Trim(), iCId) Then

                lblError.Text = "Invalid Company Code"
                Return EnumsGlobal.FunctionRes.ErrorResult
            End If

            If iCId <= 0 Then
                lblError.Text = "Invalid Company Code"
                Return EnumsGlobal.FunctionRes.ErrorResult
            End If

            myPageEvents.AddCookie(txtYear.Text, iCId.ToString, Session(sSession_UserLogin))

        Catch ex As Exception

        End Try
    End Function

    Private Function SaveMatrix(details As DataTable, header As DataTable) As Integer
        Dim modif As Integer = 0 'new report
        Dim dateSentPrev As String = String.Empty
        Try
            If ValidateSave() > 0 Then Return -1

            Using con As New SqlConnection(ConfigurationManager.AppSettings("SQL_CONNSTR"))
                Using cmd As New SqlCommand("dbo.spInsertYearlyReportMatrix", con)
                    cmd.CommandType = CommandType.StoredProcedure

                    cmd.Parameters.AddWithValue("@CId", lblCompanyID.Text)
                    cmd.Parameters.AddWithValue("@Year", txtYear.Text)

                    Dim pDetails As SqlParameter = cmd.Parameters.AddWithValue("@Details", details)
                    pDetails.SqlDbType = SqlDbType.Structured
                    pDetails.TypeName = "dbo.YRMatrixDetailType"

                    Dim pHeader As SqlParameter = cmd.Parameters.AddWithValue("@@Header", header)
                    pDetails.SqlDbType = SqlDbType.Structured
                    pDetails.TypeName = "dbo.YRMatrixHeaderType"

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
    Private Function UpdateMatrix(details As DataTable) As Integer
        Try

            Using con As New SqlConnection(ConfigurationManager.AppSettings("SQL_CONNSTR"))
                Using cmd As New SqlCommand("dbo.usp_UpdateMatrix", con)
                    cmd.CommandType = CommandType.StoredProcedure

                    cmd.Parameters.AddWithValue("@CId", lblCompanyID.Text)
                    cmd.Parameters.AddWithValue("@Year", txtYear.Text)

                    If String.IsNullOrWhiteSpace(Session(sSession_UserLogin)) Then
                        cmd.Parameters.AddWithValue("@CreatedBy", DBNull.Value)
                    Else
                        cmd.Parameters.AddWithValue("@CreatedBy", Session(sSession_UserLogin))
                    End If

                    If String.IsNullOrWhiteSpace(txtNotes.Text) Then
                        cmd.Parameters.AddWithValue("@Comments", DBNull.Value)
                    Else
                        cmd.Parameters.AddWithValue("@Comments", txtNotes.Text)
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

            'myPageEvents.AddCookie(txtYear.Text, lblCompanyID.Text, Session(sSession_UserLogin))

            Using con As New SqlConnection(ConfigurationManager.AppSettings("SQL_CONNSTR"))
                con.Open()

                ' Load header
                Using cmdHeader As New SqlCommand("dbo.spGetYearlyReportMatrixHD", con)
                    cmdHeader.CommandType = CommandType.StoredProcedure
                    cmdHeader.Parameters.AddWithValue("@CId", lblCompanyID.Text)
                    cmdHeader.Parameters.AddWithValue("@Year", txtYear.Text)

                    Using rdr As SqlDataReader = cmdHeader.ExecuteReader()
                        If rdr.Read() Then
                            'txtNotes.Text = If(IsDBNull(rdr("YRMH_Comments")), "", rdr("YRMH_Comments").ToString())
                            txtNotes.Text = rdr.GetStringSafe("YRMH_Comments")
                            'lblEtos.Text = If(IsDBNull(rdr("YRMH_Year")), "", rdr("YRMH_Year").ToString())
                            lblEtos.Text = rdr.GetStringSafe("YRMH_Year")
                            Dim d1 = rdr.GetDateSafe("YRMH_DateSaved")
                            lblCDate.Text = If(d1.HasValue, d1.Value.ToShortDateString(), "")

                            '------------TABLE C-----------------
                            txtTblC_EisforaA.Text = rdr.GetDecimalSafe("YRMH_WeightC").ToString("N2")
                            txtTblC_Multiplier.Text = rdr.GetDecimalSafe("YRMH_ContribC").ToString("N2")
                            If txtTblC_Multiplier.Text.Trim = "0" Then
                                txtTblC_Multiplier.Text = System.Configuration.ConfigurationManager.AppSettings("REPORT_TABLE_C_MULTIPLIER")
                            End If

                            '--------SXETIKA ME TI DILWSI--------
                            Dim isModified As Boolean = rdr.GetBoolSafe("YRMH_Modif") 'rdr("YRMH_Modif").ToString() <> "0"

                            chkEdit.Checked = isModified
                            chkNew.Checked = Not isModified
                            chkNew.Enabled = Not isModified
                            txtDateSentPrev.Enabled = isModified

                            If isModified Then
                                'Dim dateSentPrev As String = rdr("YRMH_DateSentPrev").ToString().Trim()

                                'If dateSentPrev = "" Then
                                '    txtDateSentPrev.Text = ""
                                'Else
                                '    txtDateSentPrev.Text = FormatDateTime(CDate(dateSentPrev), DateFormat.ShortDate)
                                'End If
                                Dim d = rdr.GetDateSafe("YRMH_DateSentPrev")
                                txtDateSentPrev.Text = If(d.HasValue, d.Value.ToShortDateString(), "")
                            End If

                            chkSymet1.Checked = rdr.GetBoolSafe("YRMH_ChkSymet1") 'rdr("YRMH_ChkSymet1").ToString().Trim() <> "0"
                            chkSymet2.Checked = rdr.GetBoolSafe("YRMH_ChkSymet2") ' rdr("YRMH_ChkSymet2").ToString().Trim() <> "0"
                            chkSymet3.Checked = rdr.GetBoolSafe("YRMH_ChkSymet3") ' rdr("YRMH_ChkSymet3").ToString().Trim() <> "0"

                            'txtYR_SenderName.Text = If(IsDBNull(rdr("YRMH_SenderName")), "", rdr("YRMH_SenderName").ToString().Trim)
                            txtYR_SenderName.Text = rdr.GetStringSafe("YRMH_SenderName")
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

            sbLoadTableC()

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
