using Library;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web.user.member
{
    public partial class ActiveUser : PageCore//System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindData();
            }
        }

        public void BindData()
        {
            lgk.Model.tb_user userModel = userBLL.GetModel(getLoginID());
            if (userModel != null)
            {
                txtUserCode.Value = userModel.UserCode;
                txtRegMoney.Value = userModel.RegMoney.ToString();
                if(userModel.IsOpend == 2)
                {
                    div1.Visible = false;
                    div2.Visible = true;
                }
                else
                {
                    div1.Visible = true;
                    div2.Visible = false;
                }
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string strNum = txtActiveNum.Value.Trim();
            int num;
            if(!int.TryParse(strNum, out num))
            {
                MessageBox.ShowBox(this.Page, "您输入的激活单数格式错误", Library.Enums.ModalTypes.error);
                return;
            }
            int typeid = Convert.ToInt32(dropPayType.SelectedValue);
            if(typeid == 0)
            {
                MessageBox.ShowBox(this.Page, "请选择激活方式", Library.Enums.ModalTypes.warning);
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

            string strPayPwd = txtPayPwd.Value.Trim();
            lgk.Model.tb_user userModel = userBLL.GetModel(getLoginID());
            if (!userModel.SecondPassword.Equals(PageValidate.GetMd5(strPayPwd)))
            {
                MessageBox.ShowBox(this.Page, "支付密码错误", Library.Enums.ModalTypes.warning);
                return;
            }

            string msg = userBLL.proc_open(getLoginID(), 2, 0, typeid, num, 1);
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