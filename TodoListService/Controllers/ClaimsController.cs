using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Identity.Web;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;
using TodoListService.Models;

namespace TodoListService.Controllers
{
    [Authorize]
    [Route("api/[controller]")]
    public class ClaimsController : ControllerBase
    {
       
        private readonly IHttpContextAccessor _contextAccessor;

        public ClaimsController(IHttpContextAccessor contextAccessor)
        {
            this._contextAccessor = contextAccessor;
        }

        // GET: api/values
        [HttpGet]
        public IActionResult Get()
        {
            var claims = new Dictionary<string, string>();
            ClaimsPrincipal cp = (ClaimsPrincipal)HttpContext.User;
            foreach (var item in cp.Claims)
            {
                claims.Add(item.Type, item.Value);
            }
            return Ok(claims);
        }

        
       
    }
}