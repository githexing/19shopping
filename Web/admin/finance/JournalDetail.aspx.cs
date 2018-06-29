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

namespace Web.admin.finance
{
    public partial class JournalDetail : AdminPageBase//System.Web.UI.Page
    {
        protected int Journal02 = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            jumpMain(this, 20, getLoginID());//权限

            if (!IsPostBack)
            {
                BindData();
            }
        }

        private void BindData()
        {
            long iUserID = Convert.ToInt64(Request.QueryString["UserID"].ToString());
            Journal02 = Convert.ToInt32(Request.QueryString["Journal02"].ToString());

            string name = OpeanType(Journal02.ToString());

            ltRemark.Text = name;
            ltIncome.Text = name;
            ltExpenditure.Text = name;
            ltBalance.Text = name;

            string strWhere = string.Format("JournalType=" + Journal02 + " and j.UserID=" + iUserID);

            bind_repeater(journalBLL.GetList(strWhere), Repeater1, "JournalDate desc,id desc", tr1, AspNetPager1);
        }

        protected void AspNetPager1_PageChanged(object sender, EventArgs e)
        {
            BindData();
        }
    }
}
