using Microsoft.AspNet.Identity;
using Microsoft.Owin.Security;
using System;
using System.Web;
using System.Web.UI;
using MyCentPro;

public partial class Account_Login : Page
{

    LogWriter logWriter = new LogWriter();

    //global::MyCentPro.UserInfo userInfo;
    protected void Page_Load(object sender, EventArgs e)
    {
        RegisterHyperLink.NavigateUrl = "Register";
        OpenAuthLogin.ReturnUrl = Request.QueryString["ReturnUrl"];
        var returnUrl = HttpUtility.UrlEncode(Request.QueryString["ReturnUrl"]);
        if (!String.IsNullOrEmpty(returnUrl))
        {
            RegisterHyperLink.NavigateUrl += "?ReturnUrl=" + returnUrl;
        }
    }

protected void LogIn(object sender, EventArgs e)
{
    if (IsValid)
    {
        var manager = new UserManager();
        ApplicationUser user = manager.Find(UserName.Text, Password.Text);

        if (user != null)
        {
                IdentityHelper.SignIn(manager, user, RememberMe.Checked); //moved from within try
                //populate a new UserInfo object to use in the application... -jr
                UserInfo u = new UserInfo();
                u.AspID = user.Id;
                u.Name = user.UserName;
                u.Phone = user.PhoneNumber;
                Application["aspID"] = user.Id;

                //log it
                logWriter.OpenDBConnection();
                logWriter.WriteToLog(user.Id, "Successfull login.");

                //return
                IdentityHelper.RedirectToReturnUrl(Request.QueryString["ReturnUrl"], Response);
            }
        }
        else
        {
            //the line below generates pop-up with error. -jr
            //this.Page.ClientScript.RegisterStartupScript(this.GetType(), "ex", "alert('Feil brukernavn eller passord.');", true);
            FailureText.Text = "Ugyldig brukernavn eller passord.";
            ErrorMessage.Visible = true;

            //log it
            string aspID = HttpContext.Current.User.Identity.GetUserId().ToString();
            logWriter.OpenDBConnection();
            logWriter.WriteToLog(aspID, "Failed login for user '" + UserName.Text.ToString() + "'");
        }
    }
}