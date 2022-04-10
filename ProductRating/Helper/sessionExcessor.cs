using Microsoft.AspNetCore.Http;
using Newtonsoft.Json;
using ProductRating.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ProductRating.Helper
{
    public class sessionExcessor
    {
        public int getCurUserId(ISession session)
        {
            var userSessionModel = JsonConvert.DeserializeObject<UserLogin>(session.GetString("SessionUser"));
            return userSessionModel.UserID;
        }
        public void setUserSessionModel(ISession session, UserLogin sessionObj, string sessionKey = "SessionUser")
        {
            session.SetString(sessionKey, JsonConvert.SerializeObject(sessionObj));
        }
        public void delUserSessionModel(ISession session, string sessionKey = "SessionUser")
        {
            session.SetString(sessionKey, string.Empty);
        }
    }
}
