<%@ Page Title="CentPro - Rediger data" Language="C#" MasterPageFile="~/MasterPage.Master" EnableEventValidation="true" AutoEventWireup="true" Inherits="Account_AddOrEdit" CodeFile="AddOrEdit.aspx.cs" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron">
        <p class="lead">[DEBUG] Her legger man til og håndterer data.</p>
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

    <div class="AddOrEdit">
        
        <asp:FormView ID="FormView1" runat="server" DataSourceID="SqlDataSource1">
            <EditItemTemplate>
                AgreementName:
                <asp:TextBox ID="AgreementNameTextBox" runat="server" Text='<%# Bind("AgreementName") %>' />
                <br />
                DateFrom:
                <asp:TextBox ID="DateFromTextBox" runat="server" Text='<%# Bind("DateFrom") %>' />
                <br />
                DateTo:
                <asp:TextBox ID="DateToTextBox" runat="server" Text='<%# Bind("DateTo") %>' />
                <br />
                Comment:
                <asp:TextBox ID="CommentTextBox" runat="server" Text='<%# Bind("Comment") %>' />
                <br />
                <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />
                &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
            </EditItemTemplate>
            <InsertItemTemplate>
                AgreementName:
                <asp:TextBox ID="AgreementNameTextBox" runat="server" Text='<%# Bind("AgreementName") %>' />
                <br />
                DateFrom:
                <asp:TextBox ID="DateFromTextBox" runat="server" Text='<%# Bind("DateFrom") %>' />
                <br />
                DateTo:
                <asp:TextBox ID="DateToTextBox" runat="server" Text='<%# Bind("DateTo") %>' />
                <br />
                Comment:
                <asp:TextBox ID="CommentTextBox" runat="server" Text='<%# Bind("Comment") %>' />
                <br />
                <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" />
                &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
            </InsertItemTemplate>
            <ItemTemplate>
                AgreementName:
                <asp:Label ID="AgreementNameLabel" runat="server" Text='<%# Bind("AgreementName") %>' />
                <br />
                DateFrom:
                <asp:Label ID="DateFromLabel" runat="server" Text='<%# Bind("DateFrom") %>' />
                <br />
                DateTo:
                <asp:Label ID="DateToLabel" runat="server" Text='<%# Bind("DateTo") %>' />
                <br />
                Comment:
                <asp:Label ID="CommentLabel" runat="server" Text='<%# Bind("Comment") %>' />
                <br />

            </ItemTemplate>
        </asp:FormView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" SelectCommand="SELECT [AgreementName], [DateFrom], [DateTo], [Comment] FROM [Agreements]"></asp:SqlDataSource>
        
    </div>
</asp:Content>

