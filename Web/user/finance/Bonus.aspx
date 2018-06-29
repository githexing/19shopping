﻿<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/user/index.Master" CodeBehind="Bonus.aspx.cs" Inherits="Web.user.finance.Bonus" %>

<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<asp:content runat="server" contentplaceholderid="ContentPlaceHolder1">
     <script type="text/javascript" src="/Js/My97DatePicker/WdatePicker.js"></script>
 
        <!-- Start content -->
        <div class="content">
            <div class="container">

                <div class="row">
                    <div class="col-lg-3 col-md-6">
                        <div class="card-box widget-user">
                            <div class="text-center">
                                <h2 class="text-custom"><%=GetBonus(getLoginID(), 1)%></h2>
                                <h5>共享奖励累计</h5>
                            </div>
                        </div>
                    </div>
                     <div class="col-lg-3 col-md-6">
                        <div class="card-box widget-user">
                            <div class="text-center">
                                <h2 class="text-pink"><%=GetBonus(getLoginID(), 2)%></h2>
                                <h5>分享奖励累计</h5>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="card-box widget-user">
                            <div class="text-center">
                                <h2 class="text-pink"><%=GetBonus(getLoginID(), 3)%></h2>
                                <h5>见点奖励累计</h5>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="card-box widget-user">
                            <div class="text-center">
                                <h2 class="text-custom"><%=GetBonus(getLoginID(), 4)%></h2>
                                <h5>报单奖励累计</h5>
                            </div>
                        </div>
                    </div>
                     <div class="col-lg-3 col-md-6">
                        <div class="card-box widget-user">
                            <div class="text-center">
                                <h2 class="text-pink"><%=GetBonus(getLoginID(), 5)%></h2>
                                <h5>级差奖励累计</h5>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="card-box widget-user">
                            <div class="text-center">
                                <h2 class="text-pink"><%=GetBonus(getLoginID(), 6)%></h2>
                                <h5>荣誉奖励累计</h5>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-sm-12">
                        <div class="card-box">
                            <h4 class="header-title m-t-0 m-b-30"><%=GetLanguage("Query") %><%--查询--%></h4>
                            <div class="row">
                                <div class="form-inline col-sm-12">
                                    <div class="form-group">
                                        <label><%=GetLanguage("SettlementDate")%><%--结算日期--%></label>
                                        <div class="input-daterange input-group" id="date-range">
                                            <%if (GetLanguage("LoginLable") == "zh-cn")
                                                {%>
                                            <asp:TextBox ID="txtStart" tip="输入结算日期" class="form-control" name="start" runat="server" onfocus="WdatePicker()"></asp:TextBox>
                                            <%}
                                                else
                                                {%>
                                            <asp:TextBox ID="txtEnd" tip="input close an account date" class="form-control" name="start" runat="server" onfocus="WdatePicker({lang:'en'})"></asp:TextBox>
                                            <%} %>

                                            <span class="input-group-addon bg-inverse b-0 text-white"><%=GetLanguage("To") %><%--至--%></span>
                                            <%if (GetLanguage("LoginLable") == "zh-cn")
                                                            {%>
                                                        <asp:TextBox ID="txtStartEn" tip="输入结算日期" runat="server" class="form-control" name="end" onfocus="WdatePicker()"></asp:TextBox>
                                                        <%}
                                                            else
                                                            {%>
                                                        <asp:TextBox ID="txtEndEn" tip="input close an account date" class="form-control" name="end" runat="server" onfocus="WdatePicker({lang:'en'})"></asp:TextBox>
                                                        <%} %>
                                        </div>
                                    </div>
                                     <asp:Button ID="btnSearch" runat="server" class="btn btn-success btn-md" OnClick="btnSearch_Click" />
                                   
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-sm-12">
                        <div class="card-box">
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="table-merge table-responsive">
                                        <table class="table table-condensed m-0">
                                            <thead>
                                                <tr>
                                                   <th>共享奖励</th>
                                                    <th>分享奖励</th>
                                                    <th>见点奖励</th>
                                                    <th>报单奖</th>
                                                    <th>级差奖</th>
                                                    <th>荣誉奖</th>
                                                    <th>应发</th>
                                                    <th>平台服务费</th>
                                                    <th>实发</th>
                                                    <th><%=GetLanguage("SettlementDate") %><%--结算日期--%></th>
                                                    <th><%=GetLanguage("ViewDetails") %><%--查看明细--%></th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                 <asp:Repeater ID="Repeater1" runat="server">
                                                        <ItemTemplate>
                                                           
                                                <tr>
                                                    <td th-name="共享奖励"><%#Eval("rfh")%></td>
                                                    <td th-name="分享奖励"><%#Eval("fx")%></td>
                                                    <td th-name="见点奖励"><%#Eval("jd")%></td>
                                                    <td th-name="报单奖"><%#Eval("bd")%></td>
                                                    <td th-name="级差奖"><%#Eval("jc")%></td>
                                                    <td th-name="荣誉奖"><%#Eval("ry")%></td>
                                                    <td th-name="应发"><%#Eval("am")%></td>
                                                    <td th-name="平台服务费"><%#Eval("Revenue")%></td>
                                                    <td th-name="实发"><%#Eval("sf")%></td>
                                                    <td th-name="结算日期"><%#Eval("SttleTime")%></td>
                                                    <td th-name="查看明细"><asp:LinkButton ID="lbtnDetail" runat="server" class="btn btn-custom btn-sm" PostBackUrl='<%#Eval("SttleTime","BonusDetail.aspx?SttleTime={0}") %>'><%=GetLanguage("ViewDetails")%><!--查看明细--></asp:LinkButton></td>
                                                </tr>
                                             </ItemTemplate>
                                                    </asp:Repeater>
                                               
                                            </tbody>
                                             <tr id="tr1" runat="server">
                                                    <td colspan="8" class="colspan">
                                                        <div class="form-control-static text-center"><i class="fa fa-warning text-warning"></i><%=GetLanguage("Manager")%><!--抱歉！目前数据库暂无数据显示。--></div>
                                                    </td>
                                                </tr>
                                        </table>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-12">
                                    <webdiyer:AspNetPager ID="AspNetPager1" runat="server" CssClass="pagination" LayoutType="Ul" PagingButtonLayoutType="UnorderedList" 
                                                  NumericButtonCount="3" PageSize="12"  
                                                ShowNavigationToolTip="True" SubmitButtonClass="pagebutton" UrlPaging="false"   PagingButtonSpacing="0" CurrentPageButtonClass ="active"
                                               OnPageChanged="AspNetPager1_PageChanged">
                                            </webdiyer:AspNetPager>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- End row -->

            </div>
            <!-- container -->

        </div>
        <!-- content -->
 
</asp:content>
