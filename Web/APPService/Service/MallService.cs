using Library;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;

namespace Web.APPService.Service
{
    public class MallService : AllCore
    {
        public class GetGoods
        {
            public long ID { get; set; }
            public int num { get; set; }
        }

        #region 购买
        public bool GoodsCartPay(long userid, int paytype, long addrid, string strcid, int shtype, out string msg)
        {
            if(paytype != 4)
            {
                msg = "请选择正确的支付方式";
                return false;
            }
            if(shtype <= 0)
            {
                msg = "请选择正确的收货方式";
                return false;
            }
            if (!userBLL.Exists(userid))
            {
                msg = "请重新登录再支付";
                return false;
            }
            JavaScriptSerializer js = new JavaScriptSerializer();

            var list = js.Deserialize<List<GetGoods>>(strcid);
            LogHelper.SaveLog(strcid, "GoodsCartPay");
            
            if (list.Count<=0)
            {
                msg = "请选择购物车中的商品";
                return false;
            }

            Random rand = new Random();
            string orderCode = DateTime.Now.ToString("yyyyMMddhhmmss") + rand.Next(10000, 99999); //订单编号
            string goodsname = string.Format("订单号{0}，", orderCode);
            decimal totalMoney = 0;
            int orderSum = 0;
            int insert = 0;
            DateTime dtime = DateTime.Now;


            if (!userBLL.Exists(userid))
            {
                msg = "用户不存在";
            }
            
            //if (addrid!=1)
            //{ 
          
            //    lgk.Model.tb_Address addrModel = addressBLL.GetModel(addrid);
            //    if(addrModel == null)
            //    {
            //        msg = "请选择收货地址";
            //        return false;
            //    }
            //}
            IList<lgk.Model.tb_goodsCar> listCar = new List<lgk.Model.tb_goodsCar>();

            #region 验证商品
            string errmsg = "";
            foreach (GetGoods g in list)
            {
                lgk.Model.tb_goodsCar carModel = goodsCarBLL.GetModel(g.ID);
                if (carModel != null)
                {
                    lgk.Model.tb_goods goodsModel = goodsBLL.GetModelAndOneName(carModel.GoodsID);//根据发布商品编号找到充值账号密码
                    if(goodsModel == null)
                    {
                        errmsg = "商品" + goodsModel.GoodsName + "不存在!";
                        insert = 0;
                        break;
                    }
                    if (g.num <= 0)
                    {
                        errmsg = "商品" + goodsModel.GoodsName + "的购买数量必须大于0!";
                        insert = 0;
                        break;
                    }
                    if (goodsModel.StateType == 0) //判断是否 审核通过 0未审核
                    {
                        errmsg = "商品" + goodsModel.GoodsName + "审核未通过,请删除该商品!";
                        insert = 0;
                        break;
                    }
                    else if (goodsModel.Goods003 == "1") //判断是否 删除 1已经删除
                    {
                        errmsg = "商品" + goodsModel.GoodsName + "已被删除,请删除该商品!";
                        insert = 0;
                        break;
                    }
                    else if (goodsModel.Goods001 == 0) //判断是否 0下架
                    {
                        errmsg = "商品" + goodsModel.GoodsName + "已经下架,请删除该商品!";
                        insert = 0;
                        break;
                    }
                    else if (goodsModel.Goods002 < g.num) //判断库存量
                    {
                        errmsg = "商品" + goodsModel.GoodsName + "库存不足,请重新修改数量!";
                        insert = 0;
                        break;
                    }
                    else if (carModel.BuyUser != userid) //
                    {
                        errmsg = "用户不匹配，请刷新购物车再提交!";
                        insert = 0;
                        break;
                    }
                    carModel.Goods006 = g.num;//以最中传输的数量为准
                    listCar.Add(carModel);
                    insert += 1;
                }
                else
                {
                    msg = "购物出为空";
                    LogHelper.SaveLog(g.ID.ToString() + "," + errmsg, "GoodsCartPay");
                    return false;
                }
            }

            if (insert == 0)
            {
                msg = errmsg;
                return false;
            }
            #endregion

            //总金额
            totalMoney += listCar.Sum(s => s.TotalMoney);
            orderSum += listCar.Sum(s => s.Goods006);
            lgk.Model.tb_user userModel = userBLL.GetModel(userid);
            //var dt = orderBLL.GetList(" UserID=" + userid ).Tables[0];
            //if (pay == 1 && dt.Rows.Count>0)
            //{

            //}  sss                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
            //else if (pay == 2 && dt.Rows.Count == 0)
            //{
            
            //}

            if (paytype==4&& userModel.GLmoney < totalMoney)
            {
                msg = "购物分余额不足";
                return false;
            }
            
            
            #region 订单处理
            //总订单
            lgk.Model.tb_Order orderModel = new lgk.Model.tb_Order();//订单
            orderModel.UserID = userid;//用户
            orderModel.OrderCode = orderCode;//订单编号
            orderModel.OrderSum = orderSum;//订单数--
            orderModel.OrderTotal = totalMoney;//购买总金
            orderModel.PVTotal = 0;//
            orderModel.OrderDate = dtime;
            orderModel.IsSend = 1;
            orderModel.PayMethod = 3;//--2、复投 1注册激活,3购物分
            orderModel.Order5 = "";//备用电话
            orderModel.UserAddr = userModel.Address;//addrModel.Address;//发货地址
            orderModel.Order6 = userModel.PhoneNum;//addrModel.PhoneNum;//收货电话
            orderModel.Order7 = userModel.NiceName; //addrModel.MemberName;//收货姓名
            orderModel.OrderType = paytype;//购物分
            orderModel.ReceiveType = shtype;
            long iOrderID = orderBLL.Add(orderModel);//加入订单表

            foreach (var carModel in listCar)
            {
                lgk.Model.tb_goods goodsModel = goodsBLL.GetModelAndOneName(carModel.GoodsID);//根据发布商品编号找到充值账号密码
                //插入订单详细表
                lgk.Model.tb_OrderDetail orderDetailModel = new lgk.Model.tb_OrderDetail();
                orderDetailModel.OrderCode = orderCode;
                orderDetailModel.Price = carModel.RealityPrice;//单价--
                orderDetailModel.OrderSum = carModel.Goods006;//数量--
                orderDetailModel.OrderTotal = carModel.Goods006 * carModel.RealityPrice;//订单金额
                orderDetailModel.PV = 0;//
                orderDetailModel.PVTotal = 0;
                orderDetailModel.ProcudeID = carModel.GoodsID; //产品编号--
                orderDetailModel.ProcudeName = carModel.GoodsName;//名称--
                orderDetailModel.gColor = carModel.gColor;
                orderDetailModel.gSize = carModel.gSize;
                orderDetailModel.OrderDate = dtime;//
                orderDetailBLL.Add(orderDetailModel);//加入订单详情

                //修改库存
                goodsModel.Goods002 = goodsModel.Goods002 - carModel.Goods006;//修改库存
                goodsModel.SaleNum += carModel.Goods006;
                goodsBLL.Update(goodsModel);

                //从购物篮减掉
                goodsCarBLL.Delete(carModel.ID);

                //商品名称 流水表记录用
                goodsname += orderDetailModel.ProcudeName + "|";

                orderSum += carModel.Goods006;
            }
            #endregion

            #region 写入到明细表

            lgk.Model.tb_journal joModel = new lgk.Model.tb_journal();
            joModel.UserID = userModel.UserID;
            joModel.Remark = goodsname;//名称--;
            joModel.InAmount = 0;//收入0;
            joModel.OutAmount = totalMoney;//购买价(支出金币)
            joModel.JournalDate = DateTime.Now;
            joModel.Journal01 = userModel.UserID;//
            joModel.Journal02 = 99;//消费
            joModel.Journal03 = orderCode;//订单编号
            if (paytype == 4)//购物分
            {
                joModel.JournalType = 5;//币种
                joModel.BalanceAmount = userModel.GLmoney - totalMoney;//余额
                journalBLL.Add(joModel);
                UpdateAccount("GLmoney", userModel.UserID, totalMoney, 0);
            }
            
            //用户账户更新

            #endregion

            //购物积分购买不给分红点
            //执行存储过程
            //string procmsg = string.Empty;
            //procmsg = proc_BuyOrder(userid, orderModel.OrderSum, orderCode, 4, totalMoney);
            //LogHelper.SaveLog("procmsg:" + procmsg, "proc_BuyOrder");

            msg = "支付成功";
            return true;
        }
        #endregion

