﻿using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using BLL;
using Library;


namespace web.admin.product
{
    public partial class OrderProduct : AdminPageBase//System.Web.UI.Page//AdminPageBase
    {
        lgk.BLL.tb_Order ob = new lgk.BLL.tb_Order();
        lgk.BLL.tb_user ub = new lgk.BLL.tb_user();
        lgk.BLL.tb_OrderDetail obd = new lgk.BLL.tb_OrderDetail();
        lgk.BLL.tb_produce pb = new lgk.BLL.tb_produce();
        lgk.BLL.tb_flag fg = new lgk.BLL.tb_flag();
        //UserProBLL pro = new UserProBLL();
        //lgk.BLL.tb_level lb = new lgk.BLL.tb_level(); //级别
        //ThirdPasswordBLL76 tpd = new ThirdPasswordBLL76(); //三级密码

        protected void Page_Load(object sender, EventArgs e)
        {
            jumpMain(this, 62, getLoginID());//权限
            //spd.jumpAdminUrl(this.Page, 1);//跳转二级密碼
            if (!IsPostBack)
            {
                bind();
            }
        }

        /// <summary>
        /// 获取条件
        /// </summary>
        /// <returns></returns>
        private string getWhere()
        {
            string id = Request.QueryString["type"];
            string usercode = this.txtInput.Value.Trim();
            string StarTime = this.txtStar.Text.Trim();
            string EndTime = txtEnd.Text.Trim();
            string strWhere = " PayMethod=3 ";
            // str += " and IsDel = 0 ";   //未删除的订单
            strWhere += " and IsSend > 0";
            switch (id)
            {
                case "1": strWhere += ""; break;
                case "2": strWhere += "and o.IsSend=0"; break;//未付款
                case "3": strWhere += "and o.IsSend=1"; break;//待发货
                case "4": strWhere += "and o.IsSend=2"; break;//已发货
                case "5": strWhere += "and o.IsSend=3"; break;//已完成
            }
            
            int shtype = Convert.ToInt32(dropShType.SelectedValue);
            if (shtype != 0)
            {
                strWhere += " and o.ReceiveType= " + shtype;
            }
            if (!string.IsNullOrEmpty(usercode))
            {
                strWhere += " and u.UserCode like '" + usercode + "%' ";
            }
            string stragentcode = txtAgentCode.Value.Trim();
            if (!string.IsNullOrEmpty(stragentcode))
            {
                strWhere += " and u.AgentCode like '" + stragentcode + "%' ";
            }
            if (StarTime != "" && EndTime == "")
            {
                strWhere += string.Format(" and Convert(nvarchar(10),OrderDate,120)  >= '" + StarTime + "'");
            }
            else if (StarTime == "" && EndTime != "")
            {
                strWhere += string.Format("  and Convert(nvarchar(10),OrderDate,120)  <= '" + EndTime + "'");
            }
            else if (StarTime != "" && EndTime != "")
            {
                strWhere += string.Format("  and Convert(nvarchar(10),OrderDate,120)  between '" + StarTime + "' and '" + EndTime + "'");
            }
            return strWhere;
        }

        private void bind()
        {
            bind_repeater(GetAllOrderList(getWhere()), rptOrder, "OrderDate desc", trNull, AspNetPager1);
        }
        /// <summary>
        /// 搜索提现记录
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnSearch2_Click(object sender, EventArgs e)
        {
            bind();
        }

        protected void AspNetPager1_PageChanged(object sender, EventArgs e)
        {
            bind();
        }

        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {
            bind();
        }

        protected void rptOrder_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            //long uid = ob.GetModel(ID).UserID;


            //tb_OrderDetail od=obd.GetModelByOrderID(ID);
            lgk.Model.tb_Order order = ob.GetModelByCode(e.CommandArgument.ToString());

            //int pid = od.ProcudeID; //商品编号
            //decimal emoney=od.OrderTotal;
            if (order == null)
            {
                MessageBox.ShowAndRedirect(this, "已经删除过的记录!", "OrderProduct.aspx");
                return;
            }
            if (order.IsDel == 2)
            {
                MessageBox.ShowAndRedirect(this, "已经删除过的记录!", "OrderProduct.aspx");
                return;
            }

            TextBox txtGongsi = (TextBox)e.Item.FindControl("txtGongsi");//快递公司
            TextBox txtDanhao = (TextBox)e.Item.FindControl("txtDanhao");//快递单号
            LinkButton link = (LinkButton)e.Item.FindControl("LinkButton2");//编辑按钮
            LinkButton linkSave = ((LinkButton)e.Item.FindControl("LinkButton3"));//保存按钮

