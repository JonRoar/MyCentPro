<%@ Application Language="C#" %>
<%@ Import Namespace="MyCentPro" %>
<%@ Import Namespace="System.Web.Optimization" %>
<%@ Import Namespace="System.Web.Routing" %>

<script runat="server">

    void Application_Start(object sender, EventArgs e)
    {
        RouteConfig.RegisterRoutes(RouteTable.Routes);
        BundleConfig.RegisterBundles(BundleTable.Bundles);
    }

    protected void Application_Error(Object sender, EventArgs e)
    {
        Session["CurrentError"] = "Global: " +
            Server.GetLastError().Message;
        Server.Transfer("lasterr.aspx");
    }
</script>
