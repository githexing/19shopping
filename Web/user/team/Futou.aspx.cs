using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Library;

namespace Web.user.team
{
    public partial class Futou : PageCore
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (getParamInt("Futou") !=1)
            {
                MessageBox.ShowBox(this.Page, "后台未开启设置", Library.Enums.ModalTypes.error);//后台未开启设置
                return;
            }
            var jine = getParamAmount("Futou1");

            int Shuliang;

            if (!int.TryParse(TextBox1.Text, out Shuliang))
            {
                MessageBox.ShowBox(this.Page, "输入正确的数量", Library.Enums.ModalTypes.error); //输入正确的数量
                return;
            }
            string strPayPwd = txtSecondPassword.Text.Trim();
            if (string.IsNullOrEmpty(strPayPwd))
            {
                MessageBox.ShowBox(this.Page, GetLanguage("SecondaryISNUll"), Library.Enums.ModalTypes.warning);//二级密码不能为空
                return;
            }
            lgk.Model.tb_user userModel = userBLL.GetModel(getLoginID());
            if (!ValidPassword(userModel.SecondPassword, PageValidate.GetMd5(strPayPwd)))
            {
                MessageBox.ShowBox(this.Page, "支付密码错误", Library.Enums.ModalTypes.warning);//
                return;
            }

            Random rand = new Random();
            string orderCode = DateTime.Now.ToString("yyyyMMddhhmmss") + rand.Next(10000, 99999); //订单编号
            string goodsname = string.Format("订单号{0}，", orderCode);
        
           
            if (userModel.StockMoney - Shuliang * jine<0 && DropDownList1.SelectedValue=="3")
            {
                MessageBox.ShowBox(this.Page, "金额不足", Library.Enums.ModalTypes.error); //输入正确的数量
                return;
            }
            else if (userModel.Emoney - Shuliang * jine < 0 && DropDownList1.SelectedValue == "2")
            {
                MessageBox.ShowBox(this.Page, "金额不足", Library.Enums.ModalTypes.error); //输入正确的数量
                return;
            }
            else if (userModel.Emoney - Shuliang * jine/2 < 0 && userModel.StockAccount - Shuliang * jine / 2 < 0 && DropDownList1.SelectedValue == "1")
            {
                MessageBox.ShowBox(this.Page, "金额不足", Library.Enums.ModalTypes.error); //输入正确的数量
                return;
            }
            //总订单
            lgk.Model.tb_Order orderModel = new lgk.Model.tb_Order();//订单
            orderModel.UserID = getLoginID();//用户
            orderModel.OrderCode = orderCode;//订单编号
            orderModel.OrderSum = Shuliang;//订单数--
            orderModel.OrderTotal = Shuliang*jine;//购买总金
            orderModel.PVTotal = 0;//
            orderModel.OrderDate = DateTime.Now;
            orderModel.IsSend = 3;
            orderModel.PayMethod = 2;//--复投  1注册激活,3、购物分购物
            orderModel.Order5 = "";//备用电话
            orderModel.UserAddr = userModel.Address;//addrModel.Address;//发货地址
            orderModel.Order6 = userModel.PhoneNum;//addrModel.PhoneNum;//收货电话
            orderModel.Order7 = userModel.NiceName; //addrModel.MemberName;//收货姓名
            orderModel.OrderType = int.Parse(DropDownList1.SelectedValue);//1:
            long iOrderID = orderBLL.Add(orderModel);//加入订单表

