using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(MyCentPro.Startup))]
namespace MyCentPro
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
