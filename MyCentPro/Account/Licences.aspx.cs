﻿using System;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using Microsoft.AspNet.Identity;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Drawing;


namespace MyCentPro
{
    public partial class Licences : Page
    {
        SqlDataAdapter da;
        DataSet ds = new DataSet();
        SqlCommand cmd = new SqlCommand();
        LogWriter logWriter = new LogWriter();
        int action = -1;
        int id = -1;


        protected void Page_Load(object sender, EventArgs e)
        {
            if ((System.Web.HttpContext.Current.User != null) && System.Web.HttpContext.Current.User.Identity.IsAuthenticated)
            {
                string aspID = HttpContext.Current.User.Identity.GetUserId().ToString();
                logWriter.OpenDBConnection();
                logWriter.WriteToLog(aspID, "User accessed Licences.aspx.");
            }

            if (!Page.IsPostBack)
            {
                if (Request.QueryString.Count >= 1)
                {
                    action = Int32.Parse(Request.QueryString["action"]);
                    id = Int32.Parse(Request.QueryString["eId"]);

                    // Action list:
                    // 0 = reserved
                    // 1 = edit
                    // 2 = delete
                    string sAction;
                    switch (action)
                    {
                        case 1:
                            sAction = "rediger";
                            //remove stuff we don't want now...
                            licenceGridView.Visible = false;
                            licenseHeading.Visible = false;
                            jumbotron.Visible = false;
                            eUl.Visible = false;

                            //show the stuff we want
                            addOrEdit.Visible = true;
                            eIdLabel.Text = "action: " + sAction + ", eID: " + id;
                            eIdLabel.Visible = true;
                            break;
                        case 2:
                            sAction = "slett";
                            //remove stuff we don't want now...
                            licenceGridView.Visible = false;
                            licenseHeading.Visible = false;
                            jumbotron.Visible = false;
                            eUl.Visible = false;

                            //show the stuff we want
                            addOrEdit.Visible = true;
                            eIdLabel.Text = "action: " + sAction + ", eID: " + id;
                            eIdLabel.Visible = true;
                            break;
                        default:
                            break;
                    }
                }
                else
                {
                    addOrEdit.Visible = false;
                    //eIdLabel.Text = "action: " + action + ", eID: " + id;
                    eIdLabel.Visible = false;
                    BindData();
                }
            }

            //do not display red slide-down
            errUl.Visible = false;

            //update dynamic text on page for warnings and stuff...
            licCounter.InnerText = "4";
            userName.InnerText = User.Identity.Name;
            expMonths.InnerText = "3"; // [HARDCODED]
        }

        public SqlConnection OpenDBConnection()
        {
            SqlConnection con = null;
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
            SqlConnection con = null;
            try
            {
                //instantiate connection
                con = OpenDBConnection();
                cmd = new SqlCommand();

                //define query
                cmd.CommandText =   "SELECT l.owner_uID, u.aspID, p.Name as 'Produsent', t.TypeName as 'Lisenstype', l.Qty as 'Antall', " +
                                    "l.DateFrom as 'Gyldig fra', l.DateTo as 'Gyldig til', u.Name as 'Eier', a.aID as 'AvtaleID', a.AgreementName as 'Avtale', c.cID, c.Name as 'Kontaktperson' " +
                                    "FROM Licenses l " +
                                    "JOIN Types t ON l.tID = t.tID " +
                                    "JOIN Producer p ON l.pID = p.pID " +
                                    "JOIN Users u ON l.owner_uID = u.uID " +
                                    "JOIN Contacts c ON l.cID = c.cID " +
                                    "JOIN Agreements a ON l.aID = a.aID";
                                    /*WHERE u.aspID = '3db8543c-c0d2-49ff-b7a2-6d794a7358ba'*/ /* Jon Roar Odden */
                                    /*WHERE u.aspID = 'f84e76b3-aada-4a50-96c0-79a092173491'*/ /* Thomas Rofstad */
                cmd.Connection = con;

                //get license data
                da = new SqlDataAdapter(cmd);
                da.Fill(ds);
                con.Open();
                cmd.ExecuteNonQuery();
                Session["LicenseTable"] = ds;

                licenceGridView.DataSource = ds;
                licenceGridView.DataBind();
                //close and cleanup
                con.Close();

                //define query
                /*
                cmd.CommandText = "SELECT nID, dNotificationTime AS 'Varsel', " +
                                    "(SELECT DATEDIFF(DAY, GETDATE(), CONVERT(DATE,((SELECT n.dNotificationTime FROM Notifications n WHERE n.nID=1))))) AS 'Dager til utløp' " +
                                    "FROM Notifications WHERE nID = 1";
                cmd.Connection = con;

                //get license notifications
                da.Fill(ds);
                con.Open();
                cmd.ExecuteNonQuery();
                Session["NotificationTable"] = ds;
                //close and cleanup
                con.Close();
                */
            }
            catch (SqlException )
            {
                //debug SQL error message. Should be removed before release. -jr
                //FailureText.Text = sqlex.Message;
                //ErrorMessage.Visible = true;

            }
            finally
            {
                con.Close();
            }
        }

        protected void ExportToExcel2007()
        {
            
        }