            //lgk.Model.tb_OrderDetail orderDetailModel = new lgk.Model.tb_OrderDetail();
            //orderDetailModel.OrderCode = orderCode;
            //orderDetailModel.Price = jine;//单价--
            //orderDetailModel.OrderSum = Shuliang;//数量--
            //orderDetailModel.OrderTotal = jine*Shuliang;//订单金额
            //orderDetailModel.PV = 0;//
            //orderDetailModel.PVTotal = 0;
            //orderDetailModel.ProcudeID = 0; //产品编号--
            //orderDetailModel.ProcudeName = "复投产品";//名称--
            //orderDetailModel.gColor = "";
            //orderDetailModel.gSize = "";
            //orderDetailModel.OrderDate = DateTime.Now;//
            //orderDetailBLL.Add(orderDetailModel);//加入订单详情 


        
            lgk.Model.tb_journal joModel = new lgk.Model.tb_journal();
            joModel.UserID = userModel.UserID;
            joModel.Remark = goodsname;//名称--;
            joModel.InAmount = 0;//收入0;
            joModel.OutAmount = Shuliang*jine;//购买价(支出金币)
            joModel.JournalDate = DateTime.Now;
            joModel.Journal01 = userModel.UserID;//
            joModel.Journal02 = 99;//消费
            joModel.Journal03 = orderCode;//订单编号
            if (DropDownList1.SelectedValue=="3")//混合是 1 注册 2 福利 3
            {
                joModel.JournalType = 3;//币种
                joModel.BalanceAmount = userModel.StockMoney - Shuliang * jine;//余额
                journalBLL.Add(joModel);
                UpdateAccount("StockMoney", userModel.UserID, Shuliang * jine, 0);
                //执行存储过程
                string procmsg = string.Empty;
                procmsg = proc_BuyOrder(getLoginID(), orderModel.OrderSum, orderCode, 3, Shuliang * jine);
                LogHelper.SaveLog("procmsg:" + procmsg, "proc_BuyOrder");
                MessageBox.ShowBox(this.Page, "购买成功！", Library.Enums.ModalTypes.success); //输入正确的数量
                return;
            }
           else if (DropDownList1.SelectedValue == "1")//混合 1 + 4
            {
                joModel.JournalType = 1;//币种
                joModel.BalanceAmount = userModel.Emoney - Shuliang * jine/2;//余额
                journalBLL.Add(joModel);

                joModel.UserID = userModel.UserID;
                joModel.Remark = goodsname;//名称--;
                joModel.InAmount = 0;//收入0;
                joModel.OutAmount = Shuliang * jine;//购买价(支出金币)
                joModel.JournalDate = DateTime.Now;
                joModel.Journal01 = userModel.UserID;//
                joModel.Journal02 = 99;//消费
                joModel.Journal03 = orderCode;//订单编号
                joModel.JournalType = 4;//币种
                joModel.BalanceAmount = userModel.StockAccount - Shuliang * jine / 2;//余额
                journalBLL.Add(joModel);

                UpdateAccount("Emoney", userModel.UserID, Shuliang * jine/2, 0);
                UpdateAccount("StockAccount", userModel.UserID, Shuliang * jine / 2, 0);


                string procmsg = string.Empty;
                procmsg = proc_BuyOrder(getLoginID(), orderModel.OrderSum, orderCode, 1, Shuliang * jine);
                LogHelper.SaveLog("procmsg:" + procmsg, "proc_BuyOrder");
                MessageBox.ShowBox(this.Page, "购买成功！", Library.Enums.ModalTypes.success); //输入正确的数量
                return;
            }
            else if (DropDownList1.SelectedValue == "2")//1
            {
                joModel.JournalType = 1;//币种
                joModel.BalanceAmount = userModel.Emoney - Shuliang * jine;//余额
                journalBLL.Add(joModel);
                UpdateAccount("Emoney", userModel.UserID, Shuliang * jine, 0);
                string procmsg = string.Empty;
                procmsg = proc_BuyOrder(getLoginID(), orderModel.OrderSum, orderCode, 2, Shuliang * jine);
                LogHelper.SaveLog("procmsg:" + procmsg, "proc_BuyOrder");
                MessageBox.ShowBox(this.Page, "购买成功！", Library.Enums.ModalTypes.success); //输入正确的数量
                return;
            }

            MessageBox.ShowBox(this.Page, "复投失败！", Library.Enums.ModalTypes.error); //输入正确的数量
            return;

            //Response.Redirect("/user/Mall/GoodsList.aspx?FT=1");
        }
    }
}