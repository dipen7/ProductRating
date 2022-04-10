using Dapper;
using ProductRating.Interface;
using ProductRating.Models;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Reflection;
using static Dapper.SqlMapper;

namespace ProductRating.Implimentation
{
    public class Repository : IRepository
    {
        public Repository(IConfiguration configuration)
        {
            con = new SqlConnection(configuration.GetConnectionString("DefaultConnection"));
        }
        public SqlConnection con;
        public List<T> ExecuteAndReturnList<T>(string query, DynamicParameters param = null)
        {
            try
            {
                IList<T> list = SqlMapper.Query<T>(con, query, param, commandType: CommandType.StoredProcedure).ToList();
                return list.ToList();
            }
            catch (Exception)
            {
                throw;
            }
        }
        public SpResult ResultWithErrorCode<T>(string query, dynamic param)
        {
            SpResult returnDT1=new SpResult() {errorcode=1 };
            List<T> returnDT2 = new List<T>();
            try
            {
                var gridReader = SqlMapper.QueryMultiple(con, query, (object)param, commandType: CommandType.StoredProcedure);
                returnDT1 = gridReader.Read<SpResult>().ToList().FirstOrDefault();
                if (!gridReader.IsConsumed)
                {
                    returnDT1.result = gridReader.Read<T>().ToList().FirstOrDefault();
                }
            }
            catch (Exception ex)
            {
                returnDT1.mes = ex.Message;
            }
            return returnDT1;
        }
        public SpResult ResultsWithErrorCode<T>(string query, dynamic param)
        {
            SpResult returnDT1 = new SpResult() { errorcode = 1 };
            List<T> returnDT2 = new List<T>();
            try
            {
                var gridReader = SqlMapper.QueryMultiple(con, query, (object)param, commandType: CommandType.StoredProcedure);
                returnDT1 = gridReader.Read<SpResult>().ToList().FirstOrDefault();
                if (!gridReader.IsConsumed)
                {
                    returnDT1.result = gridReader.Read<T>().ToList();
                }
            }
            catch (Exception ex)
            {
                returnDT1.mes = ex.Message;
            }
            return returnDT1;
        }
        public DataTableParamWithCount<T> GetPagedDt<T>(string query, DataTableParameter dtParam)
        {
            DataTableParamWithCount<T> returnDT = new DataTableParamWithCount<T>();
            DynamicParameters param = new DynamicParameters();
            if (!string.IsNullOrWhiteSpace(dtParam.search?.value))
                param.AddDynamicParams(new { searchText = dtParam.search.value });
            else
                param.AddDynamicParams(new { searchText = "" });
            param.AddDynamicParams(new { flag = "t", skip = dtParam?.start ?? 0, take = dtParam?.length ?? 10 });
            if (dtParam.order != null && dtParam.order.Count > 0)
            {
                param.AddDynamicParams(new { sortColumn = dtParam.columns[dtParam.order[0].column].data, sortOrder = dtParam.order[0].dir });
            }
            try
            {
                var gridReader = ExecuteAndReturnGridList(query, param);
                var OriginalDT = gridReader.Read<T>();
                returnDT.rowCount = gridReader.ReadSingleOrDefault<DataRowCount>();
                if (OriginalDT != null && OriginalDT.Count() > 0)
                {
                    returnDT.data = OriginalDT.ToList();
                }
                return returnDT;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public GridReader ExecuteAndReturnGridList(string query, DynamicParameters param = null)
        {
            try
            {
                GridReader gridList = SqlMapper.QueryMultiple(con, query, param, commandType: CommandType.StoredProcedure);
                return gridList;
            }
            catch (Exception ex)
            {
                throw;
            }
        }
    }
}
