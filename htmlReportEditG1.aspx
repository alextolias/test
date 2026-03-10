<%@ Page Language="VB" MasterPageFile="~/myMasterPage_quote.master" AutoEventWireup="false" MaintainScrollPositionOnPostback="true" 
Inherits="RecycleCoWAP.htmlReportEditG1" title="Καταχώρηση" Codebehind="htmlReportEditG1.aspx.vb" %>
<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.4000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>

<asp:Content ID="quantdeclform" ContentPlaceHolderID="MainContent" Runat="Server">

    <div id="crViewer" style = "border-style: none;">
    </div>
    <div id="yearselection">
    <table width="100%" class="TableDilosi" style="border-style: none;">
        <tr style = "border-style: none;">
            <td class ="TableRowHeaderNar" colspan ="17" style = "border-style: none;">
                <asp:Label ID="lblError" runat="server" BorderColor="White" CssClass="mErrorLabel"></asp:Label>
                <asp:HiddenField ID="hfMatrixId" runat="server"/>
            </td>
        </tr>
        <tr style = "border-style: none;">
            <td class="TableRowHeaderNar" style="width: 10%; border-style: none; font-weight: bold;">Έτος:</td>
            <td class="TableRowHeaderNar" style="width: 40%; border-style: none;">
                <asp:TextBox ID="txtYear" runat="server"  ReadOnly="true" CssClass="mTextBoxFlat" style="font-weight: bold;"></asp:TextBox>
            </td>
            <td class="TableRowHeaderNar" style="width: 10%; border-style: none;"></td>
            <td class="TableRowHeaderNar" style="width: 10%; border-style: none;"></td>
            <td class="TableRowHeaderNar" style="width: 10%; border-style: none;"></td>
            <td class="TableRowHeaderNar" style="width: 10%; border-style: none;"></td>
            <td class="TableRowHeaderNar" style="width: 10%; border-style: none;"></td>
            <td class="TableRowHeaderNar" style="width: 10%; border-style: none;"></td>
            <%--<td class="TableRowHeaderNar" style="width: 80%; border-style: none;"></td>--%>
