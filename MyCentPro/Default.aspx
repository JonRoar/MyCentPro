<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron">
        <h1>MyCentPro</h1>
        <p class="lead">gir deg fullstendig oversikt over alle firmaets lisenser samtidig som vi sender varsler når abonnementene og avtalene er i ferd med å utløpe.</p>
        <p><a href="http://www.asp.net" class="btn btn-primary btn-lg">Les mer &raquo;</a></p>
    </div>

    <div class="row">
        <div class="col-md-4">
            <h2>Lisensoversikt</h2>
            <p>
                De fleste bedrifter trenger oversikt over lisensene i bruk, hvem som bruker de og hvor lenge de er gyldige. CentPro Lisensweb er dette verktøyet.
            </p>
            <p>
                <a class="btn btn-default" href="http://go.microsoft.com/fwlink/?LinkId=301948">Les mer &raquo;</a>
            </p>
        </div>
        <div class="col-md-4">
            <h2>Avtaleoversikt</h2>
            <p>
                Med CentPro Lisensweb kan du også legge inn avtalene og holde oversikten over disse.
            </p>
            <p>
                <a class="btn btn-default" href="http://go.microsoft.com/fwlink/?LinkId=301949">Les mer &raquo;</a>
            </p>
        </div>
        <div class="col-md-4">
            <h2>Varslinger</h2>
            <p>
                Legg inn e-postadressen din så sender vi deg varsler før lisensene utløper!
            </p>
            <p>
                <a class="btn btn-default" href="http://go.microsoft.com/fwlink/?LinkId=301950">Les mer &raquo;</a>
            </p>
        </div>
    </div>

</asp:Content>
