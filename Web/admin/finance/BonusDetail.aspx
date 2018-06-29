﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BonusDetail.aspx.cs" Inherits="Web.admin.finance.BonusDetail" %>

<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="x-ua-compatible" content="ie=7" />
    <title></title>
    <link rel="stylesheet" type="text/css" href="../css/style.css" />

    <script type="text/javascript" src="../../JS/jquery-1.7.1.min.js"></script>
    <script type="text/javascript" src="../../JS/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="../Scripts/Common.js"></script>
    <script type="text/javascript" language="javascript" src="/Js/My97DatePicker/WdatePicker.js"></script>
    <script src="../Scripts/main-layout.js" type="text/javascript"></script>
</head>
<body>
    <form id="Form1" runat="server"  class="form-inline">
        <div class="mainwrapper" style="top: 0px; background-color: #E8E8FF">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h4 class="panel-title">查询</h4>
                </div>
                <div class="panel-body">
                    <div class="form-inline"  >
                        <div class="mb15">
                            <div class="form-group mt10">
                                <label class="control-label">会员编号:</label>
                                <asp:TextBox ID="txtUserCode" tip="输入会员编号"
                                    runat="server" class="form-control"></asp:TextBox>
                            </div>
                            <div class="form-group mt10">
                                <label class="control-label">会员姓名:</label>
                                <asp:TextBox ID="txtTrueName" tip="输入姓名" runat="server" class="form-control"></asp:TextBox>
                            </div>
                            <div class="form-group mt10">
                                <asp:LinkButton ID="lbtnSearch" runat="server" class="btn btn-primary mr5 mb10" iconcls="icon-search"
                                    OnClick="lbtnSearch_Click"><i class="fa fa-search"></i> 搜 索 </asp:LinkButton>
                                <asp:LinkButton ID="lbtnBack" runat="server" class="btn btn-primary mb10" iconcls="icon-search"
                                    PostBackUrl="Bonus.aspx">返 回 </asp:LinkButton>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- panel-body -->
            </div>
            <div class="panel panel-default">
                <div class="panel-body">
                    <table class="table table-bordered table-primary mb30">
                        <thead>
                            <tr>
                                <th style="min-width: 80px;">会员编号</th>
                                <th style="min-width: 80px;">会员姓名</th>
                                <th style="min-width: 80px;">共享奖励</th>
                                <th style="min-width: 80px;">分享奖励</th>
                                <th style="min-width: 80px;">见点奖励</th>
                                <th style="min-width: 80px;">报单奖励</th>
                                <th style="min-width: 80px;">级差奖励</th>
                                <th style="min-width: 80px;">荣誉奖励</th>
                                <th style="min-width: 80px;">应发</th>
                                <th style="min-width: 80px;">平台服务费</th>
                                <th style="min-width: 80px;">实发</th>
                                <th style="min-width: 80px;">结算日期</th>
                                <th style="min-width: 80px;">查看明细</th>
                            </tr>
                        </thead>
                        <asp:Repeater ID="Repeater1" runat="server" OnItemCommand="Repeater1_ItemCommand">
                            <ItemTemplate>
                                <tr>
                                    <td data-attr="会员编号">
                                        <%#Eval("UserCode")%><%--会员编号--%>
                                    </td>
                                    <td data-attr="会员姓名">
                                        <%#Eval("TrueName")%><%--会员编号--%>
                                    </td>
                                    <td data-attr="共享奖励">
                                        <%#Eval("rfh")%><%--1.共享奖励--%>
                                    </td>
                                    <td data-attr="分享奖励">
                                        <%#Eval("fx")%><%--2.分享奖励--%>
                                    </td>
                                    <td data-attr="见点奖励">
                                        <%#Eval("jd")%><%--3.见点奖励--%>
                                    </td>
                                    <td data-attr="报单奖励">
                                        <%#Eval("bd")%><%--1.报单奖励--%>
                                    </td>
                                    <td data-attr="级差奖励">
                                        <%#Eval("jc")%><%--2.级差奖励--%>
                                    </td>
                                    <td data-attr="荣誉奖励">
                                        <%#Eval("ry")%><%--3.荣誉奖励--%>
                                    </td>
                                    <td data-attr="应发">
                                        <%#Eval("am")%><%--应发--%>
                                    </td>
                                    <td data-attr="平台服务费">
                                        <%#Eval("Revenue")%><%--平台服务费--%>
                                    </td>
                                    <td data-attr="实发">
                                        <%#Eval("sf")%><%--实发--%>
                                    </td>
                                    <td data-attr="结算日期">
                                        <%#Eval("SttleTime")%><%--结算日期--%>
                                    </td>
                                    <td data-attr="查看明细">
                                        <asp:LinkButton ID="lbtnDetail" runat="server" CommandArgument='<%# Eval("UserID") %>'
                                            class="btn btn-info" iconcls="icon-search" CommandName="Open"><i class="fa fa-search"></i>查看明细</asp:LinkButton>
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                        <tr id="trBonusNull" runat="server" class="none">
                            <td colspan="15" align="center">抱歉！目前数据库暂无数据显示。</td>
                        </tr>
                    </table>
                    <div class="nextpage cBlack">

                        <webdiyer:AspNetPager ID="AspNetPager1" runat="server"  CssClass="pagination" LayoutType="Ul" PagingButtonLayoutType="UnorderedList" PagingButtonSpacing="0" CurrentPageButtonClass ="active"
                             FirstPageText="首页"
                            LastPageText="尾页" NextPageText="下一页" PrevPageText="上一页" AlwaysShow="True" InputBoxClass="pageinput"
                            NumericButtonCount="3" PageSize="12" ShowInputBox="Never" ShowNavigationToolTip="True"
                            SubmitButtonClass="pagebutton" UrlPaging="false" pageindexboxtype="TextBox" showpageindexbox="Always"
                            SubmitButtonText="转到" textafterpageindexbox=" 页" textbeforepageindexbox="转到 " Direction="LeftToRight"
                            HorizontalAlign="Center" OnPageChanged="AspNetPager1_PageChanged">
                        </webdiyer:AspNetPager>
                     
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
