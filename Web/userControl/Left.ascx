<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Left.ascx.cs" Inherits="Web.userControl.Left" %>
<div class="left side-menu">
    <div id="particles-js" class="side-menu-bg" style="position: absolute; bottom: 0; right: 0; left: 0; top: 0;"></div>

    <div class="sidebar-inner slimscrollleft">

        <!-- User -->
        <div class="user-box">
            <style type="text/css">
                .user-box h5 {
                    text-align: left;
                    padding-left: 70px;
                }

                    .user-box h5 span {
                        display: inline-block;
                        width: 60px;
                    }
            </style>
            <h5><a href="/user/member/PersonalInfo.aspx"><span>编号：</span><asp:Literal runat="server" ID="ltUserCode"></asp:Literal></a> </h5>
            <h5><a href="javascript:void(0);"><span>昵称：</span><asp:Literal runat="server" ID="ltNicheng"></asp:Literal></a></h5>
            <h5><a href="javascript:void(0);"><span>等级：</span><asp:Literal runat="server" ID="ltLevelName"></asp:Literal></a></h5>

            <ul class="list-inline">
                <li>
                    <a href="/user/member/ModifyPassWord.aspx">
                        <i class="zmdi zmdi-settings"></i>
                    </a>
                </li>

                <li>
                    <a href="../../loginout.aspx" class="text-custom">
                        <i class="zmdi zmdi-power"></i>
                    </a>
                </li>

            </ul>
        </div>
        <!-- End User -->
        <div id="sidebar-menu">
            <ul>
                <li class="text-muted menu-title"><%--菜单--%><%=GetLanguage("Menu") %></li>

                <li>
                    <a href="/user/index.aspx" class="waves-effect"><i class="zmdi zmdi-home"></i><span><%--首页--%><%=GetLanguage("index") %> </span></a>
                </li>

                <li class="has_sub">
                    <a href="javascript:void(0);" class="waves-effect"><i class="fa fa-user"></i><span><%--用户中心--%><%=GetLanguage("UserCenter") %> </span><span class="menu-arrow"></span></a>
                    <ul class="list-unstyled">
                        <li><a href="/user/member/PersonalInfo.aspx"><%--会员资料--%><%=GetLanguage("MemberInformation") %></a></li>
                        <li><a href="/user/member/ModifyPassWord.aspx"><%--修改密码--%><%=GetLanguage("ModifyPassword") %></a></li>
                        <%if (isactive == 0)
                            { %>
                            <li><a href="/user/member/ActiveUser.aspx"><!--激活会员--><%=GetLanguage("OpenUser") %></a></li>
                        <%} %>
                        <%-- <li><a href="/user/member/PopLink.aspx">推广链接</a></li>--%>
                        <!--<li><a href="/user/member/UserBank.aspx"><%--银行卡管理--%><%=GetLanguage("UserBank") %></a></li>-->
                        <li><a href="/user/team/Agent.aspx"><%--申请服务中心--%><%=GetLanguage("ApplyCentre") %></a></li>
                    </ul>
                </li>

                <li class="has_sub">
                    <a href="javascript:void(0);" class="waves-effect"><i class="zmdi zmdi-view-list"></i><span><%--帐号管理--%><%=GetLanguage("AccountManagement") %> </span><span class="menu-arrow"></span></a>
                    <ul class="list-unstyled">
                        <li><a href="/user/Registers.aspx"><%--会员注册--%><%=GetLanguage("Register") %></a></li>
                        <li><a href="/user/team/Member.aspx">
                            <!--待激活会员-->
                            <%=GetLanguage("OpenMembership") %></a></li>
                        <li><a href="/user/team/MemberList.aspx"><!--我的市场--><%=GetLanguage("AvailableMembers") %></a></li>
                        <li><a href="/user/team/Futou.aspx"><!--会员复投-->会员复投</a></li>
                        <%--    <li><a href="/user/team/TableTree.aspx"><%--会员列表--%><%--<%=GetLanguage("MemberList") %></a></li>--%>
                        <li><a href="/user/team/RecommendTree.aspx">
                            <!--直接推荐图-->
                            <%=GetLanguage("ThisFigure") %></a></li>
                    </ul>
                </li>

                <li class="has_sub">
                    <a href="javascript:void(0);" class="waves-effect"><i class="zmdi zmdi-chart"></i><span><%--财务中心--%><%=GetLanguage("FinanceCenter") %> </span><span class="menu-arrow"></span></a>
                    <ul class="list-unstyled">
                        <!--<li><a href="/user/finance/Remit.aspx"><%--充值--%><%=GetLanguage("Rechargemanagement") %></a></li>-->
                        <li><a href="/user/finance/Bonus.aspx"><%--奖金明细--%><%=GetLanguage("MemberBonus") %></a></li>
                        <li><a href="/user/finance/dl_JournalAccount.aspx"><%--个人账户--%><%=GetLanguage("PersonalAccount") %></a></li>
                        <li><a href="/user/finance/TransferToEmoney.aspx"><%--转账管理--%><%=GetLanguage("TransferManagement") %></a></li>
                        <li><a href="/user/finance/TakeMoney.aspx"><%--提现管理--%><%=GetLanguage("WithdrawalManage") %></a></li>
                    </ul>
                </li>

                <li class="has_sub">
                    <a href="javascript:void(0);" class="waves-effect"><i class="zmdi zmdi-chart"></i><span><%--商品订单--%><%=GetLanguage("ShoppingMall") %> </span><span class="menu-arrow"></span></a>
                    <ul class="list-unstyled">
                        <li><a href="/user/finance/dl_JournalEmoney.aspx">购物分</a></li>
                        <li><a href="/user/Mall/GoodsList.aspx">商品列表</a></li>
                        <li><a href="/user/Mall/GoodsCart.aspx">购物车</a></li>
                        <li><a href="/user/Mall/OrderList.aspx">订单列表</a></li>
                    </ul>
                </li>

                <li class="has_sub">
                    <a href="javascript:void(0);" class="waves-effect"><i class="zmdi zmdi-sort-amount-desc"></i><span><%--信息管理--%><%=GetLanguage("InformationManaget") %> </span><span class="menu-arrow"></span></a>
                    <ul class="list-unstyled">
                        <li><a href="/user/member/NoticeList.aspx"><%--新闻中心--%><%=GetLanguage("NewsInformation") %></a></li>
                        <li><a href="/user/member/Leavewords.aspx"><%--我要留言--%><%=GetLanguage("Sendmail") %></a></li>
                        <li><a href="/user/member/LeaveMsg.aspx"><%--收取邮件--%><%=GetLanguage("Receivemail") %></a></li>
                        <li><a href="/user/member/LeaveOut.aspx"><%--已发信件--%><%=GetLanguage("HaveEmail") %></a></li>
                    </ul>
                </li>

            </ul>
            <div class="clearfix"></div>
        </div>
        <!-- Sidebar -->
        <div class="clearfix"></div>
    </div>
</div>
