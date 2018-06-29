﻿/*********************************************************************************
* Copyright(c)  	2012 RJ.COM
 * 创建日期：		2012-5-15 11:28:14 
 * 文 件 名：		ProManage.cs 
 * CLR 版本: 		2.0.50727.3053 
 * 创 建 人：		King
 * 文件版本：		1.0.0.0
 * 修 改 人： 
 * 修改日期： 
 * 备注描述：         
***************************************************************************/
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Library;
using System.Data;
using System.Data.SqlClient;

namespace Web.admin.team
{
    public partial class ProManage : AdminPageBase//System.Web.UI.Page
    {
        public int mk = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            jumpMain(this, 11, getLoginID());//权限
            spd.jumpAdminUrl1(this.Page, 1);//跳转三级密碼
            if (!IsPostBack)
            {

                //bind_pro1();
                bind_pro();

                BindLevel();
                btnSearch.Text = GetLanguage("Search");//搜索
            }
        }
        protected string getLastLevel(int lastLevel)
        {
            try
            {
                return levelBLL.GetModel(lastLevel).LevelName;
            }
            catch (Exception)
            {
                return "";
            }
        }

        private void bind_pro()
        {
            string strWhere = " 1=1 ";//1 会员晋升 2 开通服务中心
            
            string StarTime = this.txtStar.Text.Trim();
            string EndTime = this.txtEnd.Text.Trim();
            if (txtUserCode.Text.Trim() != "")
            {
                strWhere += " and u.usercode like '%" + txtUserCode.Text.Trim() + "%'";
            }
            if (StarTime != "")
            {
                strWhere += string.Format(" and Convert(nvarchar(10),p.AddDate,120)  >= '" + StarTime + "'");
            }
            if (EndTime != "")
            {
                strWhere += string.Format(" and  Convert(nvarchar(10),p.AddDate,120)  <= '" + EndTime + "'");
            }
            else if (StarTime != "" && EndTime != "")
            {
                strWhere += " and u.usercode like '%" + txtUserCode.Text.Trim() + "%'";
                strWhere += string.Format(" and Convert(nvarchar(10),p.AddDate,120)  >= '" + StarTime + "'");
                strWhere += string.Format(" and  Convert(nvarchar(10),p.AddDate,120)  <= '" + EndTime + "'");
            }
            
            bind_repeater(GetProList(strWhere), Repeater1, "AddDate desc", tr1, AspNetPager1);
        }

        //private void bind_pro1()
        //{
        //    string strWhere = " 1=1";
        //    if(txtUserCode1.Text!="")
        //    {
        //        strWhere += " and u.usercode like '%" + txtUserCode1.Text.Trim() + "%'";
        //    }
        //    bind_repeater(GetProList(strWhere),Repeater1,"AddDate desc",tr1,AspNetPager1);
        //}

        //protected void btnSearch_Click(object sender, EventArgs e)
        //{
        //    this.label1.Text = "搜索";
        //    bind_pro();
        //}

        protected void AspNetPager1_PageChanged(object sender, EventArgs e)
        {
            bind_pro();
            //if(this.label1.Text=="提交")
            //{
            //    bind_pro1();
            //}
            //else if(this.label1.Text=="搜索")
            //{
            //    bind_pro();
            //}

        }
        protected void btnSumit_Click(object sender, EventArgs e)
        {
            lgk.Model.tb_userPro upModel = new lgk.Model.tb_userPro();
            lgk.Model.tb_user userInfo = userBLL.GetModelByUserCode(TxtCode.Text.Trim());
            if (userInfo == null)
            {
                ScriptManager.RegisterStartupScript(this.Page, typeof(Page), "info", "alert('会员不存在!');", true);
                return;
            }
            upModel.ProMoney = 0;//Convert.ToInt32(txtMoney.Text);
            int endLevl = Convert.ToInt32(dropLevel.SelectedValue);

            if (endLevl == userInfo.LevelID)
            {
                ScriptManager.RegisterStartupScript(this.Page, typeof(Page), "info", "alert('选择与当前不同的等级!');", true);
                return;
            }

            if (flag_pro(userInfo.UserID, endLevl, 1))
            {
                ScriptManager.RegisterStartupScript(this.Page, typeof(Page), "info", "alert('操作成功!');", true);
                bind_pro();
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, typeof(Page), "info", "alert('操作失败!');", true);
                return;
            }
        }
        /// <summary>
        /// 绑定会员级别
        /// </summary>
        private void BindLevel()
        {
            IList<lgk.Model.tb_level> list = new lgk.BLL.tb_level().GetModelList("");
            dropLevel.Items.Clear();
            ListItem li = new ListItem();
            li.Value = "0";
            li.Text = "-请选择-";
            dropLevel.Items.Add(li);
            foreach (lgk.Model.tb_level item in list)
            {
                ListItem items = new ListItem();
                items.Value = item.LevelID.ToString();
                items.Text = item.LevelName;
                dropLevel.Items.Add(items);

            }
        }
        protected void dropLevel_SelectedIndexChanged(object sender, EventArgs e)
        {
            //if (dropLevel.SelectedValue == "0")
            //{
            //    txtMoney.Text = "";
            //}
            //else
            //{
            //    txtMoney.Text = getParamAmount("Level" + dropLevel.SelectedValue).ToString();
            //}
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            bind_pro();
        }
    }
}
