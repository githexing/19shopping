﻿using System;
using System.Text;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Data;
using DataAccess;

namespace lgk.DAL
{
    //tb_FriendDynamicComment
    public partial class tb_FriendDynamicComment
    {

        public bool Exists(long ID)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select count(1) from tb_FriendDynamicComment");
            strSql.Append(" where ");
            strSql.Append(" ID = @ID  ");
            SqlParameter[] parameters = {
                    new SqlParameter("@ID", SqlDbType.BigInt)
            };
            parameters[0].Value = ID;

            return DbHelperSQL.Exists(strSql.ToString(), parameters);
        }



        /// <summary>
        /// 增加一条数据
        /// </summary>
        public long Add(lgk.Model.tb_FriendDynamicComment model)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("insert into tb_FriendDynamicComment(");
            strSql.Append("UserID,DynamicID,Content,AddTime,ToUserID");
            strSql.Append(") values (");
            strSql.Append("@UserID,@DynamicID,@Content,@AddTime,@ToUserID");
            strSql.Append(") ");
            strSql.Append(";select @@IDENTITY");
            SqlParameter[] parameters = {
                        new SqlParameter("@UserID", SqlDbType.BigInt,8) ,
                        new SqlParameter("@DynamicID", SqlDbType.BigInt,8) ,
                        new SqlParameter("@Content", SqlDbType.VarChar,-1) ,
                        new SqlParameter("@AddTime", SqlDbType.DateTime),
                        new SqlParameter("@ToUserID", SqlDbType.BigInt,8)

            };

            parameters[0].Value = model.UserID;
            parameters[1].Value = model.DynamicID;
            parameters[2].Value = model.Content;
            parameters[3].Value = model.AddTime;
            parameters[4].Value = model.ToUserID;

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
        public bool Update(lgk.Model.tb_FriendDynamicComment model)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("update tb_FriendDynamicComment set ");

            strSql.Append(" UserID = @UserID , ");
            strSql.Append(" DynamicID = @DynamicID , ");
            strSql.Append(" Content = @Content , ");
            strSql.Append(" AddTime = @AddTime  ");
            strSql.Append(" where ID=@ID ");

            SqlParameter[] parameters = {
                        new SqlParameter("@ID", SqlDbType.BigInt,8) ,
                        new SqlParameter("@UserID", SqlDbType.BigInt,8) ,
                        new SqlParameter("@DynamicID", SqlDbType.BigInt,8) ,
                        new SqlParameter("@Content", SqlDbType.VarChar,-1) ,
                        new SqlParameter("@AddTime", SqlDbType.DateTime)

            };

            parameters[0].Value = model.ID;
            parameters[1].Value = model.UserID;
            parameters[2].Value = model.DynamicID;
            parameters[3].Value = model.Content;
            parameters[4].Value = model.AddTime;
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
            strSql.Append("delete from tb_FriendDynamicComment ");
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
        /// 批量删除一批数据
        /// </summary>
        public bool DeleteList(string IDlist)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("delete from tb_FriendDynamicComment ");
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
        public lgk.Model.tb_FriendDynamicComment GetModel(long ID)
        {

            StringBuilder strSql = new StringBuilder();
            strSql.Append("select ID, UserID, DynamicID, Content, AddTime  ");
            strSql.Append("  from tb_FriendDynamicComment ");
            strSql.Append(" where ID=@ID");
            SqlParameter[] parameters = {
                    new SqlParameter("@ID", SqlDbType.BigInt)
            };
            parameters[0].Value = ID;


            lgk.Model.tb_FriendDynamicComment model = new lgk.Model.tb_FriendDynamicComment();
            DataSet ds = DbHelperSQL.Query(strSql.ToString(), parameters);

            if (ds.Tables[0].Rows.Count > 0)
            {
                if (ds.Tables[0].Rows[0]["ID"].ToString() != "")
                {
                    model.ID = long.Parse(ds.Tables[0].Rows[0]["ID"].ToString());
                }
                if (ds.Tables[0].Rows[0]["UserID"].ToString() != "")
                {
                    model.UserID = long.Parse(ds.Tables[0].Rows[0]["UserID"].ToString());
                }
                if (ds.Tables[0].Rows[0]["DynamicID"].ToString() != "")
                {
                    model.DynamicID = long.Parse(ds.Tables[0].Rows[0]["DynamicID"].ToString());
                }
                model.Content = ds.Tables[0].Rows[0]["Content"].ToString();
                if (ds.Tables[0].Rows[0]["AddTime"].ToString() != "")
                {
                    model.AddTime = DateTime.Parse(ds.Tables[0].Rows[0]["AddTime"].ToString());
                }

                return model;
            }
            else
            {
                return null;
            }
        }


        /// <summary>
        /// 获得数据列表
        /// </summary>
        public DataSet GetList(string strWhere)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select * ");
            strSql.Append(" FROM tb_FriendDynamicComment ");
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
            strSql.Append(" * ");
            strSql.Append(" FROM tb_FriendDynamicComment ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" where " + strWhere);
            }
            strSql.Append(" order by " + filedOrder);
            return DbHelperSQL.Query(strSql.ToString());
        }


    }
}

