using System;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Account_GetInvoice : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //do not display red slide-down
        errUl.Visible = false;

        //get InvoiceID to download
        if (Request.QueryString.Count >= 1)
        {
            Download(Int16.Parse(Request.QueryString["iID"]));
        }
    }

    protected void InsertButton_Click(object sender, EventArgs e)
    {

    }

    public void Download(int InvoiceID)
    {
        string filepath = @"Z:\Account\Invoices\Faktura 100959.pdf";
        FileInfo file = new FileInfo(filepath);

        if (file.Exists)
        { 
            Response.Clear();
            Response.ClearHeaders();
            Response.ClearContent();

            Response.AddHeader("Content-Disposition", "attachment; filename=" + file.Name);
            Response.AddHeader("Content-Length", file.Length.ToString());
            Response.ContentType = "application/pdf";

            Response.Flush();
            Response.TransmitFile(file.FullName);

            Response.End();
        }
    }
}