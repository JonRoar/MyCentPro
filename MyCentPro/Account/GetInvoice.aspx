<%@ Page Title="CentPro - Hent faktura" Language="C#" MasterPageFile="~/MasterPage.Master" EnableEventValidation="true" AutoEventWireup="true" Inherits="Account_GetInvoice" CodeFile="GetInvoice.aspx.cs" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron">
        <p class="lead">[DEBUG] Her henter man faktura.</p>
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

    <div class="InvoiceList">
        
    </div>
</asp:Content>

