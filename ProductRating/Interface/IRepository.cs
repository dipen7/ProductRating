using Dapper;
using ProductRating.Models;
using System.Collections.Generic;
using System.Data;
using static Dapper.SqlMapper;

namespace ProductRating.Interface
{
    public interface IRepository
    {
        List<T> ExecuteAndReturnList<T>(string query, DynamicParameters param = null);
        public SpResult ResultWithErrorCode<T>(string query, dynamic param);
        public SpResult ResultsWithErrorCode<T>(string query, dynamic param);
        public DataTableParamWithCount<T> GetPagedDt<T>(string query, DataTableParameter dtParam);
    }
}
