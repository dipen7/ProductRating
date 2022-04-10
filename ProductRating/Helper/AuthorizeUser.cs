using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ProductRating.Helper
{
    public class AuthorizeUserAttribute : TypeFilterAttribute
    {
        public AuthorizeUserAttribute() : base(typeof(AuthorizeUserFilter))
        {
        }
    }

    public class AuthorizeUserFilter : IAuthorizationFilter
    {
        public AuthorizeUserFilter()
        {
        }
        public void OnAuthorization(AuthorizationFilterContext context)
        {
            var userSessionStr = context.HttpContext.Session.GetString("SessionUser");
            if (string.IsNullOrWhiteSpace(userSessionStr))
            {
                context.Result = new RedirectResult("~/Account/Login");
                return;
            }
        }
    }
    public class UserSessionModel
    {
        public int UserID { get; set; }
        public string UserName { get; set; }
        public int FullName { get; set; }
    }
}