<%--            <td class="mLabelTable" style="width: 40%; border-style: none;" align="right" >
                <asp:Button ID="btnRetrieve" runat="server" CssClass="mButton" style = "vertical-align: middle;margin-bottom: 0px"
                    TabIndex="9" Text="Ανάκτηση Δεδομένων " Width="60%" Font-Bold="True" />
            </td>--%>
        </tr>
    </table>
    </div>
    <div id="companydata">
        <table width="100%" class="TableDilosi">
            <tr>
                <th colspan="4" style="height: 24px;" class= "TableHeaderS">Στοιχεία Διαχειριστή</th>
            </tr>
            <tr>
                <td class="TableRowHeader" style="width: 25%;">Έτος Αναφοράς:</td>
                <td class="mLabelTable" style="width: 25%;">
                    <asp:Label ID="lblEtos" runat="server" CssClass="mLabelTableGrid" Text='<%# eval("PrdCode") %>'></asp:Label>
                </td>
                <td class="TableRowHeader" style="width: 25%;">Ημερομηνία Υποβολής:</td>
                <td class="auto-style1">
                    <asp:Label id="lblCDate" runat="server" Text='<%# eval("PrdCode") %>' CssClass="mLabelTableGrid"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="TableRowHeader" 
                    style="width: 25%;">Επωνυμία:</td>
                <td colspan="3" class="mLabelTable">
                    <asp:Label id="lblCompanyName" runat="server" Text='<%# eval("PrdCode") %>' CssClass="mLabelTableGrid"></asp:Label>
                    <asp:Label id="lblCompanyID" runat="server" Text='<%# eval("PrdCode") %>' CssClass="mLabelTableGrid" Visible="false"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="TableRowHeader" style="width: 25%;">Διεύθυνση:</td>
                <td colspan="3" class="mLabelTable">
                    <asp:Label id="lblAdrress" runat="server" Text='<%# eval("PrdCode") %>' CssClass="mLabelTableGrid"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="TableRowHeader" style="width: 25%;">Τηλέφωνο:</td>
                <td class="mLabelTable" style="width: 25%;">
                    <asp:Label id="lblTel" runat="server" Text='<%# eval("PrdCode") %>' CssClass="mLabelTableGrid"></asp:Label>
                </td>
                <td class="TableRowHeader" style="width: 25%;">Fax:</td>
                <td class="auto-style1">
                    <asp:Label id="lblFax" runat="server" Text='<%# eval("PrdCode") %>' CssClass="mLabelTableGrid"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="TableRowHeader" style="width: 25%;">Email:</td>
                <td colspan="3" class="mLabelTable">
                    <asp:Label id="lblEmail" runat="server" Text='<%# eval("PrdCode") %>' CssClass="mLabelTableGrid"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="TableRowHeader" style="width: 25%;">Α.Φ.Μ.:</td>
                <td class="mLabelTable" style="width: 25%;">
                    <asp:Label id="lblAFM" runat="server" Text='<%# eval("PrdCode") %>' CssClass="mLabelTableGrid"></asp:Label>
                </td>
                <td class="TableRowHeader" style="width: 25%;">ΔΟΥ:</td>
                <td class="auto-style1">
                    <asp:Label id="lblDOY" runat="server" Text='<%# eval("PrdCode") %>' CssClass="mLabelTableGrid"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="TableRowHeader" style="width: 25%;">Κωδικός Σύμβασης:</td>
                <td class="mLabelTable" style="width: 25%;">
                    <asp:Label id="lblKodikosSimvasi" runat="server" Text='<%# eval("PrdCode") %>' CssClass="mLabelTableGrid"></asp:Label>
                </td>
                <td class="TableRowHeader" style="width: 25%;">Υπεύθυνος Επικοινωνίας:</td>
                <td class="auto-style1">
                    <asp:Label id="lblYpeuthinos" runat="server" Text='<%# eval("PrdCode") %>' CssClass="mLabelTableGrid"></asp:Label>
                </td>
            </tr>
        </table>
    </div>
    <div id="space" style="width: 800px; height:20px"></div>
    <div id="QuantityData">
            <table width="100%" id="QuantityDataA" class="TableDilosi">
