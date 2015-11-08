using Microsoft.AspNet.Identity;
using Microsoft.Owin.Security;
using System;
using System.Web;
using System.Web.UI;
using MyCentPro;

public partial class Account_Login : Page
{
    //global::MyCentPro.UserInfo userInfo;

    protected void Page_Load(object sender, EventArgs e)
    {
        RegisterHyperLink.NavigateUrl = "Registrer";
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
            // Validate the user password
            var manager = new UserManager();
            ApplicationUser user = manager.Find(UserName.Text, Password.Text);
            if (user != null)
            {
                IdentityHelper.SignIn(manager, user, RememberMe.Checked);
                //populate a new UserInfo object to use in the application... JRO
                UserInfo u = new UserInfo();
                u.AspID = user.Id;
                u.Name = user.UserName;
                u.Phone = user.PhoneNumber;
                Application["aspID"] = user.Id;

                IdentityHelper.RedirectToReturnUrl(Request.QueryString["ReturnUrl"], Response);
            }
            else
            {
                FailureText.Text = "Ugyldig brukernavn eller passord.";
                ErrorMessage.Visible = true;
            }
        }
    }
}