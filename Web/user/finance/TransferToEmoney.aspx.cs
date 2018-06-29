using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Library;
using lgk.Model;

namespace Web.user.finance
{
    public partial class TransferToEmoney : PageCore//System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // txtBonusAccount.Value = LoginUser.BonusAccount.ToString();//佣金币余额
                //txtEmoney.Value = LoginUser.Emoney.ToString();//现金币余额
                // txtStockMoney.Value = LoginUser.GLmoney.ToString();//购物币余额

                BindCurrency();
                BindData();
                btnSubmit.Text = GetLanguage("Submit");//提交
                btnSubmit.OnClientClick = "javascript:return confirm('" + GetLanguage("TransferConfirm") + "')";
                btnSearch.Text = GetLanguage("Search");//搜索

            }
        }

        private void BindCurrency()
        {
            dropCurrency.Items.Add(new ListItem("-请选择-", "0"));
            dropCurrency.Items.Add(new ListItem("奖励分转激活分", "1"));
            dropCurrency.Items.Add(new ListItem("激活分转其他会员", "2"));
            dropCurrency.Items.Add(new ListItem("注册分转其他会员", "3"));

            dropType.Items.Add(new ListItem("-请选择-", "0"));
            dropType.Items.Add(new ListItem("奖励分转激活分", "1"));
            dropType.Items.Add(new ListItem("激活分转其他会员", "2"));
            dropType.Items.Add(new ListItem("注册分转其他会员", "3"));
        }

        private bool CheckOpen(int value)
        {
            switch (value)
            {
                case 1://注册分转其他会员
                    var iOpen1 = getParamInt("Transfer_1");
                    if (iOpen1 != 1)
                    {
                        MessageBox.ShowBox(this.Page, GetLanguage("Feature"), Library.Enums.ModalTypes.none);//该功能未开放
                        return false;
                    }
                    break;
                case 2://奖励分转其他会员
                    var iOpen2 = getParamAmount("Transfer_2");
                    if (iOpen2 != 1)
                    {
                        MessageBox.ShowBox(this.Page, GetLanguage("Feature"), Library.Enums.ModalTypes.none);//该功能未开放
                        return false;
                    }
                    break;
                case 3://注册分转其他会员
                    var iOpen3 = getParamAmount("Transfer_3");
                    if (iOpen3 != 1)
                    {
                        MessageBox.ShowBox(this.Page, GetLanguage("Feature"), Library.Enums.ModalTypes.none);//该功能未开放
                        return false;
                    }
                    break;
                default://请选择转账类型
                    MessageBox.ShowBox(this.Page, GetLanguage("ChooseTransfer"), Library.Enums.ModalTypes.warning);//请选择转账类型
                    return false;
            }
            return true;
        }

        protected void txtUserCode_TextChanged(object sender, EventArgs e)
        {
            string strUserCode = txtUserCode.Text.Trim();
            var user = userBLL.GetModelByUserCode(strUserCode);
            if (user != null)
            {
                txtTrueName.Text = user.NiceName;
            }
            else
            {
                txtTrueName.Text = string.Empty;
                MessageBox.ShowBox(this.Page, GetLanguage("numberIsExist"), Library.Enums.ModalTypes.warning);//会员编号不存在
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            long toUserID = 0;
            lgk.Model.tb_user userInfo = userBLL.GetModel(getLoginID());
            lgk.Model.tb_change changeInfo = new lgk.Model.tb_change();

            int iTypeID = int.Parse(dropCurrency.SelectedValue);
            if (iTypeID == 0)
            {
                MessageBox.ShowBox(this.Page, GetLanguage("ChooseTransfer"), Library.Enums.ModalTypes.warning);//请选择转账类型
                return;
            }
            if (!CheckOpen(iTypeID))
            {
                MessageBox.ShowBox(this.Page, GetLanguage("Feature"), Library.Enums.ModalTypes.warning);//该功能未开放
                return;
            }

            string strMoney = txtMoney.Text.Trim();
            if (string.IsNullOrEmpty(strMoney))
            {
                MessageBox.ShowBox(this.Page, GetLanguage("transferMoneyIsnull"), Library.Enums.ModalTypes.warning);//转账金额不能为空
                return;
            }
            string strPayPwd = txtSecondPassword.Text.Trim();
            if (string.IsNullOrEmpty(strPayPwd))
            {
                MessageBox.ShowBox(this.Page, GetLanguage("SecondaryISNUll"), Library.Enums.ModalTypes.warning);//二级密码不能为空
                return;
            }
            if (!ValidPassword(userInfo.SecondPassword, PageValidate.GetMd5(strPayPwd)))
            {
                MessageBox.ShowBox(this.Page, "支付密码错误", Library.Enums.ModalTypes.warning);//
                return;
            }

            decimal dResult = 0;
            if (decimal.TryParse(strMoney, out dResult))
            {
                decimal dTrans = getParamAmount("Transfer1");//转账最低金额
                decimal d = getParamAmount("Transfer2");//转账倍数基数
                if (dResult < dTrans)
                {
                    MessageBox.ShowBox(this.Page, GetLanguage("equalTo") + dTrans, Library.Enums.ModalTypes.warning);//转账金额必须是大于等于XX的整数
                    return;
                }
                if (d != 0 && dResult % d != 0)
                {
                    MessageBox.ShowBox(this.Page, GetLanguage("amountMustbe") + d + GetLanguage("Multiples"), Library.Enums.ModalTypes.warning);//转账金额必须是XX的倍数
                    return;
                }
            }
            else
            {
                MessageBox.ShowBox(this.Page, "输入的金额格式错误", Library.Enums.ModalTypes.warning);
                return;
            }

            if ((iTypeID == 1) && dResult > userInfo.BonusAccount)
            {
                MessageBox.ShowBox(this.Page, "奖励分余额不足", Library.Enums.ModalTypes.warning);//
                return;
            }
            else if (iTypeID == 2 && dResult > userInfo.StockAccount)
            {
                MessageBox.ShowBox(this.Page, "激活分余额不足", Library.Enums.ModalTypes.warning);//
                return;
            }
            else if (iTypeID == 3 && dResult > userInfo.Emoney)
            {
                MessageBox.ShowBox(this.Page, "注册分余额不足", Library.Enums.ModalTypes.warning);//
                return;
            }

            string strUserCode = txtUserCode.Text.Trim();
            var toUser = userBLL.GetModelByUserCode(strUserCode);
            if (toUser == null)
            {
                MessageBox.ShowBox(this.Page, GetLanguage("numberIsExist"), Library.Enums.ModalTypes.warning);//会员编号不存在
                return;
            }
            else
            {
                toUserID = int.Parse(toUser.UserID.ToString());
            }

            if (toUserID <= 0)
            {
                MessageBox.ShowBox(this.Page, GetLanguage("objectExist"), Library.Enums.ModalTypes.warning);//转帐对象不存在
                return;
            }

            if (!userInfo.SecondPassword.Equals(PageValidate.GetMd5(txtSecondPassword.Text.Trim())))
            {
                MessageBox.ShowBox(this.Page, GetLanguage("PasswordError"), Library.Enums.ModalTypes.error);//二级密码错误
                return;
            }

            decimal fee = dResult * getParamAmount("Transfer3");
            changeInfo.UserID = getLoginID();
            changeInfo.ToUserID = toUserID;
            changeInfo.ToUserType = 0;
            changeInfo.MoneyType = 0;
            changeInfo.Amount = dResult;
            changeInfo.ChangeType = iTypeID;
            changeInfo.ChangeDate = DateTime.Now;
            changeInfo.Change005 = dResult - fee;
            changeInfo.Change006 = fee;// 转账手续费

            if (changeBLL.Add(changeInfo) > 0)
            {
                try
                {
                    if (changeInfo.ChangeType == 1)//奖励分转激活分
                    {
                        #region 奖励分转激活分
                        decimal dBonusAccount = userBLL.GetMoney(userInfo.UserID, "BonusAccount");
                        if (dBonusAccount >= changeInfo.Amount)
                        {
                            UpdateAccount("BonusAccount", userInfo.UserID, changeInfo.Amount, 0);//
                            UpdateAccount("StockAccount", toUserID, changeInfo.Change005, 1);//
                            //加入流水账表（佣金币减少）
                            lgk.Model.tb_journal jmodel = new lgk.Model.tb_journal();
                            jmodel.UserID = userInfo.UserID;
                            jmodel.Remark = "奖励分转激活分";
                            jmodel.RemarkEn = "Currency to shopping currency";
                            jmodel.InAmount = 0;
                            jmodel.OutAmount = changeInfo.Amount;
                            jmodel.BalanceAmount = userBLL.GetMoney(userInfo.UserID, "BonusAccount");
                            jmodel.JournalDate = DateTime.Now;
                            jmodel.JournalType = (int)Library.AccountType.奖励分;
                            jmodel.Journal01 = toUserID;
                            journalBLL.Add(jmodel);

                            //加入流水账表(现金币增加)
                            lgk.Model.tb_journal journalInfo = new lgk.Model.tb_journal();
                            journalInfo.UserID = toUserID;
                            journalInfo.Remark = "奖励分转激活分";
                            journalInfo.RemarkEn = "Currency to shopping currency";
                            journalInfo.InAmount = changeInfo.Change005;
                            journalInfo.OutAmount = 0;
                            journalInfo.BalanceAmount = userBLL.GetMoney(toUserID, "StockAccount");
                            journalInfo.JournalDate = DateTime.Now;
                            journalInfo.JournalType = (int)Library.AccountType.激活分;
                            journalInfo.Journal01 = userInfo.UserID;
                            journalBLL.Add(journalInfo);
                        }
                        else
                        {
                            MessageBox.ShowBox(this.Page, GetLanguage("objectExist"), Library.Enums.ModalTypes.warning);//转帐对象不存在
                        }
                        #endregion
                    }
                    else if (changeInfo.ChangeType == 2)//激活分转其他会员
                    {
                        #region 激活分转其他会员
                        decimal dStockAccount = userBLL.GetMoney(userInfo.UserID, "StockAccount");
                        if (dStockAccount >= changeInfo.Amount)
                        {
                            UpdateAccount("StockAccount", userInfo.UserID, changeInfo.Amount, 0);//
                            UpdateAccount("StockAccount", toUserID, changeInfo.Change005, 1);//
                            //加入流水账表（佣金币减少）
                            lgk.Model.tb_journal jmodel = new lgk.Model.tb_journal();
                            jmodel.UserID = userInfo.UserID;
                            jmodel.Remark = "激活分转给" + toUser.UserCode;
                            jmodel.RemarkEn = "Investment BonusAccount transferred to other member";
                            jmodel.InAmount = 0;
                            jmodel.OutAmount = changeInfo.Amount;
                            jmodel.BalanceAmount = userBLL.GetMoney(userInfo.UserID, "StockAccount");
                            jmodel.JournalDate = DateTime.Now;
                            jmodel.JournalType = (int)Library.AccountType.激活分;
                            jmodel.Journal01 = toUserID;
                            journalBLL.Add(jmodel);

                            //加入流水账表(现金币增加)
                            lgk.Model.tb_journal journalInfo = new lgk.Model.tb_journal();
                            journalInfo.UserID = toUserID;
                            journalInfo.Remark = "收到" + userInfo.UserCode + "转来激活分";
                            journalInfo.RemarkEn = "Investment BonusAccount transferred to other member";
                            journalInfo.InAmount = changeInfo.Change005;
                            journalInfo.OutAmount = 0;
                            journalInfo.BalanceAmount = userBLL.GetMoney(toUserID, "StockAccount ");
                            journalInfo.JournalDate = DateTime.Now;
                            journalInfo.JournalType = (int)Library.AccountType.激活分;
                            journalInfo.Journal01 = userInfo.UserID;
                            journalBLL.Add(journalInfo);
                        }
                        else
                        {
                            MessageBox.ShowBox(this.Page, GetLanguage("objectExist"), Library.Enums.ModalTypes.warning);//转帐对象不存在
                            return;
                        }
                        #endregion
                    }
                    else if (changeInfo.ChangeType == 3)//注册分转其他会员
                    {
                        #region 注册分转其他会员
                        decimal dBonusAccount = userBLL.GetMoney(userInfo.UserID, "Emoney");
                        if (dBonusAccount >= changeInfo.Amount)
                        {
                            UpdateAccount("Emoney", userInfo.UserID, changeInfo.Amount, 0);//
                            UpdateAccount("Emoney", toUserID, changeInfo.Change005, 1);//

                            fee = changeInfo.Amount - changeInfo.Change005;
                            //加入流水账表（减少）
                            lgk.Model.tb_journal jmodel = new lgk.Model.tb_journal();
                            jmodel.UserID = userInfo.UserID;
                            jmodel.Remark = "注册分转给" + toUser.UserCode;
                            jmodel.RemarkEn = "Currency to shopping currency";
                            jmodel.InAmount = 0;
                            jmodel.OutAmount = changeInfo.Change005;
                            jmodel.BalanceAmount = userBLL.GetMoney(toUserID, "Emoney");
                            jmodel.JournalDate = DateTime.Now;
                            jmodel.JournalType = (int)Library.AccountType.注册分;
                            jmodel.Journal01 = toUserID;
                            journalBLL.Add(jmodel);

                            //加入流水账表(现金币增加)
                            lgk.Model.tb_journal journalInfo = new lgk.Model.tb_journal();
                            journalInfo.UserID = toUserID;
                            journalInfo.Remark = "收到" + userInfo.UserCode + "转来注册分";
                            journalInfo.RemarkEn = "Currency to shopping currency";
                            journalInfo.InAmount = changeInfo.Change005;
                            journalInfo.OutAmount = 0;
                            journalInfo.BalanceAmount = userBLL.GetMoney(toUserID, "Emoney ");
                            journalInfo.JournalDate = DateTime.Now;
                            journalInfo.JournalType = (int)Library.AccountType.注册分;
                            journalInfo.Journal01 = userInfo.UserID;
                            journalBLL.Add(journalInfo);
                        }
                        #endregion
                    }
                }
                catch
                {
                    MessageBox.ShowBox(this.Page, GetLanguage("addError"), Library.Enums.ModalTypes.error);//添加流水账错误
                }
                MessageBox.ShowBox(this.Page, GetLanguage("TransferSuccess"), Library.Enums.ModalTypes.success, "TransferToEmoney.aspx");//转账成功
            }
            else
            {
                MessageBox.ShowBox(this.Page, GetLanguage("addError"), Library.Enums.ModalTypes.error);//操作失败
            }
        }

        private string GetWhere()
        {
            string strWhere = string.Format("{0}", getLoginID());

            if (dropType.SelectedValue != "0")
            {
                strWhere += " AND c.ChangeType = " + dropType.SelectedValue + "";
            }

            string strStartTime = this.txtStart.Text.Trim();
            string strEndTime = this.txtEnd.Text.Trim();
            if (GetLanguage("LoginLable") == "en-us")
            {
                strStartTime = this.txtStartEn.Text.Trim();
                strEndTime = this.txtEndEn.Text.Trim();
            }

            if (strStartTime != "" && strEndTime == "")
            {
                strWhere += string.Format(" and Convert(nvarchar(10),c.ChangeDate,120) >= '" + strStartTime + "' ");
            }
            else if (strStartTime == "" && strEndTime != "")
            {
                strWhere += string.Format(" and Convert(nvarchar(10),c.ChangeDate,120) <= '" + strEndTime + "' ");
            }
            else if (strStartTime != "" && strEndTime != "")
            {
                strWhere += string.Format(" and Convert(nvarchar(10),c.ChangeDate,120) between '" + strStartTime + "' and '" + strEndTime + "' ");
            }
            return strWhere;
        }

        /// <summary>
        /// 绑定数据
        /// </summary>
        public void BindData()
        {
            bind_repeater(changeBLL.GetDataSet(GetWhere()), Repeater1, "ChangeDate desc", tr1, AspNetPager1);
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            BindData();
        }

        protected void AspNetPager1_PageChanged(object sender, EventArgs e)
        {
            BindData();
        }

        /// <summary>
        /// 根据选择級別获取金額
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void dropCurrency_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (dropCurrency.SelectedValue == "1" || dropCurrency.SelectedValue == "2" || dropCurrency.SelectedValue == "3")
            {
                txtUserCode.Enabled = true;
                txtUserCode.Text = LoginUser.UserCode;
                txtTrueName.Text = LoginUser.NiceName;
            }
            else
            {
                txtUserCode.Enabled = false;
                txtUserCode.Text = string.Empty;
                txtTrueName.Text = string.Empty;
            }
        }

        protected void txtMoney_TextChanged(object sender, EventArgs e)
        {
            string strMoney = txtMoney.Text.Trim();
            if (strMoney != "")
            {
                decimal dResult = 0;
                if (!decimal.TryParse(strMoney, out dResult))
                {
                    MessageBox.ShowBox(this.Page, "请输入正确的金额！", Library.Enums.ModalTypes.error);//添加流水账错误
                    return;
                }
                decimal dFee = dResult * getParamAmount("Transfer3") / 100;
                decimal dValue = dResult - dFee;

                txtActualAmount.Value = dValue.ToString();
            }
        }


    }
}