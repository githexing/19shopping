using DataAccess;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text;

namespace lgk.DAL
{/// <summary>
 /// 数据访问类:tb_FhDian
 /// </summary>
    public partial class tb_FhDian
    {
        public tb_FhDian()
        { }
        #region  BasicMethod
        /// <summary>
        /// 是否存在该记录
        /// </summary>
        public bool Exists(long ID)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select count(1) from tb_FhDian");
            strSql.Append(" where ID=@ID");
            SqlParameter[] parameters = {
                    new SqlParameter("@ID", SqlDbType.BigInt)
            };
            parameters[0].Value = ID;

            return DbHelperSQL.Exists(strSql.ToString(), parameters);
        }


        /// <summary>
        /// 增加一条数据
        /// </summary>
        public long Add(lgk.Model.tb_FhDian model)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("insert into tb_FhDian(");
            strSql.Append("UserID,OrderCode,Amount,TopMoney,SurplusMoney,AddTime,IsOut,IsBatch)");
            strSql.Append(" values (");
            strSql.Append("@UserID,@OrderCode,@Amount,@TopMoney,@SurplusMoney,@AddTime,@IsOut,@IsBatch)");
            strSql.Append(";select @@IDENTITY");
            SqlParameter[] parameters = {
                    new SqlParameter("@UserID", SqlDbType.BigInt,8),
                    new SqlParameter("@OrderCode", SqlDbType.VarChar,50),
                    new SqlParameter("@Amount", SqlDbType.Decimal,9),
                    new SqlParameter("@TopMoney", SqlDbType.Decimal,9),
                    new SqlParameter("@SurplusMoney", SqlDbType.Decimal,9),
                    new SqlParameter("@AddTime", SqlDbType.DateTime),
                    new SqlParameter("@IsOut", SqlDbType.Int,4),
                    new SqlParameter("@IsBatch", SqlDbType.Int,4)};
            parameters[0].Value = model.UserID;
            parameters[1].Value = model.OrderCode;
            parameters[2].Value = model.Amount;
            parameters[3].Value = model.TopMoney;
            parameters[4].Value = model.SurplusMoney;
            parameters[5].Value = model.AddTime;
            parameters[6].Value = model.IsOut;
            parameters[7].Value = model.IsBatch;

