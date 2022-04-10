using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Dapper;
using Microsoft.AspNetCore.Mvc;
using ProductRating.Helper;
using ProductRating.Interface;
using ProductRating.Models;

namespace ProductRating.Controllers
{
    public class AccountController : Controller
    {
        private IRepository _repository;
        public AccountController(IRepository repository)
        {
            _repository = repository;
        }
        public async Task<IActionResult> Login()
        {
            return View();
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Login(string username, string Password)
        {
            SpResult result = new SpResult();
            string spName = "[dbo].[usp_UserTable]";
            try
            {
                var LoggedUser = _repository.ResultWithErrorCode<UserLogin>(spName, new { Flag = "l", UserName = username, Password = Password });
                if (LoggedUser.errorcode == 0)
                {
                    new sessionExcessor().setUserSessionModel(HttpContext.Session, LoggedUser.result);
                    result.mes = "/home/index";
                }
                else
                {
                    result.errorcode = 1;
                    //Result.
                    result.mes = "invalid Username or password";
                }
            }
            catch (Exception ex)
            {
                result.errorcode = 1;
                result.mes = ex.Message;
            }

            return Json(result);
        }
        public async Task<IActionResult> Logout()
        {
            new sessionExcessor().delUserSessionModel(HttpContext.Session);
            return Redirect("login");
        }
    }
}