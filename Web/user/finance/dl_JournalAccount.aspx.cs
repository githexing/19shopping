/*********************************************************************************
*Copyright(c) 	2012 RJ.COM
 * �������ڣ�		2012-6-6 16:01:41
 * �� �� ����		dl_JournalAccount.cs
 * CLR �汾:		2.0.50727.3053
 * �� �� �ˣ�		
 * �ļ��汾��		1.0.0.0
 * �� �� �ˣ� 
 * �޸����ڣ� 
 * ��ע������ 
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
            //spd.jumpUrl(this.Page, 1);//��ת�����ܴa

            if (!IsPostBack)
            {
                LitEmoney.Text = LoginUser.Emoney.ToString();
                LitBonusAccount.Text = LoginUser.BonusAccount.ToString();
                LitStockMoney.Text = LoginUser.StockMoney.ToString();;
                LitStockAccount.Text = LoginUser.StockAccount.ToString();
                //ltGLmoney.Text = LoginUser.GLmoney.ToString();
                ShowData();
                BindData();
                //btnDetail.Text = GetLanguage("DetailAccount"); //"Ӷ�����ϸ"
                //btnSearch.Text = GetLanguage("Search");//����
            }
        }

        public void ShowData()
        {
            dropType.Items.Add(new ListItem("��ѡ��", "0"));
            dropType.Items.Add(new ListItem("ע���", "1"));
            dropType.Items.Add(new ListItem("������", "2"));
            dropType.Items.Add(new ListItem("������", "3"));
            dropType.Items.Add(new ListItem("�����", "4"));
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
        /// �鿴�ֽ����ϸ
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnDetail_Click(object sender, EventArgs e)
        {
            Response.Redirect("dl_JournalEmoney.aspx");
        }
    }
}