            if (e.CommandName.Equals("enter")) //确认发货 
            {
                if (order.IsSend == 0)
                {
                    MessageBox.ShowAndRedirect(this, "未付款的记录!", "OrderProduct.aspx");
                    return;
                }
                if (order.IsSend > 1)
                {
                    MessageBox.ShowAndRedirect(this, "已发货的记录!", "OrderProduct.aspx");
                    return;
                }

                #region 1判断当前用户输入的快递名称及单号 2保存快递信息
                string strgongsi = txtGongsi.Text.Trim();
                //if (string.IsNullOrEmpty(strgongsi))
                //{
                //    MessageBox.Show(this, "发货失败，原因：快递公司不能为空");
                //    return;
                //}
                string strdan = txtDanhao.Text.Trim();
                //if (string.IsNullOrEmpty(strdan))
                //{
                //    MessageBox.Show(this, "发货失败，原因：快递单号不能为空");
                //    return;
                //}
                order.Order3 = strgongsi;
                order.Order4 = strdan;

                if (!ob.Update(order))
                {
                    MessageBox.Show(this, "发货失败，原因：保存快递信息失败");
                    return;
                }
                #endregion

                bool b = true;
                if (b)
                {
                    //if (string.IsNullOrEmpty(order.Order3) || string.IsNullOrEmpty(order.Order4))
                    //{
                    //    MessageBox.ShowAndRedirect(this, "请先填写快递公司和快递单号!", "OrderProduct.aspx");
                    //    return;
                    //}

                    //if (order.OrderType == 3)
                    //{
                    //    ob.Update(order);
                    //    MessageBox.ShowAndRedirect(this, "发货已成功！\r\n 由于还需要支付宝平台返回验证消息 \r\n 请稍后刷新查看发货状态", "OrderProduct.aspx");
                    //}
                    //else
                    //{
                    order.IsSend = 2;//已发货
                    order.SendDate = DateTime.Now; //发货时间  结算奖金以发货时间为准
                    if (ob.Update(order))
                    {
                        MessageBox.ShowAndRedirect(this, "发货已成功!", "OrderProduct.aspx");
                    }
                    //}
                }

            }
            if (e.CommandName.Equals("cancel")) //取消订单
            {
                lgk.Model.tb_user user = ub.GetModel(order.UserID);

                try
                {
                    int jType = 0;
                    if (order.OrderType == 1)//激活分+注册分
                    {
                        jType = 1;
                        user.BonusAccount += order.OrderTotal;
                        userBLL.Update(user);
                        add_journal(order.UserID, order.OrderTotal, 0, user.BonusAccount, jType, 99, "取消订单：" + order.OrderCode, "Delete orders", order.UserID);
                    }
                    else if (order.OrderType == 2)//重消币
                    {
                        jType = 5;
                        user.StockMoney += order.OrderTotal;
                        userBLL.Update(user);
                        add_journal(order.UserID, order.OrderTotal, 0, user.StockMoney, jType, 99, "取消订单：" + order.OrderCode, "Delete orders", order.UserID);
                    }
                    else if (order.OrderType == 3)//奖金币和重消币
                    {
                        jType = 5;
                        List<lgk.Model.tb_journal> jList = journalBLL.GetModelList("journal03='" + order.OrderCode + "'");
                        if (jList.Count > 0)
                        {
                            foreach (lgk.Model.tb_journal jModel in jList)
                            {
                                if (jModel.JournalType == 1)
                                {
                                    user.BonusAccount += jModel.OutAmount;
                                    AddJournal(order.UserID, jModel.OutAmount, 0, user.BonusAccount, 1, 99, "取消订单：" + order.OrderCode, "Delete orders", order.UserID);
                                }
                                else if (jModel.JournalType == 2)
                                {
                                    user.StockMoney += jModel.OutAmount;
                                    AddJournal(order.UserID, jModel.OutAmount, 0, user.StockMoney, 5, 99, "取消订单：" + order.OrderCode, "Delete orders", order.UserID);
                                }
                            }
                        }
                    }
                    // DeleteByCode(order.OrderCode);
                    // ob.Delete(order.OrderID);
                    order.IsDel = 2;  //2：订单取消标记，1：申请取消
                    orderBLL.Update(order);
                    MessageBox.ShowAndRedirect(this, "取消订单成功!", "OrderProduct.aspx");
                }
                catch
                {
                    MessageBox.ShowAndRedirect(this, "取消订单失败!", "OrderProduct.aspx");
                }
            }
            if (e.CommandName.Equals("revoke")) //撤销申请
            {
                try
                {
                    order.IsDel = 0;  //2：订单取消标记，1：申请取消
                    orderBLL.Update(order);
                    MessageBox.ShowAndRedirect(this, "撤销申请成功!", "OrderProduct.aspx");
                }
                catch (Exception)
                {
                    MessageBox.ShowAndRedirect(this, "撤销申请失败!", "OrderProduct.aspx");
                }
            }
            if (e.CommandName.Equals("show"))
            {
                Response.Redirect("OrderDetail.aspx?oid=" + order.OrderCode);
            }

