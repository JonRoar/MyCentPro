<%@ Page Title="CentPro - Avtaler" Language="C#" MasterPageFile="~/MasterPage.Master" EnableEventValidation="true" AutoEventWireup="true" Inherits="MyCentPro.Agreements" CodeFile="~/Account/Agreements.aspx.cs" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron">
        <h1>Velkommen til MyCentPro</h1>
        <p class="lead">MyCentPro gir deg fullstendig oversikt over alle firmaets lisenser samtidig som vi sender varsler når abonnementene og avtalene er i ferd med å utløpe.</p>
        <p><a href="http://www.asp.net" class="btn btn-primary btn-lg">Les mer &raquo;</a></p>
    </div>

    <ul id="eUl">
        <li id="eLi">
            <span>Du (Jon Roar Odden) har <span style="color:#ff0000; font-weight:bold;">3</span> avtaler som utgår de nærmeste 3 månedene. [hardcoded]</span>
            <input type="checkbox" id="expandCB"/><label id="eLabel" for="expandCB">&nbsp;&nbsp;</label>&nbsp;&nbsp;

		<ul>
			Her vil alle varsler for dine lisenser og avtaler komme... med linker til hver enkelt av de. <a href="/" >Avtale xyz</a>
		</ul>
        <ul>
			Her vil alle varsler for dine lisenser og avtaler komme... med linker til hver enkelt av de. <a href="/" >Avtale xyz</a>
		</ul>
            <ul>
			Her vil alle varsler for dine lisenser og avtaler komme... med linker til hver enkelt av de. <a href="/" >Avtale xyz</a>
		</ul>
	    </li>
    </ul>

    <div class="row">
        <h4 style="background-color:lightgreen; text-align: center; padding-top:5px; padding-bottom:5px;">Mine avtaler</h4>
        <p>
            <asp:GridView ID="agreementsGridView" runat="server" AllowPaging="true" AutoGenerateColumns="false" CellPadding="4" GridLines="None" CssClass="Grid" 
                Caption="" CaptionAlign="Left" Width="1200px"
                OnPageIndexChanging="agreementsGridView_PageIndexChanging"
                OnRowCancelingEdit="agreementsGridView_RowCancelingEdit"
                OnRowDeleting="agreementsGridView_RowDeleting"
                OnRowEditing="agreementsGridView_RowEditing"
                OnRowUpdating="agreementsGridView_RowUpdating"
                RowStyle-BackColor="White"
                AlternatingRowStyle-BackColor="#a6c8e6">

                <HeaderStyle CssClass="GridHeader"></HeaderStyle>
                <Columns>
                <asp:BoundField DataField="aID" HeaderText="aID" />
                <asp:BoundField DataField="Avtale" HeaderText="Avtale" />
                <asp:BoundField DataField="Avtaleeier" HeaderText="Avtaleeier" />
                <asp:CommandField ShowEditButton="true" />
                </Columns>
            </asp:GridView>
        </p>
    </div>
</asp:Content>
