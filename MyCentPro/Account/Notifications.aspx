<%@ Page Title="CentPro - Varsler" Language="C#" MasterPageFile="~/MasterPage.Master" EnableEventValidation="true" AutoEventWireup="true" Inherits="Account_Notifications" CodeFile="Notifications.aspx.cs" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron">
        <p class="lead">[DEBUG] Her legger man til og håndterer varsler.</p>
        <p><a href="http://www.asp.net" class="btn btn-primary btn-lg">Les mer &raquo;</a>
        </p>
    </div>

    <div id="editNotification" title="Rediger varsel" runat="server">
      <p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>Avtalen vil bli slettet fra systemet, er du sikker?</p>
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

    <div class="notifications" id="notifications" runat="server">
        <asp:Label ID="nIdLabel" runat="server" Text="nIdLabel"></asp:Label>
    </div>
</asp:Content>

