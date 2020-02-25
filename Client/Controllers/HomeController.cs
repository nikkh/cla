using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Identity.Web;
using System.Diagnostics;
using System.Linq;
using System.Security.Claims;
using TodoListClient.Models;
using WebApp_OpenIDConnect_DotNet.Models;

namespace WebApp_OpenIDConnect_DotNet.Controllers
{
    [Authorize]
    public class HomeController : Controller
    {
        private readonly ITokenAcquisition tokenAcquisition;

        public HomeController(ITokenAcquisition tokenAcquisition)
        {
            this.tokenAcquisition = tokenAcquisition;
        }

        public IActionResult Index()
        {
            IdentityModel identityModel = new IdentityModel();
            identityModel.Test1 = "this is the value for test1";
            identityModel.Blah = "this is the value for test2";
           
            ClaimsPrincipal cp = (ClaimsPrincipal)HttpContext.User;
            foreach (var item in cp.Claims)
            {
                identityModel.Data.Add(item.Type, item.Value);
            }

            return View(identityModel);
        }

        [AllowAnonymous]
        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}