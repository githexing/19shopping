using Library;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace Web.user.team
{
    public partial class Member : PageCore//System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindData();
            }
        }

        /// <summary>
        ///查询条件
        /// </summary>
        /// <returns></returns>
        private string GetWhere()
        {
            string strStart = txtStart.Text.Trim();
            string strEnd = txtEnd.Text.Trim();

            string strWhere = " IsOpend=0 and User002 = " + LoginUser.UserID;

            #region 会员编号姓名
            if (!string.IsNullOrEmpty(this.txtUserCode.Value.Trim()))
                strWhere += " AND UserCode LIKE  '%" + this.txtUserCode.Value.Trim() + "%'";

            #endregion

            if (GetLanguage("LoginLable") == "en-us")
            {
                strStart = txtStartEn.Text.Trim();
                strEnd = txtEndEn.Text.Trim();
            }

            #region 开通时间
            if (strStart != "" && strEnd == "")
            {
                strWhere += string.Format(" AND Convert(nvarchar(10),RegTime,120) >= '" + strStart + "'");
            }
            else if (strStart == "" && strEnd != "")
            {
                strWhere += string.Format(" AND Convert(nvarchar(10),RegTime,120) <= '" + strEnd + "'");
            }
            else if (strStart != "" && strEnd != "")
            {
                strWhere += string.Format(" AND Convert(nvarchar(10),RegTime,120) BETWEEN '" + strStart + "' AND '" + strEnd + "'");
            }
            #endregion

            return strWhere;
        }

        /// <summary>
        /// 绑定已激活会员列表
        /// </summary>
        private void BindData()
        {
            bind_repeater(userBLL.GetOpenList(GetWhere()), Repeater1, "RegTime desc", tr1, AspNetPager1);
        }

        /// <summary>
        /// 搜索提现记录
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnSearch_Click(object sender, EventArgs e)
        {

            BindData();
        }

        /// <summary>
        /// 分页提现记录
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void AspNetPager1_PageChanged(object sender, EventArgs e)
        {
            BindData();
        }

        protected void Repeater1_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            long UserID = long.Parse(e.CommandArgument.ToString());
            lgk.Model.tb_user model = userBLL.GetModel(UserID);

            DropDownList lbl = (DropDownList)Repeater1.Items[e.Item.ItemIndex].FindControl("DropDownList1");
            int typeid = Convert.ToInt32(lbl.SelectedValue);

            if (typeid != 1 && typeid != 2)
            {
                MessageBox.MyShow(this, "请选择激活方式!");
                return;
            }
            if (model == null)
            {
                MessageBox.MyShow(this, "该会员不存在,无法再进行此操作!");
                return;
            }
            if (model.IsOpend != 0)
            {
                MessageBox.MyShow(this, "该会员已激活,无法再进行此操作!");
                return;
            }
            string msg = string.Empty;
            HtmlInputText txtActiveNum = (HtmlInputText)e.Item.FindControl("txtActiveNum");//
            int num;
            string strNum = txtActiveNum.Value.Trim();
            if (!int.TryParse(strNum, out num))
            {
                MessageBox.ShowBox(this.Page, "您输入的单量格式错误", Library.Enums.ModalTypes.error);
                return;
            }
            if (num <= 0)
            {
                MessageBox.ShowBox(this.Page, "激活的单数必须大于0", Library.Enums.ModalTypes.warning);
                return;
            }
            if (num > 50)
            {
                MessageBox.ShowBox(this.Page, "激活的单数最多50单", Library.Enums.ModalTypes.warning);
                return;
            }
            HtmlInputText txtPayPwd = e.Item.FindControl("txtPayPwd") as HtmlInputText;//
            string strPaypwd = txtPayPwd.Value.Trim();
            if (!model.SecondPassword.Equals(PageValidate.GetMd5(strPaypwd)))
            {
                MessageBox.ShowBox(this.Page, "支付密码错误", Library.Enums.ModalTypes.warning);
                return;
            }

            msg = userBLL.proc_open(UserID, 2, 0, typeid, num, 0);
            if (msg == "ok")
            {
                MessageBox.ShowBox(this.Page, "激活成功", Library.Enums.ModalTypes.success);
                BindData();
                return;
            }
            else if (!string.IsNullOrEmpty(msg))
            {
                MessageBox.ShowBox(this.Page, msg, Library.Enums.ModalTypes.error);
                return;
            }
            else
            {
                MessageBox.ShowBox(this.Page, "激活失败", Library.Enums.ModalTypes.error);
                return;
            }
            
        }

    }
}