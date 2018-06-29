using Library;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web.user.Mall
{
    public partial class OrderBdList : PageCore//System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindData();
            }
        }

        /// <summary>
        /// 获取条件
        /// </summary>
        /// <returns></returns>
        private string getWhere()
        {
            string strWhere = " o.PayMethod<3 and o.IsSend>=0 and o.IsDel=0 and o.UserID=" + getLoginID();
            int id = Convert.ToInt32(dropBuyState.SelectedValue);
            if(id!= 0)
            {
                strWhere += " and o.PayMethod= " + id;
            }
            string strordercode = txtOrdercode.Value.Trim();
            string StarTime = txtStartTime.Value.Trim();
            string EndTime = txtEndTime.Value.Trim();

            if (!string.IsNullOrEmpty(strordercode))
            {
                strWhere += string.Format(" and o.ordercode  like '%" + strordercode + "%'");
            }

            if (StarTime != "" && EndTime == "")
            {
                strWhere += string.Format(" and Convert(nvarchar(10),o.OrderDate,120)  >= '" + StarTime + "'");
            }
            else if (StarTime == "" && EndTime != "")
            {
                strWhere += string.Format("  and Convert(nvarchar(10),o.OrderDate,120)  <= '" + EndTime + "'");
            }
            else if (StarTime != "" && EndTime != "")
            {
                strWhere += string.Format("  and Convert(nvarchar(10),o.OrderDate,120)  between '" + StarTime + "' and '" + EndTime + "'");
            }

            return strWhere;
        }

        private void BindData()
        {
            bind_repeater(GetAllOrderList(getWhere()), rpOrderList, "OrderDate desc", tr1, AspNetPager1);
        }

        protected void AspNetPager1_PageChanged(object sender, EventArgs e)
        {
            BindData();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            BindData();
        }

        protected void rpOrderList_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Literal PayName = e.Item.FindControl("ltPayName") as Literal;
                Literal BuyName = e.Item.FindControl("ltBuyName") as Literal;
                
                if (PayName != null)
                {
                    string strname = string.Empty;
                    int iOrderType = Convert.ToInt32(DataBinder.Eval(e.Item.DataItem, "OrderType").ToString());
                    if(iOrderType == 1)
                    {
                        strname = "激活分和注册分";
                    }
                    else if (iOrderType == 2)
                    {
                        strname = "注册分";
                    }
                    else if (iOrderType == 3)
                    {
                        strname = "复利分";
                    }
                    else if (iOrderType == 4)
                    {
                        strname = "购物分";
                    }
                    PayName.Text = strname;
                }
                if(BuyName != null)
                {
                    string name = string.Empty;

                    int iPayMethod = Convert.ToInt32(DataBinder.Eval(e.Item.DataItem, "PayMethod").ToString());
                    if(iPayMethod == 1)
                    {
                        name = "报单";
                    }
                    else if (iPayMethod == 2)
                    {
                        name = "复投";
                    }
                    else
                    {
                        name = "购物";
                    }
                    BuyName.Text = name;
                }
            }
        }

    }
}