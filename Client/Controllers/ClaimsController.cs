using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Identity.Web;
using System.Security.Claims;
using System.Threading.Tasks;
using TodoListClient.Models;
using TodoListClient.Services;
using TodoListService.Models;

namespace TodoListClient.Controllers
{
    [Authorize]
    public class ClaimsController : Controller
    {

        private readonly ITokenAcquisition tokenAcquisition;
        public ClaimsController(ITokenAcquisition tokenAcquisition)
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


    }
}