<%--            <tr>
                <th colspan="1" rowspan="3" style="width: 15%;" class= "TableHeader2026">Είδος Συσκευασιών που διατέθηκαν στην Αγορά</th>
                <th colspan="4" style="width: 20%;" class= "TableHeader2026">Συσκευασίες Μίας Χρήσης</th>
                <th colspan="8" style="width: 45%;" class= "TableHeader2026">Επαναχρησιμοποιήσιμες Συσκευασίες</th>
                <th colspan="4" rowspan="2" style="width: 20%;" class= "TableHeader2026">ΧΡΗΜΑΤΙΚΗ ΕΙΣΦΟΡΑ</th>
            </tr>
           <tr>
                <th colspan="2" rowspan="2" style="width: 10%;" class= "TableHeader2026">Πρωτογενείς Συσκευασίες (Συσκευασίες προς Πώληση)</th>
                <th colspan="2" rowspan="2" style="width: 10%;" class= "TableHeader2026">Δευτερογενείς Συσκευασίες (Ομαδοποιημένες Συσκευασίες) /Τριτογενείς Συσκευασίες (Συσκευασίες Μεταφοράς)</th>
                <th colspan="4" style="width: 20%;" class= "TableHeader2026">Πρωτογενείς Συσκευασίες (Συσκευασίες προς Πώληση)</th>
                <th colspan="4" style="width: 20%;" class= "TableHeader2026">Δευτερογενείς Συσκευασίες (Ομαδοποιημένες Συσκευασίες) / Τριτογενείς Συσκευασίες (Συσκευασίες Μεταφοράς)</th>
            </tr>
             <tr>
                <th colspan="2" style="width: 10%;" class= "TableHeader2026">Διατέθηκαν Πρώτη φορά στην Αγορά</th>
                <th colspan="2" style="width: 10%;" class= "TableHeader2026">Σύνολο που διατέθηκε στην Αγορά</th>
                <th colspan="2" style="width: 10%;" class= "TableHeader2026">Διατέθηκαν Πρώτη φορά στην Αγορά</th>
                <th colspan="2" style="width: 10%;" class= "TableHeader2026">Σύνολο που διατέθηκε στην Αγορά</th>
                <th style="width: 10%;" class= "TableHeader2026">ΟΡΙΣΜΕΝΗ ΕΙΣΦΟΡΑ ΒΑΡΟΥΣ / ΥΛΙΚΟ ΣΥΣΚ.</th>
                <th style="width: 10%;" class= "TableHeader2026">ΣΥΝΟΛΙΚΗ ΕΙΣΦΟΡΑ ΒΑΡΟΥΣ / ΥΛΙΚΟ ΣΥΣΚ.</th>
                <th style="width: 10%;" class= "TableHeader2026">ΟΡΙΣΜΕΝΗ (ΣΤΑΘΕΡΗ) ΕΙΣΦΟΡΑ / ΤΕΜΑΧΙΟ</th>
                <th style="width: 10%;" class= "TableHeader2026">ΣΥΝΟΛΙΚΗ ΕΙΦΟΡΑ ΤΕΜΑΧΙΩΝ / ΥΛΙΚΟ ΣΥΣΚ.</th>
            </tr>
             <tr>
                <th style="width: 10%;" class= "TableRowHeader2026">Υλικό Συσκευασίας</th>
                <th style="width: 10%;" class= "TableRowHeader2026">Βάρος συσκ.(kg)</th>
                <th style="width: 10%;" class= "TableRowHeader2026">Τεμάχια συσκ.</th>
                <th style="width: 10%;" class= "TableRowHeader2026">Βάρος συσκ.(kg)</th>
                <th style="width: 10%;" class= "TableRowHeader2026">Τεμάχια συσκ.</th>
                <th style="width: 10%;" class= "TableRowHeader2026">Βάρος συσκ.(kg)</th>
                <th style="width: 10%;" class= "TableRowHeader2026">Τεμάχια συσκ.</th>
                <th style="width: 10%;" class= "TableRowHeader2026">Βάρος συσκ.(kg)</th>
                <th style="width: 10%;" class= "TableRowHeader2026">Τεμάχια συσκ.</th>
                <th style="width: 10%;" class= "TableRowHeader2026">Βάρος συσκ.(kg)</th>
                <th style="width: 10%;" class= "TableRowHeader2026">Τεμάχια συσκ.</th>
                <th style="width: 10%;" class= "TableRowHeader2026">Βάρος συσκ.(kg)</th>
                <th style="width: 10%;" class= "TableRowHeader2026">Τεμάχια συσκ.</th>
                <th style="width: 10%;" class= "TableRowHeader2026">Εισφορά</th>
                <th style="width: 10%;" class= "TableRowHeader2026">Επιμέρους Εισφορά</th>
                <th style="width: 10%;" class= "TableRowHeader2026">Σταθερή Εισφορά (€/τμχ.)</th>
                <th style="width: 10%;" class= "TableRowHeader2026">Επιμέρους Εισφορά</th>
            </tr>--%>
        <asp:Table ID="QuantityDataA1" runat="server" CssClass="TableDilosi"></asp:Table>
