using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Text;
using Library;
using DataAccess;
namespace Web
{
    /// <summary>
    /// DataHandler 的摘要说明
    /// </summary>
    public class DataHandler : IHttpHandler
    {
        lgk.BLL.tb_user userBLL = new lgk.BLL.tb_user();
        lgk.BLL.tb_level levelBLL = new lgk.BLL.tb_level();
        lgk.BLL.tb_remit remitBll = new lgk.BLL.tb_remit();
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            string vist = context.Request.Params["UpdateRemit"];
            if (vist != "" && vist != null)
            {
                Delete(context);
            }
            else
            {
                string parm = context.Request.QueryString["type"];
                int uid = 0;
                bool root = false;
                try
                {
                    uid = Convert.ToInt32(context.Request.QueryString["id"]);
                    root = true;
                }
                catch (Exception)
                {

                    uid = Convert.ToInt32(context.Request.QueryString["uid"]);
                    root = false;
                }
                if (parm.Equals("tree"))
                {
                    DataTreeView(context, Convert.ToInt32(uid), root);
                }
            }

        }
        public void Delete(HttpContext context)
        {
            string remitid = context.Request.Params["remitID"];
            string msg = "";
            if (remitid != "" || remitid != null)
            {
                remitBll.Delete(Convert.ToInt32(remitid));
                msg = "success";
            }
            else
            {
                msg = "fail";
            }
            context.Response.Write(msg);
        }
        public void DataTreeView(HttpContext context, int uid, bool root)
        {
            string Treetext = TreeMethod(context, uid, root);
            context.Response.Write("[{" + Treetext + "}]");
        }
        #region 加载tree节点
        /// <summary>
        /// 加载tree节点
        /// </summary>
        /// <param name="context"></param>
        /// <param name="uid"></param>
        /// <returns></returns>
        private string TreeMethod(HttpContext context, int uid, bool root)
        {

            StringBuilder sb = new StringBuilder();
            string where = "";
            string tage = context.Request.QueryString["tage"];
            string UserCode = context.Request.QueryString["UserCode"];
            if (tage == "qt")
            {
                lgk.Model.tb_user us = userBLL.GetModel(Convert.ToInt32(context.Request.QueryString["uid"]));
                where = " and Layer <= " + (us.Layer + 3);
            }

            string treeTxte = "";

            if (root)
            {
                IList<lgk.Model.tb_user> list = userBLL.GetModelList(" RecommendID = " + userBLL.GetModel(uid).UserID + where);
                for (int i = 0; i < list.Count; i++)
                {
                    //        //sb.Append(TreeMethod(context, Convert.ToInt32(list[i].UserID)));
                    IList<lgk.Model.tb_user> list2 = userBLL.GetModelList(" RecommendID = " + userBLL.GetModel(list[i].UserID).UserID + where);
                    if (list2.Count > 0)
                    {
                        sb.Append("\"text\":\"" + Treetext(Convert.ToInt32(list[i].UserID)) + "\",\"children\":true,\"id\":\"" + list[i].UserID + "\"");
                    }
                    else
                    {
                        sb.Append("\"text\":\"" + Treetext(Convert.ToInt32(list[i].UserID)) + "\"");
                    }

                    if (i != list.Count - 1)
                    {
                        sb.AppendLine("},{");
                    }
                }
            }
            else
            {
                if (UserCode != null && UserCode != "")
                {
                    lgk.Model.tb_user us = userBLL.GetModel("UserCode='" + UserCode + "'");
                    if (us == null)
                    {
                        return "会员不存在";
                    }
                    uid = Convert.ToInt32(us.UserID);
                }
                IList<lgk.Model.tb_user> list = userBLL.GetModelList(" RecommendID = " + userBLL.GetModel(uid).UserID + where);
                treeTxte = Treetext(uid);
                sb.Append("\"text\":\"" + treeTxte + "\",\"expanded\":\"false\"");
                if (list.Count != 0)
                {
                    sb.Append(",\"children\":[{");
                    for (int i = 0; i < list.Count; i++)
                    {
                        //        //sb.Append(TreeMethod(context, Convert.ToInt32(list[i].UserID)));
                        IList<lgk.Model.tb_user> list2 = userBLL.GetModelList(" RecommendID = " + userBLL.GetModel(list[i].UserID).UserID + where);
                        if (list2.Count > 0)
                        {
                            sb.Append("\"text\":\"" + Treetext(Convert.ToInt32(list[i].UserID)) + "\",\"children\":true,\"id\":\"" + list[i].UserID + "\"");
                        }
                        else
                        {
                            sb.Append("\"text\":\"" + Treetext(Convert.ToInt32(list[i].UserID)) + "\"");
                        }

                        if (i != list.Count - 1)
                        {
                            sb.AppendLine("},{");
                        }
                    }

                    sb.Append("}]");
                }
            }
            return sb.ToString();
        }
        #endregion
        public string Treetext(int uid)
        {
            AllCore allcore = new AllCore();
            string treeTxte = "";
            lgk.Model.tb_user Model = userBLL.GetModel(uid);

            if (Model == null)
            {
                return null;
            }
            
            string dd = "";
            // decimal allEmoney = 0;
            // allEmoney =userBLL.GetEmeony(uid);
            //if (Model.IsOpend == 0)
            //{
            //    if (allcore.GetLanguage("LoginLable") == "zh-cn")
            //    {
            //        dd = "[<span style='color:red;'>未激活</span>]";
            //    }
            //    else
            //    {
            //        dd = "[<span style='color:red;'>Not Yet Actived</span>]";
            //    }
            //}
            //else if (Model.IsOpend == 2)
            //{
            //    if (allcore.GetLanguage("LoginLable") == "zh-cn")
            //    {
            //        dd = "已激活";
            //    }
            //    else
            //    {
            //        dd = "[Active]";
            //    }
            //}
            if (uid == 0)
            {
                return null;
            }
            else
            {
                string enlevel = "";
                if (Model.LevelID == 0)
                {
                    enlevel = "无等级";
                }
                else
                {
                    enlevel = levelBLL.GetModel(Model.LevelID).LevelName;
                }
                if (allcore.GetLanguage("LoginLable") == "zh-cn")
                {
                        treeTxte = Model.UserCode + "[" + Model.NiceName + "][" + enlevel + "]" + dd;
                    
                    //treeTxte = Model.UserCode + "[姓名：" + Model.TrueName + " | 级别：" + enlevel + " | 状态：" + dd + "";
                }
                else
                {
                    enlevel = levelBLL.GetModel(Model.LevelID).level03;
                    treeTxte = Model.UserCode + "[" + Model.NiceName + "][" + enlevel + "]" + dd;
                    //treeTxte = Model.UserCode + "[姓名：" + Model.TrueName + " | 级别：" + enlevel + " | 状态：" + dd + "";
                }
                //node.NavigateUrl = "RecommendTree.aspx?userid=" + Model.UserID;
            }
            return treeTxte;
        }
        public int getLoginID(HttpContext context)
        {
            if (context.Request.Cookies["A128076_user"] != null)
            {
                return Convert.ToInt32(context.Request.Cookies["A128076_user"]["Id"]);
            }
            else
            {
                return 0;
            }

        }
        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}