<%@ Page Language="VB" MasterPageFile="~/myMasterPage_quote.master" AutoEventWireup="false" MaintainScrollPositionOnPostback="true" 
Inherits="RecycleCoWAP.htmlReportEditG" title="Καταχώρηση" Codebehind="htmlReportEditG.aspx.vb" %>
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
                <th colspan="4" style="height: 24px;" class= "TableHeader">Στοιχεία Διαχειριστή</th>
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
        <%--<table width="100%" id="MarketData1" class="TableDilosi">
            <tr>
                <th colspan="2" style="width: 100%;" class= "TableHeader">Είδος Συσκευασιών που διατέθηκαν στην Αγορά</th>
            </tr>
            <tr>
                <td class="TableColHeaderB" style="width: 50%; vertical-align: middle;">Συσκευασίες Μίας Χρήσης</td>
                <td  class="TableColHeaderB" style="width: 50%; vertical-align: middle;">Επαναχρησιμοποιήσιμες Συσκευασίες</td>
            </tr>
            <tr>
                <td  class="TableColHeader" style="width: 50%; vertical-align: middle;">Τεμάχια συσκευασιών</td>
                <td  class="TableColHeader" style="width: 50%; vertical-align: middle;">Τεμάχια συσκευασιών</td>
            </tr>
            <tr>
                <td  class="mLabelCenter" style="width: 50%;">
                    <asp:TextBox ID="txtOneUseSysk" runat="server" CssClass="mTextBoxFlatC" TabIndex="3"></asp:TextBox>
                </td>
                <td  class="mLabelCenter" style="width: 50%;">
                    <asp:TextBox ID="txtMultiUseSysk" runat="server" CssClass="mTextBoxFlatC" TabIndex="3"></asp:TextBox>
                </td>
            </tr>
            </table>--%>
        <%--<table width="100%" id="MarketData2" class="TableDilosi">
            <tr>
                <td class="TableColHeaderB" style="width: 33%; vertical-align: middle;">Πρωτογενείς Συσκευασίες (Συσκευασίες προς Πώληση)</td>
                <td class="TableColHeaderB" style="width: 33%; vertical-align: middle;">Δευτερογενείς Συσκευασίες (Ομαδοποιημένες Συσκευασίες)</td>
                <td class="TableColHeaderB" style="width: 33%; vertical-align: middle;">Τριτογενείς Συσκευασίες (Συσκευασίες Μεταφοράς)</td>
            </tr>
            <tr>
                <td  class="TableColHeader" style="width: 50%; vertical-align: middle;">Τεμάχια συσκευασιών</td>
                <td  colspan="2" class="TableColHeader" style="width: 50%; vertical-align: middle;">Τεμάχια συσκευασιών</td>
            </tr>
            <tr>
                <td  class="mLabelCenter" style="width: 50%;">
                    <asp:TextBox ID="txtPrimarySysk" runat="server" CssClass="mTextBoxFlatC" TabIndex="3"></asp:TextBox>
                </td>
                <td  colspan="2" class="mLabelCenter" style="width: 50%;">
                    <asp:TextBox ID="txtSecondarySysk" runat="server" CssClass="mTextBoxFlatC" TabIndex="3"></asp:TextBox>
                </td>
            </tr>
            </table>--%>
            <table width="100%" id="QuantityDataA" class="TableDilosi">
            <tr>
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
            </tr>
            <tr>
                <td class="TableRowHeader2026" style="width: 10%; ">ΓΥΑΛΙ</td>
                <td class="mLabelCenter" style="width: 100%;">
                    <asp:TextBox ID="TextBox1" runat="server" ReadOnly="true" CssClass="mTextBoxFlat2026" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 100%;">
                    <asp:TextBox ID="TextBox2" runat="server" ReadOnly="true" CssClass="mTextBoxFlat2026" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 10%;">
                    <asp:TextBox ID="TextBox3" runat="server" ReadOnly="true" CssClass="mTextBoxFlat2026" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 10%;">
                    <asp:TextBox ID="TextBox4" runat="server" ReadOnly="true" CssClass="mTextBoxFlat2026" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 10%;">
                    <asp:TextBox ID="TextBox5" runat="server" ReadOnly="true" CssClass="mTextBoxFlat2026" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 10%;">
                    <asp:TextBox ID="TextBox6" runat="server" ReadOnly="true" CssClass="mTextBoxFlat2026" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 10%;">
                    <asp:TextBox ID="TextBox7" runat="server" ReadOnly="true" CssClass="mTextBoxFlat2026" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 10%;">
                    <asp:TextBox ID="TextBox8" runat="server" ReadOnly="true" CssClass="mTextBoxFlat2026" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 10%;">
                    <asp:TextBox ID="TextBox9" runat="server" ReadOnly="true" CssClass="mTextBoxFlat2026" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 10%;">
                    <asp:TextBox ID="TextBox10" runat="server" ReadOnly="true" CssClass="mTextBoxFlat2026" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 10%;">
                    <asp:TextBox ID="TextBox11" runat="server" ReadOnly="true" CssClass="mTextBoxFlat2026" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 10%;">
                    <asp:TextBox ID="TextBox12" runat="server" ReadOnly="true" CssClass="mTextBoxFlat2026" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 10%;">
                    <asp:TextBox ID="TextBox13" runat="server" ReadOnly="true" CssClass="mTextBoxFlat2026" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 10%;">
                    <asp:TextBox ID="TextBox14" runat="server" ReadOnly="true" CssClass="mTextBoxFlat2026" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 10%;">
                    <asp:TextBox ID="TextBox15" runat="server" ReadOnly="true" CssClass="mTextBoxFlat2026" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 10%;">
                    <asp:TextBox ID="TextBox16" runat="server" ReadOnly="true" CssClass="mTextBoxFlat2026" TabIndex="3"></asp:TextBox>
                </td>
            </tr>
