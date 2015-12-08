using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using Microsoft.AspNet.Identity;
using System.Web.UI.WebControls;
using MyCentPro;

public partial class Account_Notifications : System.Web.UI.Page
{
    LogWriter logWriter = new LogWriter();
    int nId = -1;

    protected void Page_Load(object sender, EventArgs e)
    {
        //do not display red slide-down
        errUl.Visible = false;

        if ((System.Web.HttpContext.Current.User != null) && System.Web.HttpContext.Current.User.Identity.IsAuthenticated)
        {
            string aspID = HttpContext.Current.User.Identity.GetUserId().ToString();
            logWriter.OpenDBConnection();
            logWriter.WriteToLog(aspID, "User accessed Licences.aspx.");
        }

        if (!Page.IsPostBack)
        {
            if (Request.QueryString.Count > 0 && Request.QueryString["nId"] != null)
            {
                nId = Int32.Parse(Request.QueryString["nId"]);
                nIdLabel.Visible = true;
                nIdLabel.Text = "nID: " + nId;
            }
            else
            {
                nIdLabel.Visible = false;
                nIdLabel.Text = "nID: " + nId;
                nIdLabel.Visible = false;
            }
        }
    }

    protected void InsertButton_Click(object sender, EventArgs e)
    {

    }
}