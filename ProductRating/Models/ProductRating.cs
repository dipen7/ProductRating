using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ProductRating.Models
{
    public class ProductRating
    {
        public int ProductRatingID { get; set; }
        public string RatingRemarks { get; set; }
        public int UserID { get; set; }
        public int ProductID { get; set; }
        public int Ratings { get; set; }
    }
}