        #region 加入购物车
        public bool AddGoodCar(long userid, long goodsid, int buynum, out string msg)
        {
            if (!userBLL.Exists(userid))
            {
                msg = "用户不存在";
            }
            lgk.Model.tb_goods goodsInfo = goodsBLL.GetModel(goodsid);
            if (goodsInfo == null)
            {
                msg = "此商品不存在!";
                return false;
            }
            lgk.Model.tb_goodsCar goodsCarInfo = new lgk.Model.tb_goodsCar();
            if (goodsInfo.Goods002 <= 0)
            {
                msg = "商品库存不足!";
                return false;
            }
            if (goodsInfo.Goods002 < buynum)
            {
                msg = "商品库存不足!";
                return false;
            }
            goodsCarInfo.GoodsID = goodsInfo.ID;
            goodsCarInfo.GoodsCode = goodsInfo.GoodsCode;
            goodsCarInfo.GoodsName = goodsInfo.GoodsName;
            goodsCarInfo.Price = goodsInfo.Price;
            goodsCarInfo.RealityPrice = goodsInfo.RealityPrice;
            goodsCarInfo.ShopPrice = goodsInfo.ShopPrice;

            goodsCarInfo.TypeID = goodsInfo.TypeID;
            goodsCarInfo.TypeIDName = produceTypeBLL.GetTypeName(goodsInfo.TypeID);
            goodsCarInfo.GoodsType = goodsInfo.GoodsType;
            goodsCarInfo.GoodsTypeName = produceTypeBLL.GetTypeName(goodsInfo.GoodsType);
            goodsCarInfo.Pic1 = goodsInfo.Pic1;
            goodsCarInfo.Remarks = goodsInfo.Remarks;
            goodsCarInfo.Goods002 = goodsInfo.Goods002;
            goodsCarInfo.Goods005 = decimal.Parse(goodsInfo.Goods005.ToString());

            goodsCarInfo.Goods006 = buynum;//购买数量
            goodsCarInfo.BuyUser = userid;//购买者
            goodsCarInfo.TotalMoney = goodsCarInfo.Goods006 * goodsCarInfo.RealityPrice;//总金
            goodsCarInfo.TotalGoods006 = 0;//总积分
            goodsCarInfo.AddTime = DateTime.Now;
            //goodsCarInfo.gColor = hhcolor.Value.Trim();
            //goodsCarInfo.gSize = hhsize.Value.Trim();
            string where = string.Format(" BuyUser ={0} and GoodsID={1}", goodsCarInfo.BuyUser, goodsCarInfo.GoodsID);
            lgk.Model.tb_goodsCar _carModel = new lgk.Model.tb_goodsCar();
            _carModel = goodsCarBLL.GetModel(where);

            DataSet dsCount = goodsCarBLL.GetList("BuyUser=" + userid);
            if (dsCount.Tables[0].Rows.Count > 50)
            {
                msg = "购物车商品已经装满!";
                return false;
            }
            #region
            if (_carModel != null && _carModel.GoodsID > 0 && _carModel.RealityPrice == goodsInfo.RealityPrice) //购物车中已经存在
            {
                _carModel.Goods006 += goodsCarInfo.Goods006;//加上原来的数量
                 // _carModel.Goods002 += carModel.Goods002;
                _carModel.TotalMoney += goodsCarInfo.TotalMoney;//总金额
                //_carModel.TotalGoods006 += goodsCarInfo.TotalGoods006;
                if (goodsCarBLL.Update(_carModel) == true)
                {
                    msg = "加入购物车成功";
                }
                else
                {
                    msg = "加入购物车失败,请重试!";
                    return false;
                }
            }
            else
            {
                if (goodsCarBLL.Add(goodsCarInfo) > 0)
                {
                    msg = "加入购物车成功";
                }
                else
                {
                    msg = "加入购物车失败,请重试!";
                    return false;
                }
            }
            #endregion

            return true;
        }
        #endregion

