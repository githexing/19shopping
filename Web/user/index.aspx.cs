/*********************************************************************************
* Copyright(c)  	2012 RJ.COM
 * 创建日期：		2012-5-16 11:51:31 
 * 文 件 名：		index.cs 
 * CLR 版本: 		2.0.50727.3053 
 * 创 建 人：		King
 * 文件版本：		1.0.0.0
 * 修 改 人： 
 * 修改日期： 
 * 备注描述：         
***************************************************************************/
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Library;

namespace Web.user
{
    public partial class index : PageCore
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DataInit();
                BindData();
                string culture;
                if (HttpContext.Current.Request.Cookies["Culture"] != null)
                {
                    culture = HttpContext.Current.Request.Cookies["Culture"].Value;
                }
            }
        }
        
        private void DataInit()
        {
            lgk.Model.tb_user userModel = userBLL.GetModel(getLoginID());
            if (userModel != null)
            {
                ltTotalFhDian.Text = fhDianBLL.GetRecordCount(" UserID=" + userModel.UserID).ToString();
                ltOutFhd.Text = fhDianBLL.GetRecordCount(" IsOut=1 and UserID=" + userModel.UserID).ToString();
                ltSettleFhd.Text = fhDianBLL.GetRecordCount(" IsOut=0 and UserID=" + userModel.UserID).ToString();

                //ltUserCode.Text = userModel.UserCode;
                //ltNicheng.Text = userModel.NiceName;
                //ltLevelName.Text = levelBLL.GetLevelName(userModel.LevelID); 

                ltLeftScore.Text = userModel.LeftScore.ToString();
                ltRightScore.Text = userModel.RightScore.ToString();

                //string strNewUrl = Request.Url.ToString().Replace("/user/finance/", "/").Replace("/user/business/", "/").Replace("/user/Info/", "/").Replace("/user/member/", "/").Replace("/user/team/", "/").Replace("/user/product/", "/").Replace("/user/shop/", "/").Replace("/user/", "/");//取得当前的外网
                //strNewUrl = strNewUrl.Substring(0, strNewUrl.LastIndexOf("/") + 1);//当前页面的根路径
                //string url = strNewUrl + "user/LinkRegist.aspx?i=" + userModel.UserID;
                //ltRecUrl.Text = url;
            }
        }

        //public string rem_url = "";

        /// <summary>
        /// 填充信息
        /// </summary>
        protected void BindData()
        {
            if (Language == "zh-cn")
            {
                bind_repeater(newsBLL.GetList(8, "NewsType=0 and New01=0", "PublishTime desc"), Repeater1, "PublishTime desc", tr1, 8);
            }
            else if (Language == "en-us")
            {
                bind_repeater(newsBLL.GetList(8, "NewsType=0 and New01=1", "PublishTime desc"), Repeater1, "PublishTime desc", tr1, 8);
            }

        }
       
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            HttpCookie Culture;

            if (HttpContext.Current.Request.Cookies["Culture"] == null)
                Culture = new HttpCookie("Culture");
            else
                Culture = HttpContext.Current.Request.Cookies["Culture"];
            
            Response.AppendCookie(Culture);
            Response.Redirect("index.aspx");
        }
        
    }
}