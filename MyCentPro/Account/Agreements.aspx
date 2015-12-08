<%@ Page Title="CentPro - Avtaler" Language="C#" MasterPageFile="~/MasterPage.Master" EnableEventValidation="true" AutoEventWireup="true" Inherits="MyCentPro.Agreements" CodeFile="~/Account/Agreements.aspx.cs" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron">
        <h1>Velkommen til MyCentPro</h1>
        <p class="lead">MyCentPro gir deg fullstendig oversikt over alle firmaets lisenser samtidig som vi sender varsler når abonnementene og avtalene er i ferd med å utløpe.</p>
        <p><a href="http://www.asp.net" class="btn btn-primary btn-lg">Les mer &raquo;</a></p>
    </div>

    <div id="dialogConfirm" title="Slette avtale?" style="display:none">
      <p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>Avtalen blir slettet. Er du sikker?</p>
    </div>

    <!--------------------------------------------------------------------->
    <!-- Placeholder for error messages generated in the code            -->
    <!--------------------------------------------------------------------->
    <asp:PlaceHolder runat="server" ID="ErrorMessage" Visible="false">
        <p class="text-danger">
            <asp:Literal runat="server" ID="FailureText" />
        </p>
    </asp:PlaceHolder>

    <!--------------------------------------------------------------------->
    <!-- Critical error dialogue placeholder for really important stuff. -->
    <!--------------------------------------------------------------------->
    <ul id="errUl" runat="server">
        <li id="errLi">
            <span style="font-weight:bold;">Dette er en feilmelding [hardcoded]</span>
            <input type="checkbox" id="errCB"/><label id="errLabel" for="errCB">&nbsp;&nbsp;</label>&nbsp;&nbsp; 
		    <ul>
				<div><br /><br />Og her kan man få ennå mer informasjon om feilen... <a href="/" >Feil X</a></div>
		    </ul>
	    </li>
    </ul>

    <!--------------------------------------------------------------------->
    <!-- Warningbox with dynamic info on licenses and agreement          -->
    <!-- that expires in the near future according to user settings.     -->
    <!--------------------------------------------------------------------->
    <ul id="eUl" runat="server">
        <li id="eLi">
            <span>Du (<span id="userName" runat="server" style="font-weight:bold;">(brukernavn)</span>), har <span id="agrCounter" runat="server" style="color:#ff0000; font-weight:bold;">xx</span> lisenser som utgår <span id="expText" runat="server">de nærmeste <span id="expMonths" runat="server" style="font-weight:normal;">(tid)</span> månedene.</span></span>
            <input type="checkbox" id="expandCB"/><label id="eLabel" for="expandCB">&nbsp;&nbsp;</label>&nbsp;&nbsp;
            <ul>
                <asp:DataList ID="dataListNotifications" DataKeyField="nID" DataSourceID="SqlDataSource1" runat="server">
                    <ItemTemplate>
                        <asp:Label ID="dNotificationTimeLabel" runat="server" Text='<%# Eval("dNotificationTime") %>' />
                        <asp:Label ID="nIDLabel" runat="server" Text='<%# Eval("nID") %>' />
                        <asp:Label ID="lIDLabel" runat="server" Text='<%# Eval("lID") %>' />
                    </ItemTemplate>
                </asp:DataList>
		        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" SelectCommand="SELECT [dNotificationTime], [nID], [lID] FROM [Notifications]"></asp:SqlDataSource>
                <asp:ObjectDataSource ID="dsNotifications" runat="server"></asp:ObjectDataSource>
            </ul>
	    </li>
    </ul>

    <!--------------------------------------------------------------------->
    <!-- The main GridView to hold agreement data                        -->
    <!--------------------------------------------------------------------->
    <div class="row">
        <h4 style="background-color:lightgreen; text-align: center; padding-top:5px; padding-bottom:5px;">Mine avtaler</h4>
        <p>
            <asp:GridView ID="agreementsGridView" runat="server" AllowPaging="true" AutoGenerateColumns="false" CellPadding="4" GridLines="None" CssClass="Grid" 
                Caption="" CaptionAlign="Left" Width="1200px"
                DataKeyNames="Avtalenummer"
                OnPageIndexChanging="agreementsGridView_PageIndexChanging"
                OnRowCancelingEdit="agreementsGridView_RowCancelingEdit"
                OnRowDeleting="agreementsGridView_RowDeleting"
                OnRowEditing="agreementsGridView_RowEditing"
                OnRowUpdating="agreementsGridView_RowUpdating"
                RowStyle-BackColor="White"
                AlternatingRowStyle-BackColor="#a6c8e6">

                <HeaderStyle CssClass="GridHeader"></HeaderStyle>
                <Columns>
                <asp:BoundField DataField="Avtalenummer" HeaderText="Avtalenr" />
                <asp:BoundField DataField="Produsent" HeaderText="Produsent" />
                <asp:BoundField DataField="Avtale" HeaderText="Avtale" />
                <asp:BoundField DataField="Kjøpt dato" HeaderText="Kjøpt dato" />
                <asp:BoundField DataField="Utløpsdato" HeaderText="Utløpsdato" />
                <asp:HyperLinkField 
                    Text="&lt;img src='../Content/images/pdficon_small.png' alt='Last ned faktura' border='0'/&gt;"
                    HeaderText="&lt;img src='../Content/images/pdficon_small.png' alt='Last ned faktura' border='0'/&gt;"
                    DataNavigateUrlFields="aID" 
                    DataNavigateUrlFormatString="/Account/GetInvoice.aspx?iId={0}" />
                <asp:HyperLinkField 
                    HeaderText="Varsel"
                    DataNavigateUrlFields="nID" 
                    DataTextField="Varsel"
                    DataNavigateUrlFormatString="/Account/Notifications.aspx?nId={0}" />
                <asp:BoundField DataField="Eier" HeaderText="Eier" />
                <asp:HyperLinkField 
                    HeaderText="Kontaktperson"
                    DataNavigateUrlFields="cID" 
                    DataTextField="Kontaktperson"
                    DataNavigateUrlFormatString="/Account/Contacts.aspx?cId={0}" />  
                <asp:CommandField ShowEditButton="true" />
                <asp:CommandField ShowDeleteButton="true" />
                </Columns>
            </asp:GridView>
        </p>
    </div>

    <script>
        function showDialog() {
            $("#dialogConfirm").dialog({
                resizable: false,
                height: 180,
                width: 460,
                modal: true,
                buttons: {
                    "Slett": function () {
                        $doDelete();
                        $(this).dialog("close");

                    },
                    "Avbryt": function () {
                        $(this).dialog("close");
                    }
                }
            });
        }

        function doDelete()
        {
            alert();
        }
    </script>
</asp:Content>
