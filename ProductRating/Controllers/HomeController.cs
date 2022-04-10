using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using ProductRating.Helper;
using ProductRating.Interface;
using ProductRating.Models;

namespace ProductRating.Controllers
{
    [AuthorizeUser()]
    public class HomeController : Controller
    {
        private IRepository _repository;
        private readonly ILogger<HomeController> _logger;

        public HomeController(ILogger<HomeController> logger, IRepository repository)
        {
            _logger = logger;
            _repository = repository;
        }

        public IActionResult Index()//products list
        {
            SpResult result = new SpResult();
            string spName = "[dbo].[usp_Product]";
            try
            {
                result = _repository.ResultsWithErrorCode<Product>(spName, new { Flag = "a" });
            }
            catch (Exception ex)
            {
                result.errorcode = 1;
                result.mes = ex.Message;
            }

            //return Json(result);
            return View(result);
        }
        [HttpPost]
        public IActionResult RateProduct(Models.ProductRating entry)
        {
            SpResult result = new SpResult();
            string spName = "[dbo].[usp_ProductRating]";
            try
            {
                result = _repository.ResultWithErrorCode<Models.ProductRating>(spName, new { Flag = "r", entry.RatingRemarks, entry.Ratings,entry.ProductID,UserID=new sessionExcessor().getCurUserId(HttpContext.Session) });
            }
            catch (Exception ex)
            {
                result.errorcode = 1;
                result.mes = ex.Message;
            }

            return Json(result);
        }

        public IActionResult RateReport()
        {
            return View();
        }
        [HttpPost]
        public IActionResult RateReportData(DataTableParameter dtParam)
        {
            var dtReturn = _repository.GetPagedDt<RatingReport>("[dbo].[usp_ProductRating]", dtParam);
            return Json(new { draw = dtParam.draw, recordsTotal = dtReturn.rowCount.recordsTotal, recordsFiltered = dtReturn.rowCount.recordsFiltered, data = dtReturn.data });
        }

        public IActionResult Privacy()
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
