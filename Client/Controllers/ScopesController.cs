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
    public class ScopesController : Controller
    {
        private ITodoListService _todoListService;
        
        public ScopesController(ITodoListService todoListService)
        {
             _todoListService = todoListService;
        }

        [AuthorizeForScopes(ScopeKeySection = "TodoList:TodoListScope")]
        public async Task<ActionResult> Index()
        {
            return View(await _todoListService.GetClaimsAsync());
        }


    }
}