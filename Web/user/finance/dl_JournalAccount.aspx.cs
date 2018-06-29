/*********************************************************************************
*Copyright(c) 	2012 RJ.COM
 * 创建日期：		2012-6-6 16:01:41
 * 文 件 名：		dl_JournalAccount.cs
 * CLR 版本:		2.0.50727.3053
 * 创 建 人：		
 * 文件版本：		1.0.0.0
 * 修 改 人： 
 * 修改日期： 
 * 備注描述： 
**********************************************************************************/
using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using Library;

namespace Web.user.finance
{
    public partial class dl_JournalAccount : PageCore
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //spd.jumpUrl(this.Page, 1);//跳转二级密碼

            if (!IsPostBack)
            {
                LitEmoney.Text = LoginUser.Emoney.ToString();
                LitBonusAccount.Text = LoginUser.BonusAccount.ToString();
                LitStockMoney.Text = LoginUser.StockMoney.ToString();;
                LitStockAccount.Text = LoginUser.StockAccount.ToString();
                //ltGLmoney.Text = LoginUser.GLmoney.ToString();
                ShowData();
                BindData();
                //btnDetail.Text = GetLanguage("DetailAccount"); //"佣金币明细"
                //btnSearch.Text = GetLanguage("Search");//搜索
            }
        }

        public void ShowData()
        {
            dropType.Items.Add(new ListItem("请选择", "0"));
            dropType.Items.Add(new ListItem("注册分", "1"));
            dropType.Items.Add(new ListItem("奖励分", "2"));
            dropType.Items.Add(new ListItem("复利分", "3"));
            dropType.Items.Add(new ListItem("激活分", "4"));
        }

        public string GetWhere()
        {
            string strWhere = " JournalType<5 and u.UserID=" + getLoginID();

            if(dropType.SelectedValue != "0")
            {
                strWhere += " and JournalType=" + dropType.SelectedValue;
            }

            return strWhere;
        }

        private void BindData()
        {
            bind_repeater(journalBLL.GetList(GetWhere()), Repeater1, "id desc", tr1, AspNetPager1);
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            BindData();
        }

        protected void AspNetPager1_PageChanged(object sender, EventArgs e)
        {
            BindData();
        }

        /// <summary>
        /// 查看现金币明细
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnDetail_Click(object sender, EventArgs e)
        {
            Response.Redirect("dl_JournalEmoney.aspx");
        }
    }
}
