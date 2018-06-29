<%@ Page Title="" Language="C#" MasterPageFile="~/user/index.Master" AutoEventWireup="true" CodeBehind="OrderBdList.aspx.cs" Inherits="Web.user.Mall.OrderBdList" %>

<asp:content id="Content1" contentplaceholderid="head" runat="server">
</asp:content>
<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>

<asp:content runat="server" contentplaceholderid="ContentPlaceHolder1">

<script src="/JS/My97DatePicker/WdatePicker.js"></script>
<div class="content">

            <div class="container">
                <div class="row">
					<div class="col-md-12">
						<div class="panel panel-default">
							<div class="panel-heading">
								<h3 class="panel-title">我的订单</h3>
							</div>
							<div class="widget-body innerAll overthrow" style="padding: 20px;overflow: auto;">
								<div class="form-inline">
				            		<div class="form-group">
					                    <label class="inline">订单编号</label>
					                    <input type="text" runat="server" id="txtOrdercode" class="form-control">
					                </div>
					            	<div class="form-group">
                                        <label class="inline">购买模式</label>
                                        <asp:DropDownList runat="server" ID="dropBuyState" class="form-control">
                                            <asp:ListItem value="0">全部</asp:ListItem>
				                			<asp:ListItem value="1">报单</asp:ListItem>
                                            <asp:ListItem value="2">复投</asp:ListItem>
                                        </asp:DropDownList>
					                </div>
					                <div class="form-group">
					                    <label class="inline">发布时间</label>
					                    <div class="input-daterange input-group" id="date-range">
										    <input type="text" class="form-control" runat="server" id="txtStartTime" onfocus="WdatePicker()" name="">
                    					
                                            <span class="input-group-addon bg-inverse b-0 text-white">至</span>
					                    
										    <input type="text" class="form-control" runat="server" id="txtEndTime" onfocus="WdatePicker()" name="">
                    				    </div>
					                </div>
                                    <asp:Button runat="server" ID="btnSearch" Text="搜索" CssClass="btn btn-primary" OnClick="btnSearch_Click"/>
					            </div>
								<div class="widget-body innerAll overthrow col-md-12" style="padding: 20px;overflow: auto;">
								    <table class="table table-bordered table-primary table-merge">
										<thead>
											<tr class="tac">
											    <th>订单编号</th>
											    <th>购买数量</th>
												<th>支付金额</th>
												<th>交易时间</th>
                                                <th>购买模式</th>
                                                <th>支付方式</th>
										    </tr>
										</thead>
										<tbody>
                                            <asp:Repeater runat="server" ID="rpOrderList" OnItemDataBound="rpOrderList_ItemDataBound" >
                                                <ItemTemplate>
											<tr class="tac">
												<td th-name="订单编号"><%#Eval("OrderCode") %></td>
												<td th-name="购买数量"><%#Eval("OrderSum") %></td>
												<td th-name="支付金额"><%#Eval("OrderTotal") %></td>
												<td th-name="交易时间"><%#Eval("OrderDate") %></td>
                                                <td th-name="支付方式"><asp:Literal runat="server" ID="ltBuyName"></asp:Literal></td>
                                                <td th-name="支付方式"><asp:Literal runat="server" ID="ltPayName"></asp:Literal></td>
											</tr>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                            <tr runat="server" id="tr1">
                                                <td colspan="7" align="center">暂无记录</td>
                                            </tr>
										</tbody>
									</table>
									<div class="dataTables_paginate paging_simple_numbers" id="example_paginate">
										<div class="page">
                                            <webdiyer:aspnetpager id="AspNetPager1" runat="server" skinid="AspNetPagerSkin" firstpagetext="首页"
                                                lastpagetext="尾页" nextpagetext="下一页" prevpagetext="上一页" alwaysshow="True" inputboxclass="pageinput"
                                                numericbuttoncount="3" pagesize="10" showinputbox="Never" shownavigationtooltip="True"
                                                submitbuttonclass="pagebutton" urlpaging="false" pageindexboxtype="TextBox" showpageindexbox="Always"
                                                submitbuttontext="" textafterpageindexbox=" 页" textbeforepageindexbox="转到 " direction="LeftToRight"
                                                horizontalalign="Right" onpagechanged="AspNetPager1_PageChanged">
                                            </webdiyer:aspnetpager>
										</div>	
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
</div></div>
    
</asp:content>