<%--        <asp:Label ID="lblMessage" runat="server" class="TableRowHeader2026" style="width: 10%;"></asp:Label>--%>
        </table>
        <table width="100%" id="QuantityDataB" class="TableDilosi">
            <tr>
                <td colspan="3" class="TableRowTotals" style="width: 40%; vertical-align: middle;">Συνολική Εισφορά Α</td>
                <td class="mLabelCenter" style="width: 15%; ">
                    <asp:TextBox ID="txtSumTableA" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False" style="font-weight: bold;"></asp:TextBox>
                </td>
                <td colspan="2" class="TableRowTotals" style="width: 20%; vertical-align: middle;">Συνολική Εισφορά B</td>
                <td class="mLabelCenter" style="width: 15%; ">
                    <asp:TextBox ID="txtSumTableB" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False" style="font-weight: bold;"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td colspan="2" class="TableRowTotals" style="width: 50%; vertical-align: middle;">Συνολική Εισφορά (Α+Β)</td>
                <td class="mLabelCenter" style="width: 25%; ">
                    <asp:TextBox ID="txtSumTable_AB" runat="server" CssClass="mTextBoxFlat mTextBox90" TabIndex="3" Enabled="False" style="font-weight: bold;"></asp:TextBox>
                </td>
            </tr>
        </table>
        <table width="100%" id="QuantityDataC" class="TableDilosi">
            <tr>
                <th colspan="3" style="width: 100%;" class= "TableHeaderS">Γ. Εισφορά βάσει Τέλους Συμμετοχής (entrance fee)</th>
            </tr>
            <tr>
                <td class="TableColHeader" style="width: 25%; vertical-align: middle;">Συνολική εισφορά Α (€)</td>
                <td class="TableColHeader" style="width: 25%; vertical-align: middle;"></td>
                <td class="TableColHeader" style="width: 25%; vertical-align: middle;">Επιμέρους Εισφορά (€)</td>
            </tr>
            <tr>
                <td class="mLabelCenter" style="width: 25%; ">

                    <asp:TextBox ID="txtTblC_EisforaA" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%; ">
                    <asp:Label id="lblTblC_Multiplier" runat="server" Text='X' CssClass="mLabelTableGrid" Width="25px" Font-Bold="True" Font-Names="Verdana" ForeColor="Black" Height="25px" style="margin-top: 0px" ></asp:Label>
                    <asp:TextBox ID="txtTblC_Multiplier" runat="server" CssClass="mTextBoxFlat" Width="50px" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%; ">
                    <asp:TextBox ID="txtTblC_EpimEisfora" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td colspan="2" class="TableRowTotals" style="width: 75%; vertical-align: middle;">Συνολική Εισφορά Γ</td>
                <td class="mLabelCenter" style="width: 25%; ">
                    <asp:TextBox ID="txtSumTableC" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False" style="font-weight: bold; width: 60%;"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td colspan="2" class="TableRowTotals" style="width: 75%; vertical-align: middle;">Συνολική Εισφορά (Α+Β+Γ)</td>
                <td class="mLabelCenter" style="width: 25%; ">
                    <asp:TextBox ID="txtSumTable_ABC" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False" style="font-weight: bold; width: 60%;"></asp:TextBox>
                </td>
            </tr>
        </table>
    </div>
    <div id="space2" style="width: 800px; height:20px"></div>
    <div id="aboutdecl">
        <table width="100%" class="TableDilosi">
            <tr>
                <th colspan="3" style="width: 100%; height: 24px;" class= "TableHeaderS">Σχετικά με τη δήλωση</th>
            </tr>
            <tr>
                <td rowspan="2" class="TableRowHeader" style="width: 20%;">Αυτή η δήλωση είναι:</td>
                <td class="TableRowHeader" style="width: 40%; ">1. Καινούρια δήλωση
                    <asp:CheckBox ID="chkNew" runat="server" AutoPostBack="True" Checked="True" />
                </td>
                <td class="TableRowHeader" style="width: 40%;">2. Τροποποίηση δήλωσης
                    <asp:CheckBox ID="chkEdit" runat="server" AutoPostBack="True" />
                </td>
            </tr>
            <tr>
                <td colspan="2" class="TableRowHeader" style="width: 80%;">Στην περίπτωση (2) αναφέρετε την ημερομηνία της προηγούμενης δήλωσης 
                    <asp:TextBox ID="txtDateSentPrev" runat="server" CssClass="mTextBoxFlat"></asp:TextBox>(ηη/μμ/εεεε)
                    </td>
            </tr>
            <tr>
                <td colspan="3" class="TableRowHeader" style="width: 100%;">Πρόσθετες παρατηρήσεις:
                    <asp:TextBox ID="txtNotes" runat="server" CssClass="mTextBoxFlat" Width="95%" TextMode="MultiLine" Height="50px" Rows="5" TabIndex="3" 
                        style="font-weight: bold; padding:10px"></asp:TextBox>
                </td>
            </tr>
        </table>
    </div>
    <div id="checkboxarea">
        <table width="100%" class="TableDilosi">
            <colgroup>
                <col style="width:30%; vertical-align: middle;"/>
                <col style="width:70%; vertical-align: middle;"/>
            </colgroup>
            <tr>
                <th colspan="2" style="width: 100%; height: 24px;" class= "TableHeaderS">Συμμετοχή σε εγκεκριμένο Σύστημα Εναλλακτικής Διαχείρισης Συσκευασιών</th>
            </tr>
            <tr>
                <td rowspan="3" class="TableRowHeader" style="width:30%;">Η εταιρία δηλώνει υπεύθυνα ότι:</td>
                <td class="TableRowHeader" style="width:70%;">1. Έχει υπογράψει σύμβαση συνεργασίας με εγκεκριμένο Σύστημα Εναλλακτικής Διαχείρισης Συσκευασιών
                    <asp:CheckBox ID="chkSymet1" runat="server" Checked="True" />
                </td>
            </tr>
            <tr>
                <td class="TableRowHeader" style="width:70%;">2. Είναι η πρώτη φορά που υπογράφει σύμβαση συνεργασίας με εγκεκριμένο Σύστημα Εναλλακτικής Διαχείρισης Συσκευασιών
                    <asp:CheckBox ID="chkSymet2" runat="server"/>
                </td>
            </tr>
            <tr>
                <td class="TableRowHeader" style="width:70%;">3. Είναι το πρώτο έτος που η εταιρία έχει υποχρέωση να συμβληθεί με εγκεκριμένο Σύστημα Εναλλακτικής Διαχείρισης Συσκευασιών
                    <asp:CheckBox ID="chkSymet3" runat="server"/>
                </td>
            </tr>
        </table>
    </div>
    <div id="space3" style="width: 800px; height:20px"></div>
    <div>
        <table width="100%" class="TableDilosi">
        <tr>
            <td class="TableRowHeader" style="width: 50%; text-align:center; font-weight:bold;">Ονοματεπώνυμο Εκπροσώπου Εταιρίας που συμπλήρωσε την Ετήσια Δήλωση *</td>
            <td class="mLabelTable" style="width: 50%;">
                <asp:TextBox ID="txtYR_SenderName" runat="server" CssClass="mTextBoxFlat" Width="90%" Height="40px" Rows="5" TabIndex="3" 
                    style="font-weight: bold; padding:10px"></asp:TextBox>
            </td>
        </tr>
        </table>
    </div>
    <div id="space4" style="width: 800px; height:40px"></div>
    <div id="buttonarea">
        <table width="100%" class="TableDilosi"> 
            <tr> 
            <td>
                <asp:Button ID="btnCalculations" runat="server" CssClass="mButton" style = "vertical-align: middle;margin-bottom: 0px"
                    TabIndex="9" Text="Υπολογισμός Συνόλων" Width="80%" Font-Bold="True" />