<%--            <tr>
                <th colspan="4" style="width: 60%;" class= "TableHeader">Α. Εισφορά βάσει Βάρους Συσκευασιών</th>
                <th colspan="3" style="width: 40%;" class= "TableHeader">Β. Σταθερή Εισφορά βάσει Αριθμού Συσκευασιών</th>
            </tr>
            <tr>
                <td class="TableColHeader" style="width: 25%; vertical-align: middle;">Υλικό Συσκευασίας</td>
                <td class="TableColHeader" style="width: 25%; vertical-align: middle;">Βάρος συσκευασιών (kg)</td>
                <td class="TableColHeader" style="width: 25%; vertical-align: middle;">Εισφορά (€/tn)</td>
                <td class="TableColHeader" style="width: 25%; vertical-align: middle;">Επιμέρους Εισφορά (€)</td>
                <td class="TableColHeader" style="width: 25%; vertical-align: middle;">Τεμάχια συσκευασιών (τμχ.)</td>
                <td class="TableColHeader" style="width: 25%; vertical-align: middle;">Σταθερή Εισφορά (€/τμχ.)</td>
                <td class="TableColHeader" style="width: 25%; vertical-align: middle;">Επιμέρους Εισφορά (€)</td>
            </tr>
            <tr>
                <td class="TableRowHeader" style="width: 25%;"><b>ΓΥΑΛΙ</b></td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA6" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribA6" runat="server" ReadOnly="true" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA6_EE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB19" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribB19" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB19_TE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="TableRowHeader" style="width: 25%;"><b>ΑΛΟΥΜΙΝΙΟ</b></td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA4" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribA4" runat="server" ReadOnly="true" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA4_EE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB17" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribB17" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB17_TE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="TableRowHeader" style="width: 25%;"><b>ΞΥΛΟ</b></td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA7" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribA7" runat="server" ReadOnly="true" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA7_EE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB20" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribB20" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB20_TE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td colspan="7" class="TableRowHeader" style="width: 25%; text-align:center;"><b>ΧΑΡΤΙ / ΧΑΡΤΟΝΙ</b></td>
                <td class="mLabelCenter" style="width: 25%;"></td>
                <td class="mLabelCenter" style="width: 25%;"></td>
                <td class="mLabelCenter" style="width: 25%;"></td>
            </tr>
            <tr>
                <td class="TableRowHeader" style="width: 25%; ">Χαρτί/χαρτόνι μεταφοράς</td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA2" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribA2" runat="server" ReadOnly="true" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA2_EE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB2" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribB2" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB2_TE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="TableRowHeader" style="width: 25%; ">Λοιπό χαρτί/χαρτόνι</td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA9" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribA9" runat="server" ReadOnly="true" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA9_EE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB4" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribB4" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB4_TE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="TableRowHeader" style="width: 25%;"><b>ΣΙΔΗΡΟΥΧΑ ΜΕΤΑΛΛΑ</b></td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA5" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribA5" runat="server" ReadOnly="true" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA5_EE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB18" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribB18" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB18_TE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="TableRowHeader" style="width: 25%;"><b>ΑΛΛΕΣ ΣΥΣΚΕΥΑΣΙΕΣ</b></td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA17" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribA17" runat="server" ReadOnly="true" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA17_EE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB16" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribB16" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB16_TE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td colspan="7" class="TableRowHeader" style="width: 25%; text-align:center;"><b>ΠΛΑΣΤΙΚO</b></td>
                <td class="mLabelCenter" style="width: 25%;"></td>
                <td class="mLabelCenter" style="width: 25%;"></td>
                <td class="mLabelCenter" style="width: 25%;"></td>
            </tr>
            <tr>
                <td colspan="7" class="TableRowHeader" style="width: 25%; text-align:center;"><b>Πλαστικό από πολυτερεφθαλικό αιθυλένιο (PET)</b></td>
                <td class="mLabelCenter" style="width: 25%;"></td>
                <td class="mLabelCenter" style="width: 25%;"></td>
                <td class="mLabelCenter" style="width: 25%;"></td>
            </tr>
            <tr>
                <td class="TableRowHeader" style="width: 25%;">Συσκευασίες από PET > 100μm</td>
                <td class="mLabelCenter" style="width: 20%;">
                    <asp:TextBox ID="YR_WeightA32" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 20%;">
                    <asp:TextBox ID="YR_ContribA32" runat="server" ReadOnly="true" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 20%;">
                    <asp:TextBox ID="YR_WeightA32_EE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 15%;">
                    <asp:TextBox ID="YR_WeightB5" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 15%;">
                    <asp:TextBox ID="YR_ContribB5" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 15%;">
                    <asp:TextBox ID="YR_WeightB5_TE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="TableRowHeader" style="width: 25%;">Συσκευασίες από PET - πολύ λεπτές <100 μm</td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA30" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribA30" runat="server" ReadOnly="true" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA30_EE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB30" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribB30" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB30_TE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="TableRowHeader" style="width: 25%;">Συσκευασίες από PET > 100μm που περιέχουν > 25% ανακυκλωμένο υλικό</td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA33" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribA33" runat="server" ReadOnly="true" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA33_EE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB33" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribB33" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB33_TE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="TableRowHeader" style="width: 25%;">Συσκευασίες από PET <100μm που περιέχουν > 25% ανακυκλωμένο υλικό</td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA31" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribA31" runat="server" ReadOnly="true" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA31_EE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB31" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribB31" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB31_TE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td colspan="7" class="TableRowHeader" style="width: 25%; text-align:center;"><b>Πλαστικό από πολυπροπυλένιο (PP)</b></td>
                <td class="mLabelCenter" style="width: 25%;"></td>
                <td class="mLabelCenter" style="width: 25%;"></td>
                <td class="mLabelCenter" style="width: 25%;"></td>
            </tr>
            <tr>
                <td class="TableRowHeader" style="width: 25%;">Συσκευασίες από PP>100μm</td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA46" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribA46" runat="server" ReadOnly="true" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA46_EE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB7" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribB7" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB7_TE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="TableRowHeader" style="width: 25%;">Συσκευασίες από PP πολύ λεπτές <100μm</td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA44" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribA44" runat="server" ReadOnly="true" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA44_EE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB44" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribB44" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB44_TE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="TableRowHeader" style="width: 25%;">Συσκευασίες από PP>100μm που περιέχουν > 25% ανακυκλωμένο υλικό</td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA47" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribA47" runat="server" ReadOnly="true" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA47_EE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB47" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribB47" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB47_TE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="TableRowHeader" style="width: 25%;">Συσκευασίες από PP πολύ λεπτές <100μm που περιέχουν > 25% ανακυκλωμένο υλικό</td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA45" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribA45" runat="server" ReadOnly="true" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA45_EE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB45" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribB45" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB45_TE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td colspan="7" class="TableRowHeader" style="width: 25%; text-align:center;"><b>Πλαστικό από πολυαιθυλένιο (PE)</b></td>
                <td class="mLabelCenter" style="width: 25%;"></td>
                <td class="mLabelCenter" style="width: 25%;"></td>
                <td class="mLabelCenter" style="width: 25%;"></td>
            </tr>
            <tr>
                <td class="TableRowHeader" style="width: 25%;">Συσκευασίες από PE > 100μm</td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA39" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribA39" runat="server" ReadOnly="true" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA39_EE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB9" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribB9" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB9_TE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="TableRowHeader" style="width: 25%;">Συσκευασίες από PE πολύ λεπτές < 100μm</td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA37" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribA37" runat="server" ReadOnly="true" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA37_EE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB37" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribB37" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB37_TE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="TableRowHeader" style="width: 25%;">Συσκευασίες από PE > 100μm που περιέχουν > 25% ανακυκλωμένο υλικό</td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA40" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribA40" runat="server" ReadOnly="true" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA40_EE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB40" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribB40" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB40_TE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="TableRowHeader" style="width: 25%;">Συσκευασίες από PE <100μm που περιέχουν > 25% ανακυκλωμένο υλικό</td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA38" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribA38" runat="server" ReadOnly="true" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA38_EE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB38" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribB38" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB38_TE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td colspan="7" class="TableRowHeader" style="width: 25%; text-align:center;"><b>Πλαστικό από πολυστυρένιο (PS)</b></td>
                <td class="mLabelCenter" style="width: 25%;"></td>
                <td class="mLabelCenter" style="width: 25%;"></td>
                <td class="mLabelCenter" style="width: 25%;"></td>
            </tr>
            <tr>
                <td class="TableRowHeader" style="width: 25%;">Συσκευασίες από PS >100μm</td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA54" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribA54" runat="server" ReadOnly="true" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA54_EE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB10" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribB10" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB10_TE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="TableRowHeader" style="width: 25%;">Συσκευασίες από PS πολύ λεπτές <100μm</td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA52" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribA52" runat="server" ReadOnly="true" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA52_EE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB52" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribB52" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB52_TE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="TableRowHeader" style="width: 25%;">Συσκευασίες από PS >100μm που περιέχουν > 25% ανακυκλωμένο υλικό</td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA55" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribA55" runat="server" ReadOnly="true" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA55_EE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB55" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribB55" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB55_TE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="TableRowHeader" style="width: 25%;">Συσκευασίες από PS πολύ λεπτές <100μm που περιέχουν > 25% ανακυκλωμένο υλικό</td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA53" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribA53" runat="server" ReadOnly="true" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA53_EE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB53" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribB53" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB53_TE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td colspan="7" class="TableRowHeader" style="width: 25%; text-align:center;"><b>Πλαστικό από διογκωμένο πολυστυρένιο</b></td>
                <td class="mLabelCenter" style="width: 25%;"></td>
                <td class="mLabelCenter" style="width: 25%;"></td>
                <td class="mLabelCenter" style="width: 25%;"></td>
            </tr>
            <tr>
                <td class="TableRowHeader" style="width: 25%;">Συσκευασίες από διογκωμένο πολυστυρένιο > 100μm</td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA69" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribA69" runat="server" ReadOnly="true" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA69_EE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
				<td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB69" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribB69" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB69_TE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="TableRowHeader" style="width: 25%;">Συσκευασίες από διογκωμένο πολυστυρένιο πολύ λεπτές <100μm</td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA56" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribA56" runat="server" ReadOnly="true" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA56_EE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
				<td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB56" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribB56" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB56_TE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="TableRowHeader" style="width: 25%;">Συσκευασίες από διογκωμένο πολυστυρένιο > 100μm, που περιέχουν > 25% ανακυκλωμένο υλικό</td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA70" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribA70" runat="server" ReadOnly="true" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA70_EE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
				<td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB70" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribB70" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB70_TE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="TableRowHeader" style="width: 25%;">Συσκευασίες από διογκωμένο πολυστυρένιο πολύ λεπτές <100μm, που περιέχουν > 25% ανακυκλωμένο υλικό</td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA71" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribA71" runat="server" ReadOnly="true" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA71_EE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
				<td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB71" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribB71" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB71_TE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td colspan="7" class="TableRowHeader" style="width: 25%; text-align:center;"><b>Πλαστικό από άλλο πολυμερές (PO)</b></td>
                <td class="mLabelCenter" style="width: 25%;"></td>
                <td class="mLabelCenter" style="width: 25%;"></td>
                <td class="mLabelCenter" style="width: 25%;"></td>
            </tr>
            <tr>
                <td class="TableRowHeader" style="width: 25%;">Συσκευασίες από πλαστικό από άλλο πολυμερές (PO) >100μm</td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA50" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribA50" runat="server" ReadOnly="true" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA50_EE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB14" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribB14" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB14_TE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="TableRowHeader" style="width: 25%;">Συσκευασίες από πλαστικό από άλλο πολυμερές (PO) πολύ λεπτές <100μm</td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA48" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribA48" runat="server" ReadOnly="true" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA48_EE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB48" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribB48" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB48_TE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="TableRowHeader" style="width: 25%;">Συσκευασίες από πλαστικό από άλλο πολυμερές (PO) >100μm που περιέχουν > 25% ανακυκλωμένο υλικό</td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA51" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribA51" runat="server" ReadOnly="true" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA51_EE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB51" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribB51" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB51_TE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="TableRowHeader" style="width: 25%;">Συσκευασίες από πλαστικό από άλλο πολυμερές (PO) πολύ λεπτές <100μm που περιέχουν > 25% ανακυκλωμένο υλικό</td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA49" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribA49" runat="server" ReadOnly="true" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA49_EE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB49" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribB49" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB49_TE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td colspan="7" class="TableRowHeader" style="width: 25%; text-align:center;"><b>Πολυστρωματικά πλαστικά με περισσότερα του ενός πολυμερή ή πλαστικά από ετικέτες από PVC</b></td>
                <td class="mLabelCenter" style="width: 25%;"></td>
                <td class="mLabelCenter" style="width: 25%;"></td>
                <td class="mLabelCenter" style="width: 25%;"></td>
            </tr>
            <tr>
                <td class="TableRowHeader" style="width: 25%;">Συσκευασίες από πολυστρωματικά πλαστικά με περισσότερα του ενός πολυμερή ή πλαστικά με ετικέτες από PVC >100μm</td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA63" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribA63" runat="server" ReadOnly="true" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA63_EE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
				<td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB63" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribB63" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB63_TE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="TableRowHeader" style="width: 25%;">Συσκευασίες από πολυστρωματικά πλαστικά με περισσότερα του ενός πολυμερή ή πλαστικά με ετικέτες από PVC – πολύ λεπτές <100μm</td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA61" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribA61" runat="server" ReadOnly="true" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA61_EE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
				<td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB61" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribB61" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB61_TE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="TableRowHeader" style="width: 25%;">Συσκευασίες από πολυστρωματικά πλαστικά με περισσότερα του ενός πολυμερή ή πλαστικά με ετικέτες από PVC >100μm που περιέχουν > 25% ανακυκλωμένο υλικό</td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA64" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribA64" runat="server" ReadOnly="true" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA64_EE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
				<td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB64" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribB64" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB64_TE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="TableRowHeader" style="width: 25%;">Συσκευασίες από πολυστρωματικά πλαστικά με περισσότερα του ενός πολυμερή ή πλαστικά με ετικέτες από PVC – πολύ λεπτές <100μm που περιέχουν > 25% ανακυκλωμένο υλικό</td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA62" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribA62" runat="server" ReadOnly="true" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA62_EE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
				<td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB62" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribB62" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB62_TE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td colspan="7" class="TableRowHeader" style="width: 25%; text-align:center;"><b>Πλαστικές φιάλες ποτών μίας χρήσης που διατίθενται στην αγορά (συμπεριλαμβανομένων των καπακιών τους)</b></td>
                <td class="mLabelCenter" style="width: 25%;"></td>
                <td class="mLabelCenter" style="width: 25%;"></td>
                <td class="mLabelCenter" style="width: 25%;"></td>
            </tr>
            <tr>
                <td class="TableRowHeader" style="width: 25%;">Πλαστικές φιάλες ποτών μίας χρήσης που διατίθενται στην αγορά χωρίς χρώμα > 100μm</td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA72" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribA72" runat="server" ReadOnly="true" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA72_EE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB72" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribB72" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB72_TE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="TableRowHeader" style="width: 25%;">Πλαστικές φιάλες ποτών μίας χρήσης που διατίθενται στην αγορά χωρίς χρώμα - πολύ λεπτές <100μm</td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA73" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribA73" runat="server" ReadOnly="true" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA73_EE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
				<td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB73" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribB73" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB73_TE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="TableRowHeader" style="width: 25%;">Πλαστικές φιάλες ποτών μίας χρήσης που διατίθενται στην αγορά, χωρίς χρώμα >100μm, που περιέχουν > 25% ανακυκλωμένο υλικό</td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA74" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribA74" runat="server" ReadOnly="true" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA74_EE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
				<td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB74" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribB74" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB74_TE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="TableRowHeader" style="width: 25%;">Πλαστικές φιάλες ποτών μίας χρήσης που διατίθενται στην αγορά χωρίς χρώμα - πολύ λεπτές <100μm, που περιέχουν > 25% ανακυκλωμένο υλικό</td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA75" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribA75" runat="server" ReadOnly="true" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA75_EE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
				<td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB75" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribB75" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB75_TE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="TableRowHeader" style="width: 25%;">Έγχρωμες πλαστικές φιάλες ποτών μίας χρήσης που διατίθενται στην αγορά > 100μm</td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA76" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribA76" runat="server" ReadOnly="true" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA76_EE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
				<td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB76" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribB76" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB76_TE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="TableRowHeader" style="width: 25%;">Έγχρωμες πλαστικές φιάλες ποτών μίας χρήσης που διατίθενται στην αγορά - πολύ λεπτές <100μm</td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA77" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribA77" runat="server" ReadOnly="true" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA77_EE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
				<td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB77" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribB77" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB77_TE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="TableRowHeader" style="width: 25%;">Έγχρωμες πλαστικές φιάλες ποτών μίας χρήσης που διατίθενται στην αγορά > 100μm, που περιέχουν > 25% ανακυκλωμένο υλικό</td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA78" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribA78" runat="server" ReadOnly="true" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA78_EE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
				<td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB78" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribB78" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB78_TE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="TableRowHeader" style="width: 25%;">Έγχρωμες πλαστικές φιάλες ποτών μίας χρήσης που διατίθενται στην αγορά - πολύ λεπτές <100μm, που περιέχουν > 25% ανακυκλωμένο υλικό</td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA79" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribA79" runat="server" ReadOnly="true" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA79_EE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
				<td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB79" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribB79" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB79_TE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td colspan="7" class="TableRowHeader" style="width: 25%; text-align:center;"><b>Πλαστικά κυπελάκια τροφίμων-ποτών μίας χρήσης, συμπεριλαμβανομένων των καλυμμάτων και των καπακιών τους, που είναι εξ ολοκλήρου κατασκευασμένα από πλαστική ύλη</b></td>
                <td class="mLabelCenter" style="width: 25%;"></td>
                <td class="mLabelCenter" style="width: 25%;"></td>
                <td class="mLabelCenter" style="width: 25%;"></td>
            </tr>
            <tr>
                <td class="TableRowHeader" style="width: 25%;">Πλαστικά κυπελάκια τροφίμων ποτών μίας χρήσης, συμπεριλαμβανομένων των καλυμμάτων και των καπακιών τους, που είναι εξ ολοκλήρου κατασκευασμένα από πλαστική ύλη > 100μm</td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA80" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribA80" runat="server" ReadOnly="true" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA80_EE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
				<td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB80" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribB80" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB80_TE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="TableRowHeader" style="width: 25%;">Πλαστικά κυπελάκια τροφίμων ποτών μίας χρήσης, συμπεριλαμβανομένων των καλυμμάτων και των καπακιών τους, που είναι εξ ολοκλήρου κατασκευασμένα από πλαστική ύλη  - πολύ λεπτά <100μm</td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA81" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribA81" runat="server" ReadOnly="true" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA81_EE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
				<td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB81" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribB81" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB81_TE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="TableRowHeader" style="width: 25%;">Πλαστικά κυπελάκια τροφίμων ποτών μίας χρήσης, συμπεριλαμβανομένων των καλυμμάτων και των καπακιών τους, που είναι εξ ολοκλήρου κατασκευασμένα από πλαστική ύλη>100μm, που περιέχουν > 25% ανακυκλωμένο υλικό</td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA82" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribA82" runat="server" ReadOnly="true" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA82_EE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
				<td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB82" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribB82" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB82_TE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="TableRowHeader" style="width: 25%;">Πλαστικά κυπελάκια τροφίμων ποτών μίας χρήσης, συμπεριλαμβανομένων των καλυμμάτων και των καπακιών τους, που είναι εξ ολοκλήρου κατασκευασμένα από πλαστική ύλη - πολύ λεπτά <100μm, που περιέχουν > 25% ανακυκλωμένο υλικό</td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA83" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribA83" runat="server" ReadOnly="true" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA83_EE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
				<td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB83" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribB83" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB83_TE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td colspan="7" class="TableRowHeader" style="width: 25%; text-align:center;"><b>Πλαστικοί περιέκτες τροφίμων μίας χρήσης που είναι εξ ολοκλήρου κατασκευασμένοι από πλαστική ύλη</b></td>
                <td class="mLabelCenter" style="width: 25%;"></td>
                <td class="mLabelCenter" style="width: 25%;"></td>
                <td class="mLabelCenter" style="width: 25%;"></td>
            </tr>
            <tr>
                <td class="TableRowHeader" style="width: 25%;">Πλαστικοί περιέκτες τροφίμων μίας χρήσης που είναι εξ ολοκλήρου κατασκευασμένοι από πλαστική ύλη > 100μm</td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA84" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribA84" runat="server" ReadOnly="true" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA84_EE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
				<td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB84" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribB84" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB84_TE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="TableRowHeader" style="width: 25%;">Πλαστικοί περιέκτες τροφίμων μίας χρήσης που είναι εξ ολοκλήρου κατασκευασμένοι από πλαστική ύλη - πολύ λεπτοί <100μm</td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA85" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribA85" runat="server" ReadOnly="true" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA85_EE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
				<td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB85" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribB85" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB85_TE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="TableRowHeader" style="width: 25%;">Πλαστικοί περιέκτες τροφίμων μίας χρήσης που είναι εξ ολοκλήρου κατασκευασμένοι από πλαστική ύλη, > 100μm, που περιέχουν > 25% ανακυκλωμένο υλικό</td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA86" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribA86" runat="server" ReadOnly="true" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA86_EE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
				<td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB86" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribB86" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB86_TE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="TableRowHeader" style="width: 25%;">Πλαστικοί περιέκτες τροφίμων μίας χρήσης που είναι εξ ολοκλήρου κατασκευασμένοι από πλαστική ύλη - πολύ λεπτοί <100μm, που περιέχουν > 25% ανακυκλωμένο υλικό</td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA87" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribA87" runat="server" ReadOnly="true" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA87_EE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
				<td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB87" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribB87" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB87_TE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td colspan="7" class="TableRowHeader" style="width: 25%; text-align:center;"><b>ΣΥΝΘΕΤΕΣ ΣΥΣΚΕΥΑΣΙΕΣ</b></td>
                <td class="mLabelCenter" style="width: 25%;"></td>
                <td class="mLabelCenter" style="width: 25%;"></td>
                <td class="mLabelCenter" style="width: 25%;"></td>
            </tr>
            <tr>
                <td class="TableRowHeader" style="width: 25%;">Σύνθετες Συσκευασίες με βάση το Χαρτί</td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA14" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribA14" runat="server" ReadOnly="true" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA14_EE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB21" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribB21" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB21_TE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="TableRowHeader" style="width: 25%;">Σύνθετες Συσκευασίες με βάση το Γυαλί</td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA16" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribA16" runat="server" ReadOnly="true" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA16_EE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB23" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribB23" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB23_TE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td colspan="7" class="TableRowHeader" style="width: 25%; text-align:center;"><b>Σύνθετες Συσκευασίες με βάση το πλαστικό</b></td>
                <td class="mLabelCenter" style="width: 25%;"></td>
                <td class="mLabelCenter" style="width: 25%;"></td>
                <td class="mLabelCenter" style="width: 25%;"></td>
            </tr>
            <tr>
                <td class="TableRowHeader" style="width: 25%;">Σύνθετες συσκευασίες με βάση το πλαστικό > 100 μm</td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA67" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribA67" runat="server" ReadOnly="true" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA67_EE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
				<td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB67" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribB67" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB67_TE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="TableRowHeader" style="width: 25%;">Σύνθετες συσκευασίες με βάση το πλαστικό – πολύ λεπτές <100μm</td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA65" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribA65" runat="server" ReadOnly="true" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA65_EE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
				<td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB65" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribB65" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB65_TE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="TableRowHeader" style="width: 25%;">Σύνθετες συσκευασίες με βάση το πλαστικό>100 μm που περιέχουν>25% ανακυκλωμένο υλικό</td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA68" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribA68" runat="server" ReadOnly="true" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA68_EE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
				<td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB68" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribB68" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB68_TE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="TableRowHeader" style="width: 25%;">Σύνθετες συσκευασίες με βάση το πλαστικό – πολύ λεπτές <100μm που περιέχουν > 25% ανακυκλωμένο υλικό</td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA66" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribA66" runat="server" ReadOnly="true" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA66_EE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
				<td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB66" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribB66" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB66_TE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
            </tr>
