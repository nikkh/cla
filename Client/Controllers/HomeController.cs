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
    [AllowAnonymous]
    public class HomeController : Controller
    {
        
        public HomeController()
        {
           
        }

        public IActionResult Index()
        {
            return View();
        }

        
        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}