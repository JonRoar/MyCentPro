using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Account_AddOrEdit : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //do not display red slide-down
        errUl.Visible = false;
    }

    protected void InsertButton_Click(object sender, EventArgs e)
    {

    }
}