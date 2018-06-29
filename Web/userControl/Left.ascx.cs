using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web.userControl
{
    public partial class Left : BaseControl
    {
        public int isactive = 0;
        public int isagent = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            if(LoginUser != null)
            {
                ltUserCode.Text = LoginUser.UserCode;
                ltNicheng.Text = LoginUser.NiceName;
                ltLevelName.Text = new lgk.BLL.tb_level().GetLevelName(LoginUser.LevelID);
                if (LoginUser.IsOpend == 2)
                {
                    isactive = 1;
                }
                if(LoginUser.IsAgent == 1)
                {
                    isagent = 1;
                }
            }
        }
    }
}