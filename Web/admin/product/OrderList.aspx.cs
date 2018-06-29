using Library;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web.admin.product
{
    public partial class OrderList : AdminPageBase//System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            jumpMain(this, 76, getLoginID());//权限
            if (!IsPostBack)
            {
                bind();
            }
        }

        /// <summary>
        /// 获取条件
        /// </summary>
        /// <returns></returns>
        private string getWhere()
        {
            string usercode = this.txtInput.Value.Trim();
            string StarTime = this.txtStar.Text.Trim();
            string EndTime = txtEnd.Text.Trim();
            
            string strWhere = " PayMethod<3 ";
            strWhere += " and IsSend > 0";
            
            if (!string.IsNullOrEmpty(usercode))
            {
                strWhere += " and u.UserCode like '" + usercode + "%' ";
            }

            int buytype = Convert.ToInt32(dropBuyType.SelectedValue);
            if (buytype != 0)
            {
                strWhere += " and o.PayMethod= " + buytype;
            }
            if (!string.IsNullOrEmpty(usercode))
            {
                strWhere += " and u.UserCode like '" + usercode + "%' ";
            }

            if (StarTime != "" && EndTime == "")
            {
                strWhere += string.Format(" and Convert(nvarchar(10),OrderDate,120)  >= '" + StarTime + "'");
            }
            else if (StarTime == "" && EndTime != "")
            {
                strWhere += string.Format("  and Convert(nvarchar(10),OrderDate,120)  <= '" + EndTime + "'");
            }
            else if (StarTime != "" && EndTime != "")
            {
                strWhere += string.Format("  and Convert(nvarchar(10),OrderDate,120)  between '" + StarTime + "' and '" + EndTime + "'");
            }
            return strWhere;
        }

        private void bind()
        {
            bind_repeater(GetAllOrderList(getWhere()), rptOrder, "IsSend asc,OrderDate desc", trNull, AspNetPager1);
        }

        /// <summary>
        /// 搜索提现记录
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            bind();
        }

        protected void AspNetPager1_PageChanged(object sender, EventArgs e)
        {
            bind();
        }

        protected void daochu_Click(object sender, EventArgs e)
        {
            DataSet ds = GetAllOrderList(getWhere());
            DataView dv = ds.Tables[0].DefaultView;
            dv.Sort = "IsSend asc,OrderDate desc";

            if (dv.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, typeof(Page), "info", "alert('不能导出空表格!');", true);
                return;
            }
            //生成列的中午对应表
            string str = ToOrderListExecl(Server.MapPath("../../Upload"), dv.Table);
            Response.Redirect("../../Upload/" + str.Replace("\\", "/").Replace("//", "/"), true);
        }

    }
}