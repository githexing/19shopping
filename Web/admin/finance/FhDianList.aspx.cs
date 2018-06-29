using Library;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web.admin.finance
{
    public partial class FhDianList : AdminPageBase//System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            jumpMain(this, 74, getLoginID());//权限

            spd.jumpAdminUrl(this.Page, 1);//跳转二级密码

            if (!IsPostBack)
            {
                //BindLevel();
                BindData();
            }
        }

        /// <summary>
        /// 填充申请记录
        /// </summary>
        private void BindData()
        {
            bind_repeater(fhDianBLL.GetUserList(GetWhere()), Repeater1, "UserID desc", divno, AspNetPager1);
        }

        private string GetWhere()
        {
            string strWhere = "";
            string strUserCode = SafeHelper.NoHtml(txtUserCode.Value.Trim());
            if (!string.IsNullOrEmpty(strUserCode))
            {
                strWhere += " u.usercode like  '" + strUserCode + "%'";
            }

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

    }
}