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
    public partial class ProductYeji : AdminPageBase//System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            jumpMain(this, 75, getLoginID());//权限

            //spd.jumpAdminUrl(this.Page, 1);//跳转二级密码

            if (!IsPostBack)
            {
                BindData();
            }
        }

        private void BindData()
        {
            bind_repeater(orderBLL.GetUserList(GetWhere()), Repeater1, "OrderDate desc", divno, AspNetPager1);
        }

        private string GetWhere()
        {
            string strWhere = " 1=1 ";
            string strUserCode = SafeHelper.NoHtml(txtInput.Value.Trim());
            if (!string.IsNullOrEmpty(strUserCode))
            {
                string strType = dropType.SelectedValue;
                if (strType == "1")
                {
                    strWhere += " and u.usercode like  '" + strUserCode + "%'";
                }
                else if (strType == "2")
                {
                    strWhere += " and u.AgentCode like  '" + strUserCode + "%'";
                }
            }
            #region 注册时间
            string strStart = txtStart.Text.Trim();
            string strEnd = txtEnd.Text.Trim();
            if (strStart != "" && strEnd == "")
            {
                strWhere += string.Format(" and Convert(nvarchar(10),OrderDate,120)  >= '" + strStart + "'");
            }
            else if (strStart == "" && strEnd != "")
            {
                strWhere += string.Format(" and  Convert(nvarchar(10),OrderDate,120)  <= '" + strEnd + "'");
            }
            else if (strStart != "" && strEnd != "")
            {
                strWhere += string.Format(" and  Convert(nvarchar(10),OrderDate,120)  between '" + strStart + "' and '" + strEnd + "'");
            }
            #endregion
            return strWhere;
        }

        /// <summary>
        /// 搜索申请记录
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            BindData();
        }

        /// <summary>
        /// 分页申请记录
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void AspNetPager1_PageChanged(object sender, EventArgs e)
        {
            BindData();
        }

        /// <summary>
        /// 导出数据
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void lbtnExport_Click(object sender, EventArgs e)
        {
            DataSet ds = orderBLL.GetUserList(GetWhere());
            DataTable dt = ds.Tables[0];
            if (Repeater1.Items.Count == 0)
            {
                MessageBox.MyShow(this, "不能导出空表格");
                return;
            }
            if (dt.Rows.Count == 0)
            {
                MessageBox.MyShow(this, "错误的操作!");
                return;
            }
            string str = ToProductYeJiExecl(Server.MapPath("../../Upload"), dt);
            Response.Redirect("../../Upload/" + str.Replace("\\", "/").Replace("//", "/"), true);
        }

    }
}