            object obj = DbHelperSQL.GetSingle(strSql.ToString(), parameters);
            if (obj == null)
            {
                return 0;
            }
            else
            {
                return Convert.ToInt64(obj);
            }
        }
        /// <summary>
        /// 更新一条数据
        /// </summary>
        public bool Update(lgk.Model.tb_FhDian model)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("update tb_FhDian set ");
            strSql.Append("UserID=@UserID,");
            strSql.Append("OrderCode=@OrderCode,");
            strSql.Append("Amount=@Amount,");
            strSql.Append("TopMoney=@TopMoney,");
            strSql.Append("SurplusMoney=@SurplusMoney,");
            strSql.Append("AddTime=@AddTime,");
            strSql.Append("IsOut=@IsOut,");
            strSql.Append("IsBatch=@IsBatch");
            strSql.Append(" where ID=@ID");
            SqlParameter[] parameters = {
                    new SqlParameter("@UserID", SqlDbType.BigInt,8),
                    new SqlParameter("@OrderCode", SqlDbType.VarChar,50),
                    new SqlParameter("@Amount", SqlDbType.Decimal,9),
                    new SqlParameter("@TopMoney", SqlDbType.Decimal,9),
                    new SqlParameter("@SurplusMoney", SqlDbType.Decimal,9),
                    new SqlParameter("@AddTime", SqlDbType.DateTime),
                    new SqlParameter("@IsOut", SqlDbType.Int,4),
                    new SqlParameter("@IsBatch", SqlDbType.Int,4),
                    new SqlParameter("@ID", SqlDbType.BigInt,8)};
            parameters[0].Value = model.UserID;
            parameters[1].Value = model.OrderCode;
            parameters[2].Value = model.Amount;
            parameters[3].Value = model.TopMoney;
            parameters[4].Value = model.SurplusMoney;
            parameters[5].Value = model.AddTime;
            parameters[6].Value = model.IsOut;
            parameters[7].Value = model.IsBatch;
            parameters[8].Value = model.ID;

            int rows = DbHelperSQL.ExecuteSql(strSql.ToString(), parameters);
            if (rows > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        /// <summary>
        /// 删除一条数据
        /// </summary>
        public bool Delete(long ID)
        {

            StringBuilder strSql = new StringBuilder();
            strSql.Append("delete from tb_FhDian ");
            strSql.Append(" where ID=@ID");
            SqlParameter[] parameters = {
                    new SqlParameter("@ID", SqlDbType.BigInt)
            };
            parameters[0].Value = ID;

            int rows = DbHelperSQL.ExecuteSql(strSql.ToString(), parameters);
            if (rows > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        /// <summary>
        /// 批量删除数据
        /// </summary>
        public bool DeleteList(string IDlist)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("delete from tb_FhDian ");
            strSql.Append(" where ID in (" + IDlist + ")  ");
            int rows = DbHelperSQL.ExecuteSql(strSql.ToString());
            if (rows > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }


        /// <summary>
        /// 得到一个对象实体
        /// </summary>
        public lgk.Model.tb_FhDian GetModel(long ID)
        {

            StringBuilder strSql = new StringBuilder();
            strSql.Append("select  top 1 ID,UserID,OrderCode,Amount,TopMoney,SurplusMoney,AddTime,IsOut,IsBatch from tb_FhDian ");
            strSql.Append(" where ID=@ID");
            SqlParameter[] parameters = {
                    new SqlParameter("@ID", SqlDbType.BigInt)
            };
            parameters[0].Value = ID;

            lgk.Model.tb_FhDian model = new lgk.Model.tb_FhDian();
            DataSet ds = DbHelperSQL.Query(strSql.ToString(), parameters);
            if (ds.Tables[0].Rows.Count > 0)
            {
                return DataRowToModel(ds.Tables[0].Rows[0]);
            }
            else
            {
                return null;
            }
        }


        /// <summary>
        /// 得到一个对象实体
        /// </summary>
        public lgk.Model.tb_FhDian DataRowToModel(DataRow row)
        {
            lgk.Model.tb_FhDian model = new lgk.Model.tb_FhDian();
            if (row != null)
            {
                if (row["ID"] != null && row["ID"].ToString() != "")
                {
                    model.ID = long.Parse(row["ID"].ToString());
                }
                if (row["UserID"] != null && row["UserID"].ToString() != "")
                {
                    model.UserID = long.Parse(row["UserID"].ToString());
                }
                if (row["OrderCode"] != null)
                {
                    model.OrderCode = row["OrderCode"].ToString();
                }
                if (row["Amount"] != null && row["Amount"].ToString() != "")
                {
                    model.Amount = decimal.Parse(row["Amount"].ToString());
                }
                if (row["TopMoney"] != null && row["TopMoney"].ToString() != "")
                {
                    model.TopMoney = decimal.Parse(row["TopMoney"].ToString());
                }
                if (row["SurplusMoney"] != null && row["SurplusMoney"].ToString() != "")
                {
                    model.SurplusMoney = decimal.Parse(row["SurplusMoney"].ToString());
                }
                if (row["AddTime"] != null && row["AddTime"].ToString() != "")
                {
                    model.AddTime = DateTime.Parse(row["AddTime"].ToString());
                }
                if (row["IsOut"] != null && row["IsOut"].ToString() != "")
                {
                    model.IsOut = int.Parse(row["IsOut"].ToString());
                }
                if (row["IsBatch"] != null && row["IsBatch"].ToString() != "")
                {
                    model.IsBatch = int.Parse(row["IsBatch"].ToString());
                }
            }
            return model;
        }

        /// <summary>
        /// 获得数据列表
        /// </summary>
        public DataSet GetList(string strWhere)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select ID,UserID,OrderCode,Amount,TopMoney,SurplusMoney,AddTime,IsOut,IsBatch ");
            strSql.Append(" FROM tb_FhDian ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" where " + strWhere);
            }
            return DbHelperSQL.Query(strSql.ToString());
        }

        /// <summary>
        /// 获得前几行数据
        /// </summary>
        public DataSet GetList(int Top, string strWhere, string filedOrder)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select ");
            if (Top > 0)
            {
                strSql.Append(" top " + Top.ToString());
            }
            strSql.Append(" ID,UserID,OrderCode,Amount,TopMoney,SurplusMoney,AddTime,IsOut,IsBatch ");
            strSql.Append(" FROM tb_FhDian ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" where " + strWhere);
            }
            strSql.Append(" order by " + filedOrder);
            return DbHelperSQL.Query(strSql.ToString());
        }

        /// <summary>
        /// 获取记录总数
        /// </summary>
        public int GetRecordCount(string strWhere)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select count(1) FROM tb_FhDian ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" where " + strWhere);
            }
            object obj = DbHelperSQL.GetSingle(strSql.ToString());
            if (obj == null)
            {
                return 0;
            }
            else
            {
                return Convert.ToInt32(obj);
            }
        }
        /// <summary>
        /// 分页获取数据列表
        /// </summary>
        public DataSet GetListByPage(string strWhere, string orderby, int startIndex, int endIndex)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("SELECT * FROM ( ");
            strSql.Append(" SELECT ROW_NUMBER() OVER (");
            if (!string.IsNullOrEmpty(orderby.Trim()))
            {
                strSql.Append("order by T." + orderby);
            }
            else
            {
                strSql.Append("order by T.ID desc");
            }
            strSql.Append(")AS Row, T.*  from tb_FhDian T ");
            if (!string.IsNullOrEmpty(strWhere.Trim()))
            {
                strSql.Append(" WHERE " + strWhere);
            }
            strSql.Append(" ) TT");
            strSql.AppendFormat(" WHERE TT.Row between {0} and {1}", startIndex, endIndex);
            return DbHelperSQL.Query(strSql.ToString());
        }

        /// <summary>
        /// 获得数据列表
        /// </summary>
        public DataSet GetUserList(string strWhere)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select u.UserID,u.UserCode,u.NiceName,ISNULL(Count(f.ID),0) as TotalLz, ");
            strSql.Append(" ISNULL((select Count(1) from tb_FhDian where UserID=u.UserID and IsOut=1),0) as OutLz, ");
            strSql.Append(" ISNULL((select Count(1) from tb_FhDian where UserID=u.UserID and IsOut=0),0) as InLz ");
            strSql.Append(" from tb_user as u left join tb_FhDian as f on u.UserID=f.UserID ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" where " + strWhere);
            }
            strSql.Append(" group by u.UserID,u.UserCode,u.NiceName ");
            return DbHelperSQL.Query(strSql.ToString());
        }

        /*
		/// <summary>
		/// 分页获取数据列表
		/// </summary>
		public DataSet GetList(int PageSize,int PageIndex,string strWhere)
		{
			SqlParameter[] parameters = {
					new SqlParameter("@tblName", SqlDbType.VarChar, 255),
					new SqlParameter("@fldName", SqlDbType.VarChar, 255),
					new SqlParameter("@PageSize", SqlDbType.Int),
					new SqlParameter("@PageIndex", SqlDbType.Int),
					new SqlParameter("@IsReCount", SqlDbType.Bit),
					new SqlParameter("@OrderType", SqlDbType.Bit),
					new SqlParameter("@strWhere", SqlDbType.VarChar,1000),
					};
			parameters[0].Value = "tb_FhDian";
			parameters[1].Value = "ID";
			parameters[2].Value = PageSize;
			parameters[3].Value = PageIndex;
			parameters[4].Value = 0;
			parameters[5].Value = 0;
			parameters[6].Value = strWhere;	
			return DbHelperSQL.RunProcedure("UP_GetRecordByPage",parameters,"ds");
		}*/

        #endregion  BasicMethod
        #region  ExtensionMethod

        #endregion  ExtensionMethod
    }
}