            if (e.CommandName.Equals("edit"))
            {
                link.Visible = false;
                linkSave.Visible = true;
            }
            if (e.CommandName.Equals("ziti"))//用户自提
            {
                order.IsSend = 5;//用户自提
                orderBLL.Update(order);
            }
            /*
            if (e.CommandName.Equals("save"))
            {
                
                if (string.IsNullOrEmpty(txtGongsi.Text))
                {
                    MessageBox.Show(this, "快递公司不能为空");
                    return;
                }
                if (string.IsNullOrEmpty(txtDanhao.Text))
                {
                    MessageBox.Show(this, "快递单号不能为空");
                    return;
                }
                order.order3 = txtGongsi.Text;
                order.order4 = txtDanhao.Text;
               // order.IsSend = 2;
                if (ob.Update(order))
                {
                    MessageBox.Show(this, "编辑快递信息成功");
                    bind();
                }
                else
                {
                    MessageBox.Show(this, "编辑快递信息失败");
                }
            }
            */

            return;
        }

        public void AddJournal(long iUserID, decimal inamount, decimal outamount, decimal banlance, int jourtype, int type, string remark, string remarken, long iFromUserID)
        {
            lgk.Model.tb_journal jModel = new lgk.Model.tb_journal();
            jModel.UserID = iUserID;
        }

        protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            //

            if (e.Item.ItemIndex > -1)
            {
                //未付款0，待发货1，待收货为2，已完成3
                // LinkButton link = (LinkButton)e.Item.FindControl("LinkButton3");//编辑
                TextBox txtGongsi = (TextBox)e.Item.FindControl("txtGongsi");//公司
                TextBox txtDanhao = (TextBox)e.Item.FindControl("txtDanhao");//单号
                Literal Literal1 = (Literal)e.Item.FindControl("Literal1");//公司
                Literal Literal2 = (Literal)e.Item.FindControl("Literal2");//单号
                HiddenField hft = (HiddenField)e.Item.FindControl("hft");//状态
                if (txtGongsi != null && txtDanhao != null && hft != null)
                {
                    Literal1.Text = "";
                    Literal2.Text = "";
                    string typen = hft.Value;
                    if (!"1".Equals(typen))
                    {
                        Literal1.Text = txtGongsi.Text;
                        Literal2.Text = txtDanhao.Text;
                        txtGongsi.Visible = false;
                        txtDanhao.Visible = false;
                        // link.Visible = false;
                        return;
                    }
                }
            }
        }

        protected string GetState(string id, string isDel)
        {
            string state = "";
            switch (id)
            {
                case "0":
                    state = "<span class='red'>付款失败</span>";
                    break;
                case "1":
                    if (isDel == "1")
                        state = "<span class='red'>申请取消</span>";
                    else if (isDel == "2")
                        state = "<span class='red'>已取消</span>";
                    else state = "待发货";
                    break;
                case "2":
                    state = "已发货";
                    break;
                case "3":
                    state = "已完成";
                    break;
                case "4":
                    state = "未收到货";
                    break;
                case "5":
                    state = "用户自提";
                    break;
            }
            return state;
        }

        protected void daochu_Click(object sender, EventArgs e)
        {
            DataSet ds = GetAllOrderList(getWhere());
            DataView dv = ds.Tables[0].DefaultView;
            dv.Sort = "IsSend asc,OrderDate desc";

            if (dv.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, typeof(Page), "info", "alert('不能导出空表格!');", true);
                return;
            }
            //生成列的中午对应表
            string str = ToOrderExecl(Server.MapPath("../../Upload"), dv.Table);
            Response.Redirect("../../Upload/" + str.Replace("\\", "/").Replace("//", "/"), true);
        }

    }
}