<%--                 <% #If DEBUG Then %>
	                <asp:Button ID="btnTestData" runat="server" CssClass="mButton" style = "vertical-align: middle;margin-bottom: 0px"
		                TabIndex="9" Text="Test Data" Width="30%" Font-Bold="True" />
                 <% #End If %>--%>
            </td>
            <td>
                <asp:Button ID="btnSave" runat="server" CssClass="mButton" style = "vertical-align: middle;margin-bottom: 0px"
                    TabIndex="9" Text="Αποθήκευση Δεδομένων" Width="80%" Font-Bold="True" />
            </td>
            <td>
                <asp:HyperLink ID="hlSend" runat="server" CssClass="mButton" style = "vertical-align: middle;margin-bottom: 0px"
                TabIndex="9" Text="Αποστολή Δήλωσης" Width="80%" Font-Bold="True" Target="_blank" ></asp:HyperLink>
            </td>
        </tr>
        </table>
    </div>
</asp:Content>
<asp:Content ID="Content1" runat="server" contentplaceholderid="ContentHead">
    <style type="text/css">
        .auto-style1 {
            background : transparent;
            font-family: 'Open Sans', 'Verdana';
            font-size : small;
            color: rgb(54, 104, 54);
            text-align: left;
            vertical-align: middle;
            width: 52%;
        }
    </style>
</asp:Content>

