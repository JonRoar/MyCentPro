<%@ Page Title="CentPro - Lisenser" Language="C#" MasterPageFile="~/MasterPage.Master" EnableEventValidation="true" AutoEventWireup="true" Inherits="MyCentPro.Licences" CodeFile="~/Account/Licences.aspx.cs" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron" id="jumbotron" runat="server">
        <h1>Velkommen til MyCentPro</h1>
        <p class="lead">MyCentPro gir deg fullstendig oversikt over alle firmaets lisenser samtidig som vi sender varsler når abonnementene og avtalene er i ferd med å utløpe.</p>
        <p><a href="http://www.asp.net" class="btn btn-primary btn-lg">Les mer &raquo;</a>
        </p>
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
            <span>Du (<span id="userName" runat="server" style="font-weight:bold;">(brukernavn)</span>), har <span id="licCounter" runat="server" style="color:#ff0000; font-weight:bold;">xx</span> lisenser som utgår de nærmeste <span id="expMonths" runat="server" style="font-weight:normal;">(tid)</span> månedene.</span>
            <input type="checkbox" id="expandCB"/><label id="eLabel" for="expandCB">&nbsp;&nbsp;</label>&nbsp;&nbsp;
            <ul>
                <asp:DataList ID="dataListNotifications" DataKeyField="nID" DataSourceID="SqlDataSource1" runat="server" OnSelectedIndexChanged="dataListNotifications_SelectedIndexChanged">
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

    <div class="addOrEdit" id="addOrEdit" runat="server">
        <asp:Label ID="eIdLabel" runat="server" Text="eIdLabel"></asp:Label>
    </div>
    
    <!--------------------------------------------------------------------->
    <!-- The main GridView to hold license data                          -->
    <!--------------------------------------------------------------------->
    <div class="row" runat="server" id="licenseHeading">
        <h4 style="background-color:lightgreen; text-align: center; padding-top:5px; padding-bottom:5px;">Mine lisenser</h4>
        <p>
            <asp:GridView ID="licenceGridView" runat="server" AllowPaging="true" AutoGenerateColumns="false" CellPadding="4" GridLines="None"
                Caption="" CaptionAlign="Left" Width="1200px"
                DataKeyNames="owner_uID"
                OnPageIndexChanging="licenceGridView_PageIndexChanging"
                OnRowCancelingEdit="licenceGridView_RowCancelingEdit"
                OnRowDeleting="licenceGridView_RowDeleting"
                OnRowEditing="licenceGridView_RowEditing"
                OnRowUpdating="licenceGridView_RowUpdating"
                RowStyle-BackColor="White"
                AlternatingRowStyle-BackColor="#a6c8e6">
                
                <Columns>
                <asp:BoundField DataField="owner_uID" HeaderText="ID" />
                <asp:BoundField DataField="aspID" HeaderText="aspID" />
                <asp:BoundField DataField="Produsent" HeaderText="Produsent" />
                <asp:BoundField DataField="Lisenstype" HeaderText="Lisenstype" />
                <asp:BoundField DataField="Antall" HeaderText="Antall" />
                <asp:BoundField DataField="Gyldig fra" HeaderText="Gyldig fra" />
                <asp:BoundField DataField="Gyldig til" HeaderText="Gyldig til" />
                <asp:BoundField DataField="Eier" HeaderText="Eier" />
                <asp:HyperLinkField 
                    HeaderText="Avtale"
                    DataNavigateUrlFields="AvtaleID" 
                    DataTextField="Avtale"
                    DataNavigateUrlFormatString="/Accounts/Agreements.aspx?id={0}" />              
                <asp:HyperLinkField
                    HeaderText="Kontaktperson" 
                    DataNavigateUrlFields="cID"
                    DataTextField="Kontaktperson"
                    DataNavigateUrlFormatString="/Accounts/Contacts.aspx?id={0}" />
                <asp:CommandField ShowEditButton="true" />
                <asp:CommandField ShowDeleteButton="true" />
                </Columns>
            </asp:GridView>
            <asp:LinkButton ID="lnkbExportToExcel" runat="server" OnClick="lnkbExportToExcel_Click">Export to Excel</asp:LinkButton>
        </p>
    </div>
</asp:Content>
