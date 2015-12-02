using System;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Configuration;
using Microsoft.AspNet.Identity;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Drawing;


namespace MyCentPro
{
    public partial class Agreements : Page
    {
        SqlDataAdapter da;
        DataSet ds = new DataSet();
        SqlCommand cmd = new SqlCommand();
        LogWriter logWriter = new LogWriter();
        SqlConnection con;
        //protected global::System.Web.UI.WebControls.GridView agreementsGridView;

        protected void Page_Load(object sender, EventArgs e)
        {
            if ((System.Web.HttpContext.Current.User != null) && System.Web.HttpContext.Current.User.Identity.IsAuthenticated)
            {
                string aspID = HttpContext.Current.User.Identity.GetUserId().ToString();
                logWriter.OpenDBConnection();
                logWriter.WriteToLog(aspID, "User accessed the Agreements.aspx page.");
            }

            if (!Page.IsPostBack)
            {
                BindData();
            }

            //do not display red slide-down
            errUl.Visible = false;

            //update dynamic text on page for warnings and stuff...
            agrCounter.InnerText = "2"; // [HARDCODED]
            userName.InnerText = User.Identity.Name;
            expMonths.InnerText = "1"; // [HARDCODED]
        }

        public SqlConnection OpenDBConnection()
        {
            try
            {
                con = new SqlConnection(ConfigurationManager.ConnectionStrings["ApplicationServices"].ConnectionString);
                return con;
            }
            catch (SqlException)
            {
                return null;
            }
            finally
            {
                con.Close();
            }
        }

        public void BindData()
        {
            try
            {
                //instantiate connection
                con = OpenDBConnection();

                //define query
                cmd.CommandText = "SELECT a.aNumber as 'Avtalenummer', p.Name as 'Produsent', a.AgreementName as 'Avtale', a.DateFrom as 'Kjøpt dato', " +
	                                "a.DateTo as 'Utløpsdato', n.nID, n.nDescription as 'Varsel', u.Name as 'Eier', c.cID, c.Name as 'Kontaktperson' " +
                                    "FROM Agreements a " +
                                    "JOIN Users u ON a.uID_AgreementOwner = u.uID " +
                                    "JOIN Producer p ON a.pID = p.pID " +
                                    "JOIN Notifications n ON a.nID = n.nID " +
                                    "JOIN Contacts c ON a.cID = c.cID";
                cmd.Connection = con;

                da = new SqlDataAdapter(cmd);
                da.Fill(ds);
                con.Open();
                cmd.ExecuteNonQuery();

                agreementsGridView.DataSource = ds;
                agreementsGridView.DataBind();

                con.Close();
            }
            catch (SqlException)
            {
                //TODO: show errors to user on page. -jr
            }
            finally
            {
                con.Close();
            }
        }

        private void Page_Error(object sender, EventArgs e)
        {
            Exception exc = Server.GetLastError();

            // Handle specific exception.
            if (exc is HttpUnhandledException)
            {
                //ErrorMsgTextBox.Text = "An error occurred on this page. Please verify your " +
                //"information to resolve the issue."
            }
            // Clear the error from the server.
            Server.ClearError();
        }

        protected void agreementsGridView_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            /*
            GridViewRow row = (GridViewRow)licenceGridView.Rows[e.RowIndex];
            Label lbldeleteid = (Label)row.FindControl("lID");
            con.Open();
            SqlCommand cmd = new SqlCommand("delete FROM Licences where lID='" + Convert.ToInt32(licenceGridView.DataKeys[e.RowIndex].Value.ToString()) + "'", con);
            cmd.ExecuteNonQuery();
            con.Close();
            BindData();
            */

            //log it
            string aspID = HttpContext.Current.User.Identity.GetUserId().ToString();
            logWriter.OpenDBConnection();
            logWriter.WriteToLog(aspID, "User deleted a license with lID = " + Convert.ToInt32(agreementsGridView.DataKeys[e.RowIndex].Value.ToString()));
        }