        #region 购物车数量管理
        public bool NumManage(long id, int type, int num, out string msg)
        {
            lgk.Model.tb_goodsCar carModel = goodsCarBLL.GetModel(id);
            if (carModel == null)
            {
                msg = "数据不存在";
                return false;
            }
            if (carModel.Goods006 <= 1 && type == 1)
            {
                msg = "数量不可再减";
                return false;
            }

            //if (type == 1)
            //{
                carModel.Goods006 = num;
            //}
            //else if (type == 2)
            //{
            //    carModel.Goods006 += num;
            //}
            carModel.TotalMoney = carModel.Goods006 * carModel.RealityPrice;
            if (goodsCarBLL.Update(carModel))
            {
                //if (type == 1)
                //{
                    msg = "更新成功";//扣除数量成功
                //}
                //else
                //{
                //    msg = "更新成功";//增加数量成功
                //}
                return true;
            }
            else
            {
                //if (type == 1)
                //{
                    msg = "更新失败";//扣除数量失败
                //}
                //else
                //{
                //    msg = "失败";//增加数量失败
                //}
                return false;
            }
        }
        #endregion

        #region 删除购物车
        public bool GoodsCartDel(long id, out string msg)
        {
            lgk.Model.tb_goodsCar carModel = goodsCarBLL.GetModel(id);
            if (carModel == null)
            {
                msg = "该记录已删除";
                return false;
            }
            if (goodsCarBLL.Delete(carModel.ID))
            {
                msg = "删除成功";
                return true;
            }
            else
            {
                msg = "删除失败";
                return false;
            }
        } 
        #endregion

    }
}
