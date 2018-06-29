using Library;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web.user.Mall
{
    public partial class OrderList : PageCore
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //ViewState["iType"] = 0;
                BindData();
            }
        }

        /// <summary>
        /// 获取条件
        /// </summary>
        /// <returns></returns>
        private string getWhere()
        {
            string str = " o.PayMethod=3 and o.IsSend>=0 and o.IsDel=0 and o.UserID=" + getLoginID();
            string id = dropOrderState.SelectedValue;
            switch (id)
            {
                case "0": str += ""; break;
                case "1": str += " and o.IsSend=1"; break;//已支付
                case "2": str += " and o.IsSend=2"; break;//已发货
                case "3": str += " and o.IsSend=3"; break;//已完成
            }

            string strordercode = txtOrdercode.Value.Trim();
            if (!string.IsNullOrEmpty(strordercode))
            {
                str += string.Format(" and o.ordercode  like '%" + strordercode + "%'");
            }
            int shtype = Convert.ToInt32(dropShType.SelectedValue);
            if (shtype > 0)
            {
                str += string.Format(" and o.ReceiveType=" + shtype);
            }

            string StarTime = txtStartTime.Value.Trim();
            string EndTime = txtEndTime.Value.Trim();
            
            if (StarTime != "" && EndTime == "")
            {
                str += string.Format(" and Convert(nvarchar(10),o.OrderDate,120)  >= '" + StarTime + "'");
            }
            else if (StarTime == "" && EndTime != "")
            {
                str += string.Format("  and Convert(nvarchar(10),o.OrderDate,120)  <= '" + EndTime + "'");
            }
            else if (StarTime != "" && EndTime != "")
            {
                str += string.Format("  and Convert(nvarchar(10),o.OrderDate,120)  between '" + StarTime + "' and '" + EndTime + "'");
            }

            return str;
        }

        private void BindData()
        {
            //dropOrderState.SelectedValue = ViewState["iType"].ToString();
            bind_repeater(GetAllOrderList(getWhere()), rpOrderList, "IsSend asc,OrderDate desc", tr1, AspNetPager1);
        }

        protected void AspNetPager1_PageChanged(object sender, EventArgs e)
        {
            BindData();
        }
        
        protected void rpOrderList_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Literal StateName = e.Item.FindControl("ltStateName") as Literal;
                Literal shName = e.Item.FindControl("ltShName") as Literal;
                //LinkButton btnCancel = e.Item.FindControl("lbtnCancel") as LinkButton;
                if (StateName != null)
                {
                    int iIsSend = Convert.ToInt32(DataBinder.Eval(e.Item.DataItem, "IsSend").ToString());
                    string strState = "";
                    if (iIsSend == 0)
                    {
                        strState = "未付款";
                    }
                    else if (iIsSend == 1)
                    {
                        strState = "已支付";
                    }
                    else if (iIsSend == 2)
                    {
                        strState = "已发货";
                    }
                    else if (iIsSend == 3)
                    {
                        strState = "已完成";
                    }
                    StateName.Text = strState;
                }
                if(shName != null)
                {
                    int iRecieveType = Convert.ToInt32(DataBinder.Eval(e.Item.DataItem, "ReceiveType").ToString());
                    string strShname = "";
                    if(iRecieveType == 1)
                    {
                        strShname = "所属服务中心自提";
                    }
                    else
                    {
                        strShname = "公司发快递";
                    }
                    shName.Text = strShname;
                }
            }
        }

        protected void rpOrderList_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            long iID = Convert.ToInt64(e.CommandArgument);
            lgk.Model.tb_Order orderModel = orderBLL.GetModel(iID);
            if (e.CommandName.Equals("cancel"))
            {
                if (orderModel != null)
                {
                    if (orderModel.IsDel == 0)
                    {
                        orderModel.IsDel = 1;
                        if (orderBLL.Update(orderModel))
                        {
                            ScriptManager.RegisterStartupScript(this.Page, typeof(Page), "info", "alert('订单取消成功!');", true);
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this.Page, typeof(Page), "info", "alert('订单取消失败!');", true);
                            return;
                        }
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this.Page, typeof(Page), "info", "alert('此订单已取消!');", true);
                        return;
                    }
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, typeof(Page), "info", "alert('此订单记录不存在!');", true);
                    return;
                }
            }
            else if (e.CommandName.Equals("sure"))
            {
                if (orderModel != null)
                {
                    if (orderModel.IsSend == 3)
                    {
                        ScriptManager.RegisterStartupScript(this.Page, typeof(Page), "info", "alert('此订单已收货!');", true);
                        return;
                    }
                    else if (orderModel.IsSend == 1)
                    {
                        ScriptManager.RegisterStartupScript(this.Page, typeof(Page), "info", "alert('此订单未发货!');", true);
                        return;
                    }
                    else 
                    {
                        orderModel.IsSend = 3;
                        
                        if (orderBLL.Update(orderModel))
                        {

                            ScriptManager.RegisterStartupScript(this.Page, typeof(Page), "info", "alert('收货成功!');", true);
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this.Page, typeof(Page), "info", "alert('收货失败!');", true);
                            return;
                        }
                    }
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, typeof(Page), "info", "alert('此订单记录不存在!');", true);
                    return;

                }
            }
        }

        protected void lbAll_Click(object sender, EventArgs e)
        {
            //ViewState["iType"] = 0;
            BindData();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            BindData();
        }

    }
}