        protected void agreementsGridView_RowEditing(object sender, GridViewEditEventArgs e)
        {
            agreementsGridView.EditIndex = e.NewEditIndex;
            BindData();

            //log it
            string aspID = HttpContext.Current.User.Identity.GetUserId().ToString();
            logWriter.OpenDBConnection();
            logWriter.WriteToLog(aspID, "User initiated edit of agreement with aID = " + Convert.ToInt32(agreementsGridView.DataKeys[e.NewEditIndex].Value.ToString()));
        }

        protected void agreementsGridView_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            agreementsGridView.PageIndex = e.NewPageIndex;
            BindData();
        }

        protected void agreementsGridView_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            agreementsGridView.EditIndex = -1;
            BindData();
        }


        protected void agreementsGridView_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int licenceID = Convert.ToInt32(agreementsGridView.DataKeys[e.RowIndex].Value.ToString());
            GridViewRow row = (GridViewRow)agreementsGridView.Rows[e.RowIndex];

            Label lbllID = (Label)row.FindControl("lbllID");
            //TextBox txtname=(TextBox)gr.cell[].control[];
            TextBox txtOwner = (TextBox)row.Cells[0].Controls[0];
            TextBox txtCount = (TextBox)row.Cells[1].Controls[0];
            //TextBox textc = (TextBox)row.Cells[2].Controls[0]; //JRO removed
            //TextBox textadd = (TextBox)row.FindControl("txtadd");
            //TextBox textc = (TextBox)row.FindControl("txtc");
            agreementsGridView.EditIndex = -1;

            con.Open();
            //SqlCommand cmd = new SqlCommand("SELECT * FROM detail", con);
            SqlCommand cmd = new SqlCommand("UPDATE Agreements SET aID=" + Int16.Parse(txtOwner.Text) + ", lCount=" + Int16.Parse(txtCount.Text) + " where lID=" + lbllID, con);
            cmd.ExecuteNonQuery();

            con.Close();
            BindData();
        }

        protected void ExportToExcel2007()
        {

        }

        protected void ExportToExcel2003(object sender, EventArgs e)
        {
            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment;filename=LicenceWebExport.xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.ms-excel"; //Excel 2003
            //Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"; //Excel 2007
            //Response.ContentType = string.Empty;
            //Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";

            using (StringWriter sw = new StringWriter())
            {
                HtmlTextWriter hw = new HtmlTextWriter(sw);

                //To Export all pages
                agreementsGridView.AllowPaging = false;
                this.BindData();

                agreementsGridView.HeaderRow.BackColor = Color.White;
                foreach (TableCell cell in agreementsGridView.HeaderRow.Cells)
                {
                    cell.BackColor = agreementsGridView.HeaderStyle.BackColor;
                }

                foreach (GridViewRow row in agreementsGridView.Rows)
                {
                    row.BackColor = Color.White;
                    foreach (TableCell cell in row.Cells)
                    {
                        if (row.RowIndex % 2 == 0)
                        {
                            cell.BackColor = agreementsGridView.AlternatingRowStyle.BackColor;
                        }
                        else
                        {
                            cell.BackColor = agreementsGridView.RowStyle.BackColor;
                        }
                        cell.CssClass = "textmode";
                    }
                }

                //licenceGridView.RenderControl(hw);
                agreementsGridView.RenderBeginTag(hw);
                agreementsGridView.HeaderRow.RenderControl(hw);
                foreach (GridViewRow row in agreementsGridView.Rows)
                {
                    row.RenderControl(hw);
                }
                agreementsGridView.FooterRow.RenderControl(hw);
                agreementsGridView.RenderEndTag(hw);

                //style to format numbers to string
                string style = @"<style> .textmode { } </style>";
                Response.Write(style);
                Response.Output.Write(sw.ToString());
                Response.Flush();
                Response.End();
            }
        }

        protected void lnkbExportToExcel_Click(object sender, EventArgs e)
        {
            ExportToExcel2003(sender, e);
        }
    }
}