        protected void ExportToExcel2003(object sender, EventArgs e)
        {
            //LogWriter lw = new LogWriter();
            //lw.WriteToLog(userInfo, "Dette er en logentry rett fra kode.");

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
                licenceGridView.AllowPaging = false;
                BindData();

                licenceGridView.HeaderRow.BackColor = Color.White;
                foreach (TableCell cell in licenceGridView.HeaderRow.Cells)
                {
                    cell.BackColor = licenceGridView.HeaderStyle.BackColor;
                }

                foreach (GridViewRow row in licenceGridView.Rows)
                {
                    row.BackColor = Color.White;
                    foreach (TableCell cell in row.Cells)
                    {
                        if (row.RowIndex % 2 == 0)
                        {
                            cell.BackColor = licenceGridView.AlternatingRowStyle.BackColor;
                        }
                        else
                        {
                            cell.BackColor = licenceGridView.RowStyle.BackColor;
                        }
                        cell.CssClass = "textmode";
                    }
                }

                //licenceGridView.RenderControl(hw);
                licenceGridView.RenderBeginTag(hw);
                licenceGridView.HeaderRow.RenderControl(hw);
                foreach (GridViewRow row in licenceGridView.Rows)
                {
                    row.RenderControl(hw);
                }
                licenceGridView.FooterRow.RenderControl(hw);
                licenceGridView.RenderEndTag(hw);

                //style to format numbers to string
                string style = @"<style> .textmode { } </style>";
                Response.Write(style);
                Response.Output.Write(sw.ToString());
                Response.Flush();
                Response.End();

                //log it
                string aspID = HttpContext.Current.User.Identity.GetUserId().ToString();
                logWriter.OpenDBConnection();
                logWriter.WriteToLog(aspID, "User exported licenses to Excel.");
            }
        }

        public override void VerifyRenderingInServerForm(Control control)
        {
            /* Confirms that an HtmlForm control is rendered for the specified ASP.NET
               server control at run time. */
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

        protected void licenceGridView_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            //ClientScript.RegisterStartupScript(GetType(), "AlertMessage", "callAlert('Hello world!');", true);
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "<SCRIPT LANGUAGE='javascript'>alert('Hello world!');</script>", false);

            Response.Redirect("Licences.aspx?action=2&eId=" + e.RowIndex, false);
            Context.ApplicationInstance.CompleteRequest();    
        }

        protected void RowDelete(object sender, GridViewDeleteEventArgs e)
        {
            SqlConnection conn = OpenDBConnection();
            GridViewRow row = (GridViewRow)licenceGridView.Rows[e.RowIndex];
            Label lbldeleteid = (Label)row.FindControl("lID");

            SqlConnection con = OpenDBConnection();
            con.Open();
            SqlCommand cmd = new SqlCommand("delete FROM Licences where lID='" + Convert.ToInt32(licenceGridView.DataKeys[e.RowIndex].Value.ToString()) + "'", con);
            cmd.ExecuteNonQuery();

            con.Close();
            BindData();

            //log it
            string aspID = HttpContext.Current.User.Identity.GetUserId().ToString();
            logWriter.OpenDBConnection();
            logWriter.WriteToLog(aspID, "User deleted a license with lID = " + Convert.ToInt32(licenceGridView.DataKeys[e.RowIndex].Value.ToString()));
        }

        protected void licenceGridView_RowEditing(object sender, GridViewEditEventArgs e)
        {
            Response.Redirect("Licences.aspx?action=1&eId=" + e.NewEditIndex, false);
            Context.ApplicationInstance.CompleteRequest();

            //log it
            string aspID = HttpContext.Current.User.Identity.GetUserId().ToString();
            logWriter.OpenDBConnection();
            logWriter.WriteToLog(aspID, "User initiated edit of license with lID = " + Convert.ToInt32(licenceGridView.DataKeys[e.NewEditIndex].Value.ToString()));
        }

        protected void licenceGridView_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            licenceGridView.PageIndex = e.NewPageIndex;
            BindData();
        }

        protected void licenceGridView_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            licenceGridView.EditIndex = -1;
            BindData();
        }

        protected void licenceGridView_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            SqlConnection con = OpenDBConnection();
            GridViewRow row = licenceGridView.Rows[e.RowIndex];

            //Retrieve the table from the session object.
            DataTable dt = (DataTable)Session["Licence"];
            
            Label lbllID = (Label)row.FindControl("lbllID");
            //TextBox txtname=(TextBox)gr.cell[].control[];
            TextBox txtOwner = (TextBox)row.Cells[0].Controls[0];
            TextBox txtCount = (TextBox)row.Cells[1].Controls[0];
            //TextBox textc = (TextBox)row.Cells[2].Controls[0]; //JRO removed
            //TextBox textadd = (TextBox)row.FindControl("txtadd");
            //TextBox textc = (TextBox)row.FindControl("txtc");
            licenceGridView.EditIndex = -1;

            con.Open();
            //SqlCommand cmd = new SqlCommand("SELECT * FROM detail", con);
            SqlCommand cmd = new SqlCommand("UPDATE Licences SET owner_uID=" + Int16.Parse(txtOwner.Text) + ", lCount=" + Int16.Parse(txtCount.Text) + " where lID=" + lbllID.Text, con);
            cmd.ExecuteNonQuery();

            con.Close();
            BindData();
        }

        protected void sqltestbtn_Click(object sender, EventArgs e)
        {
            try
            {
                SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ApplicationServices"].ConnectionString);
                connection.Open();

                if (connection.State == System.Data.ConnectionState.Open)
                {
                    Response.Write("Connection successful!");
                    Console.Write("Connection successful!");
                    connection.Close();
                }
                else
                {
                    Response.Write("No connection...");
                    Console.Write("No connection...");
                }
            }
            catch
            {
                Response.Write("Connection string: " + ConfigurationManager.ConnectionStrings["ApplicationServices"].ToString() + "\r\nCatched a try: No connection. Timed out without response...");
                Console.Write("Connection string: " + ConfigurationManager.ConnectionStrings["ApplicationServices"].ToString() + "\r\nCatched a try: No connection. Timed out without response...");
            }
        }

        protected void lnkbExportToExcel_Click(object sender, EventArgs e)
        {
            ExportToExcel2003(sender, e);
        }

        protected void dataListNotifications_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}