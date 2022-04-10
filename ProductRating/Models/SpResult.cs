using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ProductRating.Models
{
    public class SpResult
    {
        public int errorcode { get; set; }
        public string mes { get; set; }
        public dynamic result { get; set; }
    }
}
