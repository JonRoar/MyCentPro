<%@ Page Title="CentPro - Lisenser" Language="C#" MasterPageFile="~/MasterPage.Master" EnableEventValidation="true" AutoEventWireup="true" Inherits="MyCentPro.Licences" CodeFile="~/Account/Licences.aspx.cs" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron">
        <h1>Velkommen til MyCentPro</h1>
        <p class="lead">MyCentPro gir deg fullstendig oversikt over alle firmaets lisenser samtidig som vi sender varsler når abonnementene og avtalene er i ferd med å utløpe.</p>
        <p><a href="http://www.asp.net" class="btn btn-primary btn-lg">Les mer &raquo;</a> </p>
    </div>
        <ul id="errUl">
             <li id="errLi">
                 <span style="font-weight:bold;">Dette er en feilmelding [hardcoded]</span>
                 <input type="checkbox" id="errCB"/><label id="errLabel" for="errCB">&nbsp;&nbsp;</label>&nbsp;&nbsp;
                 
		        <ul>
				    <br /><br />Og her kan man få ennå mer informasjon om feilen... <a href="/" >Feil X</a>
                    
		        </ul>
	        </li>
        </ul>

        <ul id="eUl">
             <li id="eLi">
                 <span>Du (Jon Roar Odden) har <span style="color:#ff0000; font-weight:bold;">7</span> lisenser som utgår de nærmeste 3 månedene. [hardcoded]</span>
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
                 <ul>
				    Her vil alle varsler for dine lisenser og avtaler komme... med linker til hver enkelt av de. <a href="/" >Avtale xyz</a>
		        </ul>
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

    </ul>
    </a></asp:Content>