<%--            <tr>
                <td colspan="6" class="TableRowTotals" style="width: 75%; vertical-align: middle;">Συνολική Εισφορά Α</td>
                <td class="mLabelCenter" style="width: 25%; ">
                    <asp:TextBox ID="txtSumTableA" runat="server" CssClass="mTextBoxFlat mTextBox90" TabIndex="3" Enabled="False" style="font-weight: bold;"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td colspan="7" class="TableRowHeader" style="width: 25%; text-align:center;"><b>Πλαστικά κύπελλα τροφίμων-ποτών μίας χρήσης, συμπεριλαμβανομένων των καλυμμάτων και των καπακιών τους, που είναι εν μέρει κατασκευασμένα από πλαστική ύλη</b></td>
                <td class="mLabelCenter" style="width: 25%;"></td>
                <td class="mLabelCenter" style="width: 25%;"></td>
                <td class="mLabelCenter" style="width: 25%;"></td>
            </tr>
            <tr>
                <td colspan="7" class="TableRowHeader" style="width: 25%; text-align:center;">Πλαστικά κύπελλα για ποτά μίας χρήσης, συμπεριλαμβανομένων των καλυμμάτων και των καπακιών τους, που είναι εν μέρει κατασκευασμένα από πλαστική ύλη > 100μm</td>
                <td class="mLabelCenter" style="width: 25%;"></td>
                <td class="mLabelCenter" style="width: 25%;"></td>
                <td class="mLabelCenter" style="width: 25%;"></td>
            </tr>
            <tr>
                <td class="TableRowHeader" style="width: 25%;">ΒΑΡΟΣ ΠΛΑΣΤΙΚΗΣ ΥΛΗΣ</td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA88" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td rowspan="2" class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribA88" runat="server" ReadOnly="true" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td rowspan="2" class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA88_EE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
				<td rowspan="2" class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB88" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td rowspan="2" class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribB88" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td rowspan="2" class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB88_TE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="TableRowHeader" style="width: 25%;">ΣΥΝΟΛΙΚΟ ΒΑΡΟΣ</td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA89" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td colspan="7" class="TableRowHeader" style="width: 25%; text-align:center;">Πλαστικά κύπελλα για ποτά μίας χρήσης, συμπεριλαμβανομένων των καλυμμάτων και των καπακιών τους, που είναι εν μέρει κατασκευασμένα από πλαστική ύλη - πολύ λεπτά <100μm</td>
                <td class="mLabelCenter" style="width: 25%;"></td>
                <td class="mLabelCenter" style="width: 25%;"></td>
                <td class="mLabelCenter" style="width: 25%;"></td>
            </tr>
            <tr>
                <td class="TableRowHeader" style="width: 25%;">ΒΑΡΟΣ ΠΛΑΣΤΙΚΗΣ ΥΛΗΣ</td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA90" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td rowspan="2" class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribA90" runat="server" ReadOnly="true" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td rowspan="2" class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA90_EE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
				<td rowspan="2" class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB90" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td rowspan="2" class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribB90" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td rowspan="2" class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB90_TE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="TableRowHeader" style="width: 25%;">ΣΥΝΟΛΙΚΟ ΒΑΡΟΣ</td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA91" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td colspan="7" class="TableRowHeader" style="width: 25%; text-align:center;">Πλαστικά κύπελλα για ποτά μίας χρήσης, συμπεριλαμβανομένων των καλυμμάτων και των καπακιών τους, που είναι εν μέρει κατασκευασμένα από πλαστική ύλη > 100μm, που περιέχουν > 25% ανακυκλωμένο υλικό</td>
                <td class="mLabelCenter" style="width: 25%;"></td>
                <td class="mLabelCenter" style="width: 25%;"></td>
                <td class="mLabelCenter" style="width: 25%;"></td>
            </tr>
            <tr>
                <td class="TableRowHeader" style="width: 25%;">ΒΑΡΟΣ ΠΛΑΣΤΙΚΗΣ ΥΛΗΣ</td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA92" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td rowspan="2" class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribA92" runat="server" ReadOnly="true" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td rowspan="2" class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA92_EE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
				<td rowspan="2" class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB92" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td rowspan="2" class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribB92" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td rowspan="2" class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB92_TE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="TableRowHeader" style="width: 25%;">ΣΥΝΟΛΙΚΟ ΒΑΡΟΣ</td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA93" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td colspan="7" class="TableRowHeader" style="width: 25%; text-align:center;">Πλαστικά κύπελλα για ποτά μίας χρήσης, συμπεριλαμβανομένων των καλυμμάτων και των καπακιών τους, που είναι εν μέρει κατασκευασμένα από πλαστική ύλη - πολύ λεπτά <100μm που περιέχουν > 25% ανακυκλωμένο υλικό</td>
                <td class="mLabelCenter" style="width: 25%;"></td>
                <td class="mLabelCenter" style="width: 25%;"></td>
                <td class="mLabelCenter" style="width: 25%;"></td>
            </tr>
            <tr>
                <td class="TableRowHeader" style="width: 25%;">ΒΑΡΟΣ ΠΛΑΣΤΙΚΗΣ ΥΛΗΣ</td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA94" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td rowspan="2" class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribA94" runat="server" ReadOnly="true" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td rowspan="2" class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA94_EE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
				<td rowspan="2" class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB94" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td rowspan="2" class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribB94" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td rowspan="2" class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB94_TE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="TableRowHeader" style="width: 25%;">ΣΥΝΟΛΙΚΟ ΒΑΡΟΣ</td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA95" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td colspan="7" class="TableRowHeader" style="width: 25%; text-align:center;"><b>Πλαστικοί περιέκτες τροφίμων μίας χρήσης που είναι εν μέρει κατασκευασμένοι από πλαστική ύλη</b></td>
                <td class="mLabelCenter" style="width: 25%;"></td>
                <td class="mLabelCenter" style="width: 25%;"></td>
                <td class="mLabelCenter" style="width: 25%;"></td>
            </tr>
            <tr>
                <td colspan="7" class="TableRowHeader" style="width: 25%; text-align:center;">Πλαστικοί περιέκτες τροφίμων μίας χρήσης που είναι εν μέρει κατασκευασμένοι από πλαστική ύλη > 100μm</td>
                <td class="mLabelCenter" style="width: 25%;"></td>
                <td class="mLabelCenter" style="width: 25%;"></td>
                <td class="mLabelCenter" style="width: 25%;"></td>
            </tr>
            <tr>
                <td class="TableRowHeader" style="width: 25%;">ΒΑΡΟΣ ΠΛΑΣΤΙΚΗΣ ΥΛΗΣ</td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA96" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td rowspan="2" class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribA96" runat="server" ReadOnly="true" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td rowspan="2" class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA96_EE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
				<td rowspan="2" class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB96" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td rowspan="2" class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribB96" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td rowspan="2" class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB96_TE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="TableRowHeader" style="width: 25%;">ΣΥΝΟΛΙΚΟ ΒΑΡΟΣ</td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA97" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td colspan="7" class="TableRowHeader" style="width: 25%; text-align:center;">Πλαστικοί περιέκτες τροφίμων μίας χρήσης που είναι εν μέρει κατασκευασμένοι από πλαστική ύλη - πολύ λεπτοί <100μm</td>
                <td class="mLabelCenter" style="width: 25%;"></td>
                <td class="mLabelCenter" style="width: 25%;"></td>
                <td class="mLabelCenter" style="width: 25%;"></td>
            </tr>
            <tr>
                <td class="TableRowHeader" style="width: 25%;">ΒΑΡΟΣ ΠΛΑΣΤΙΚΗΣ ΥΛΗΣ</td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA98" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td rowspan="2" class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribA98" runat="server" ReadOnly="true" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td rowspan="2" class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA98_EE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
				<td rowspan="2" class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB98" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td rowspan="2" class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribB98" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td rowspan="2" class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB98_TE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="TableRowHeader" style="width: 25%;">ΣΥΝΟΛΙΚΟ ΒΑΡΟΣ</td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA99" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td colspan="7" class="TableRowHeader" style="width: 25%; text-align:center;">Πλαστικοί περιέκτες τροφίμων μίας χρήσης που είναι εν μέρει κατασκευασμένοι από πλαστική ύλη > 100 μm, που περιέχουν > 25% ανακυκλωμένο υλικό</td>
                <td class="mLabelCenter" style="width: 25%;"></td>
                <td class="mLabelCenter" style="width: 25%;"></td>
                <td class="mLabelCenter" style="width: 25%;"></td>
            </tr>
            <tr>
                <td class="TableRowHeader" style="width: 25%;">ΒΑΡΟΣ ΠΛΑΣΤΙΚΗΣ ΥΛΗΣ</td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA100" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td rowspan="2" class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribA100" runat="server" ReadOnly="true" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td rowspan="2" class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA100_EE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
				<td rowspan="2" class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB100" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td rowspan="2" class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribB100" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td rowspan="2" class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB100_TE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="TableRowHeader" style="width: 25%;">ΣΥΝΟΛΙΚΟ ΒΑΡΟΣ</td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA101" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td colspan="7" class="TableRowHeader" style="width: 25%; text-align:center;">Πλαστικοί περιέκτες τροφίμων μίας χρήσης που είναι εν μέρει κατασκευασμένοι από πλαστική ύλη - πολύ λεπτοί <100 μm που περιέχουν > 25% ανακυκλωμένο υλικό</td>
                <td class="mLabelCenter" style="width: 25%;"></td>
                <td class="mLabelCenter" style="width: 25%;"></td>
                <td class="mLabelCenter" style="width: 25%;"></td>
            </tr>
            <tr>
                <td class="TableRowHeader" style="width: 25%;">ΒΑΡΟΣ ΠΛΑΣΤΙΚΗΣ ΥΛΗΣ</td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA102" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td rowspan="2" class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribA102" runat="server" ReadOnly="true" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td rowspan="2" class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA102_EE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
				<td rowspan="2" class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB102" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td rowspan="2" class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_ContribB102" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
                <td rowspan="2" class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightB102_TE" runat="server" CssClass="mTextBoxFlat" TabIndex="3" Enabled="False"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="TableRowHeader" style="width: 25%;">ΣΥΝΟΛΙΚΟ ΒΑΡΟΣ</td>
                <td class="mLabelCenter" style="width: 25%;">
                    <asp:TextBox ID="YR_WeightA103" runat="server" CssClass="mTextBoxFlat" TabIndex="3"></asp:TextBox>
                </td>
            </tr>--%>
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
                <th colspan="3" style="width: 100%;" class= "TableHeader">Γ. Εισφορά βάσει Τέλους Συμμετοχής (entrance fee)</th>
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
                <th colspan="3" style="width: 100%; height: 24px;" class= "TableHeader">Σχετικά με τη δήλωση</th>
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
                <th colspan="2" style="width: 100%; height: 24px;" class= "TableHeader">Συμμετοχή σε εγκεκριμένο Σύστημα Εναλλακτικής Διαχείρισης Συσκευασιών</th>
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

