using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Library;
using System.Data;

namespace Web.admin.finance
{
    public partial class Bonusff : AdminPageBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            jumpMain(this, 65, getLoginID());//权限
            if (!IsPostBack)
            {
                BindData();
            }
        }

        /// <summary>
        /// 共享奖励
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            decimal jine = 0;
            if (!decimal.TryParse(txtFhMoney.Text.Trim(),out jine))
            {
                ScriptManager.RegisterStartupScript(this.Page, typeof(Page), "info", "alert('请输入正确的金额!');", true);
                return;
            }
            MySQL(string.Format(" exec proc_Award_ShareOut "+ jine));
            //  MySQL(string.Format(" exec proc_datebonus"));
            ScriptManager.RegisterStartupScript(this.Page, typeof(Page), "info", "alert('结算成功!');", true);
        }

        /// <summary>
        /// 荣誉奖
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            string strUserCode = txtUserCode.Text.Trim();
            lgk.Model.tb_user userModel = userBLL.GetModelByUserCode(strUserCode);
            if (userModel == null)
            {
                ScriptManager.RegisterStartupScript(this.Page, typeof(Page), "info", "alert('此用户编号不存在!');", true);
                return;
            }
            if(userModel.LevelID != 6)
            {
                ScriptManager.RegisterStartupScript(this.Page, typeof(Page), "info", "alert('您输入的会员不是荣誉股东!');", true);
                return;
            }
            decimal iMoney;
            if(!decimal.TryParse(txtMoney.Text.Trim(), out iMoney))
            {
                ScriptManager.RegisterStartupScript(this.Page, typeof(Page), "info", "alert('您输入的金额格式错误!');", true);
                return;
            }
            if (iMoney <= 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, typeof(Page), "info", "alert('您输入的金额必须大于0!');", true);
                return;
            }
            MySQL(string.Format(" exec proc_Award_Rongyu "+ userModel.UserID +","+ iMoney));
            //  MySQL(string.Format(" exec proc_datebonus"));
            ScriptManager.RegisterStartupScript(this.Page, typeof(Page), "info", "alert('发放成功!');", true);
        }

        protected void LinkButton3_Click(object sender, EventArgs e)
        {
            MySQL(string.Format(" exec proc_Task_DynamicAward "));
            //  MySQL(string.Format(" exec proc_datebonus"));
            ScriptManager.RegisterStartupScript(this.Page, typeof(Page), "info", "alert('发放成功!');", true);
        }
        
        private void BindData()
        {
            //今日业绩
            decimal totalYeji = orderBLL.GetSumYeji(" Datediff(day,GetDate(),OrderDate)=0 ");
            //分红点数量
            int fhdnum = fhDianBLL.GetRecordCount("IsOut=0");

            decimal iAver = 0;
            if (fhdnum > 0)
            {
                iAver = totalYeji / fhdnum;
            }

            ltAddYeji.Text = totalYeji.ToString();
            LtTotalFhd.Text = fhdnum.ToString();
            ltEveryFhdMoney.Text = iAver.ToString();
            bind_repeater(sysLogBLL.GetList("LogType = 999"), Repeater1, "LogDate desc", tr1, AspNetPager1);
        }
        protected void AspNetPager1_PageChanged(object sender, EventArgs e)
        {
            BindData();
        }

        protected void txtFhMoney_TextChanged(object sender, EventArgs e)
        {
            decimal jine = 0;
            if (!decimal.TryParse(txtFhMoney.Text.Trim(), out jine))
            {
                ScriptManager.RegisterStartupScript(this.Page, typeof(Page), "info", "alert('请输入正确的金额!');", true);
                return;
            }
            //分红点数量
            decimal iAver = 0;
            int fhdnum = fhDianBLL.GetRecordCount("IsOut=0");
            if (fhdnum > 0)
            {
                iAver = jine / fhdnum;
            }

            ltRealFhdMoney.Text = iAver.ToString();
        }
    }
}
