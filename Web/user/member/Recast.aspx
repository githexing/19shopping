﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Recast.aspx.cs" Inherits="Web.user.member.Recast" %>
<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="content-type" content="text/html;charset=UTF-8" />
    <meta charset="utf-8" />
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <meta content="" name="description" />
    <meta content="" name="author" />
    <link rel="stylesheet" type="text/css" href="../../css/font-awesome.css" />
    <link rel="stylesheet" type="text/css" href="../../css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="../../css/animate.min.css" />
    <link rel="stylesheet" type="text/css" href="../../css/style.css" />
     <%-- <link href="../../static/css/style.css" rel="stylesheet" type="text/css" media="all" />--%>
</head>
<body>
    <form id="Form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <!-- BEGIN CONTAINER -->
        <div class="page-container row-fluid">

            <!-- BEGIN PAGE CONTAINER-->
            <div class="page-content">
                <div class="content">
                    <div class="page-title">
                        <h3><%=GetLanguage("NumberRecast")%><%--账号复投--%></h3>
                    </div>
                    <div id="container">
                        <div class="row m-b-20">
                            <div class="col-md-12">
                                <div class="grid simple line">
                                    <div class="grid-title no-border">
                                        <h4>账号信息</h4>
                                    </div>
                                    <div class="grid-body no-border">
                                        <div class="row-fluid ">
                                            <div class="col-md-6">
                                                <address class="margin-bottom-20 margin-top-10">
                                                    <strong><%=GetLanguage("MembershipNumber")%><%--会员编号--%>：</strong> <span><%=LoginUser.UserCode %></span>
                                                </address>
                                                <address class="margin-bottom-20 margin-top-10">
                                                    <strong><%=GetLanguage("Name")%><%--会员姓名--%>：</strong> <span><%=LoginUser.TrueName %></span>
                                                </address>
                                                <address class="margin-bottom-20 margin-top-10">
                                                    <strong>消费金余额：</strong> <span>
                                                        <asp:Literal ID="LitTotalAAmount" runat="server"></asp:Literal>$</span>
                                                </address>
                                                <address class="margin-bottom-20 margin-top-10">
                                                    <strong><%=GetLanguage("ContactPhone")%><%--联系电话--%>：</strong> <span><%=LoginUser.PhoneNum %></span>
                                                </address>
                                            </div>
                                            <div class="col-md-6">
                                               <%-- <address class="margin-bottom-20 margin-top-10">
                                                    <strong><%=GetLanguage("WhetherCast")%><%--是否可复投--%：</strong> <span>
                                                        <asp:Literal ID="LitWhetherCast" runat="server"></asp:Literal></span>
                                                </address>--%>
                                                <address class="margin-bottom-20 margin-top-10">
                                                    <strong><%=GetLanguage("RecastNumber")%><%--复投次数--%>：</strong> <span><%=LoginUser.BillCount %></span>
                                                </address>
                                                <address class="margin-bottom-20 margin-top-10">
                                                    <strong>复投金额：</strong> <span>
                                                        <asp:Literal ID="LiteraCapValue" runat="server"></asp:Literal>$</span>
                                                </address>
                                                <address class="margin-bottom-20 margin-top-10">
                                                    <strong><%=GetLanguage("IDNumber")%><%--身份证号--%>：</strong> <span><%=LoginUser.IdenCode %></span>
                                                </address>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row m-b-20">
                            <div class="col-md-12">
                                <div class="grid simple line">
                                    <div class="grid-title no-border">
                                        <h4>申请复投</h4>
                                    </div>
                                    <div class="grid-body no-border">
            				<div class="row">
	                		<div class="col-md-3 m-b-20">
	                			 <div class="col-md-3 m-b-20" style="display:none" id="img">
                                        <asp:Image ID="Image1" runat="server" style="width: 100%; max-width: 240px;" />
                                    
	                		</div>
	                		</div>
	                		<div class="col-md-9">
	                			<div class="form-horizontal row">
	                				<div class="form-group col-md-6 col-sm-12">
	            					    <label class="col-md-4 control-label"> 会员等级：</label>
                                        <div class="col-md-8">
                            	            <span class="form-line"><input name="txtInput" id="droplevel" class="form-control"  disabled="disabled" runat="server" type="text" /></span>
                                        </div>
	                                </div>
                                   <div class="form-group col-md-6 col-sm-12">
	            				        <label class="col-md-4 control-label"> 选择支付方式：</label>
                                        <div class="col-md-8">
                            	            <span class="form-line">
                                                  
                                                        <select runat="server" id="PayType" class="form-control" onchange="onchage(this.value)">
                                                            <option value="4"> --请选择--</option>
                                                            <option value="0">线下支付</option>
                                                            <option value="1">银行卡支付</option>
                                                            <%--<option value="2">支付宝支付</option>
                                                            <option value="3">微信支付</option>--%>
                                                        </select>
                                                      
                            	            </span>
                                        </div>
	                                </div>
                                        <div class="form-group col-md-6 col-sm-12" id="zx" style="display:none">
                                         
            						    <label class="col-md-4 control-label"><asp:Label ID="txtName" runat="server" Text="汇出银行"></asp:Label></label>
                                        <div class="col-md-8">
                                       
                                                        <asp:DropDownList ID="ourbankname" runat="server" CssClass="form-control" >
                                                        </asp:DropDownList>
                                                        <asp:DropDownList ID="OurZFB" runat="server" CssClass="form-control">
                                                        </asp:DropDownList>
                                                        <asp:DropDownList ID="OurWX" runat="server" CssClass="form-control">
                                                        </asp:DropDownList>
                                                   
                                            </div>
                                                       
                                        <%--<div class="col-md-8"><input id="ourbankname" type="text" runat="server" class="form-control"/></div>--%>
	                      	        </div>


	                				  <div class="form-group col-md-6 col-sm-12" id="hcyh" style="display:none">
            						        <label class="col-md-4 control-label"><asp:Label ID="yh" runat="server" Text="汇出银行："></asp:Label></label>
                                            <div class="col-md-8">
                                                <asp:DropDownList ID="OutBank" runat="server" CssClass="form-control"  ></asp:DropDownList>
                                            </div>
	                      	        </div>
                                                        
	                				<div class="form-group col-md-6 col-sm-12" id="hczh" style="display:none">
            						        <label class="col-md-4 control-label"><asp:Label ID="zh" runat="server" Text="汇出账户：" ></asp:Label></label>
                                            <div class="col-md-8"><asp:TextBox ID="ourbankaccount" runat="server" CssClass="form-control" ></asp:TextBox></div>
                                           
	                      	        </div>
	                				<div class="form-group col-md-6 col-sm-12" id="khyhs" style="display:none">
	            						        <label class="col-md-4 control-label"><asp:Label ID="khyh" runat="server" Text="公司开户银行："></asp:Label></label>
                                                <div class="col-md-8">
                            	                    <asp:TextBox ID="bank" runat="server" CssClass="form-control"  ReadOnly="true"></asp:TextBox>
                                                </div>
	                                </div>
	                				<div class="form-group col-md-6 col-sm-12" id="gs" style="display:none">
	            						    <label class="col-md-4 control-label"><asp:Label ID="gszh" runat="server" Text="公司开户账号：" ></asp:Label></label>
                                            <div class="col-md-8">
                            	                <asp:TextBox ID="bankAccount" runat="server" CssClass="form-control"  ReadOnly="true"></asp:TextBox>
                                            </div>
	                                </div>
	                				<div class="form-group col-md-6 col-sm-12" id="khms" style="display:none" >
	            						        <label class="col-md-4 control-label"><asp:Label ID="khm" runat="server" Text="开户名：" ></asp:Label></label>
                                                <div class="col-md-8">
                            	                    <asp:TextBox ID="bankUserName" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                                </div>
	                                </div>
	                				<div class="form-group col-md-6 col-sm-12" id="scpz" style="display:none">
                                        
            							        <label class="col-md-4 control-label"><asp:Label ID="pz" runat="server" Text="上传打款凭证："></asp:Label></label>
                                                <div class="col-md-8">
                                                    <asp:FileUpload ID="FileUpload1" runat="server" class="btn" AutoPostBack="true" Width="200px" style="width: 135px; display: inline-block;" onchange="this.form.LinkButton3.click();"   />&nbsp;&nbsp;
                                                    <asp:Button ID="btnUpload" runat="server" AutoPostBack="true" class="ebtn btn-success" OnClick="btnUpload_Click" Text="上 传" ></asp:Button>
                            	          
                                                </div>
                                            
	                      	        </div>
	                				<div class="form-group col-md-6 col-sm-12" id="bzs" style="display:none">
                                       
	            						        <label class="col-md-4 control-label"><asp:Label ID="bz" runat="server" Text="汇款备注：" ></asp:Label></label>
	                                            <div class="col-md-8">
                                                    <asp:TextBox ID="barmk" runat="server" CssClass="form-control"></asp:TextBox>
	                                            </div>
                                             
		                      	    </div>
	                				<div class="form-group col-md-6 col-sm-12">
	                					<label class="col-md-4 control-label"></label>
	                					<div class="col-md-8">
                                            <asp:Button ID="btn_Open" runat="server" OnClick="btn_Open_Click" class="btn btn-primary" Text="申请复投" />
                                           <%-- <iframe name="ICount" id="Ifrc" height="40px" width="95px"  runat="server"  border="0" frameborder="0" scrolling="auto"></iframe>--%>
                                        </div>
		                      	    </div>
	                			</div>
	                		</div>
                            
                 <div class="col-md-12">
                    <div class="grid-body">
                      <div class="table-over">
	                      <table class="table no-more-tables table-hover">
                            <thead>
                                <tr>
                                      <th style="min-width: 80px;">会员编号</th>
                                            <th style="min-width: 80px;">会员姓名</th>
                                            <th style="min-width: 80px;">汇款金额</th>
                                            <th style="min-width: 80px;">汇款具体时间</th>
                                            <th style="min-width: 80px;">汇出银行</th>
                                            <th style="min-width: 80px;">汇出账户</th>
                                            <th style="min-width: 80px;">汇款备注</th>
                                            <th style="min-width: 80px;">汇入银行</th>
                                            <th style="min-width: 80px;">汇入账户</th>
                                            <th style="min-width: 80px;">汇入开户名</th>
                                            <th style="min-width: 80px;">申请日期</th>
                                            <th style="min-width: 80px;">审核状态</th>
                                </tr>
                            </thead>
                            <tbody>
                                <asp:Repeater ID="Repeater1" runat="server">
                                    <ItemTemplate>
                                        <tr>
                                            <td ><%#Eval("UserCode")%></td>
                                                <td ><%#Eval("Truename")%></td>
                                                <td ><%#Eval("RemitMoney")%></td>
                                                <td ><%#Eval("RechargeableDate")%></td>
                                                <td ><%#BankStr(Eval("Remit003").ToString())%></td>
                                                <td ><%#Eval("Remit004")%></td>
                                                <td ><%#Eval("Remark")%></td>
                                                <td ><%#Eval("BankName")%></td>
                                                <td ><%#Eval("BankAccount")%></td>
                                                <td ><%#Eval("BankAccountUser")%></td>
                                                <td ><%#Eval("AddDate")%></td>
                                                <td ><%#StateType(Eval("State").ToString())%></td>
                                        </tr>
                                    </ItemTemplate>
                                </asp:Repeater>
                                        </tbody>
                            <tr id="tr1" runat="server">
                                <td colspan="10" align="center">
                                    <div class="NoData">
                                        <span class="cBlack">
                                            <%=GetLanguage("Manager")%><!--抱歉！目前数据库暂无数据显示。--></span>
                                    </div>
                                </td>
                            </tr>
                    </table>
                          </div>
            <div class="nextpage cBlack">
                <webdiyer:AspNetPager ID="AspNetPager1" runat="server" SkinID="AspNetPagerSkin" AlwaysShow="True"
                    InputBoxClass="pageinput" NumericButtonCount="3" PageSize="12" ShowInputBox="Never"
                    ShowNavigationToolTip="True" SubmitButtonClass="pagebutton" UrlPaging="false"
                    pageindexboxtype="TextBox" showpageindexbox="Always" SubmitButtonText="" Direction="LeftToRight"
                    HorizontalAlign="Right" OnPageChanged="AspNetPager1_PageChanged">
                </webdiyer:AspNetPager>
            </div>
                                    </div>
                                    
                                    </div>
                                </div>
                            </div>
                        </div>
            </div>
	                	</div>
                                </div>
              	        </div>
                     </div>
                        </div>
        <script type="text/javascript" src="/js/jquery-1.11.3.min.js"></script>
        <script type="text/javascript" src="/JS/Comm.js"></script>
         <script type="text/javascript">
            $(document).ready(function () {
                //alert($("#PayType").val())
                if ($("#PayType").val() == 0) {
                    $("#hcyh").css("display", "block");
                    $("#hczh").css("display", "block");
                    $("#khyhs").css("display", "block");
                    $("#gs").css("display", "block");
                    $("#khms").css("display", "block");
                    $("#scpz").css("display", "block");
                    $("#bzs").css("display", "block");
                    $("#img").css("display", "block");
                    $("#zx").css("display", "block");
                    $("#ourbankname").css("display", "none");
                    $("#OurZFB").css("display", "none");
                    $("#OurWX").css("display", "none");
                    $("#zx").css("display", "none");
                }
                if ($("#PayType").val() == 1) {
                    $("#zx").css("display", "block");
                    $("#ourbankname").css("display", "block");
                    $("#OurZFB").css("display", "none");
                    $("#OurWX").css("display", "none");
                    $("#hcyh").css("display", "none");
                    $("#hczh").css("display", "none");
                    $("#khyhs").css("display", "none");
                    $("#gs").css("display", "none");
                    $("#khms").css("display", "none");
                    $("#scpz").css("display", "none");
                    $("#bzs").css("display", "none");
                    $("#img").css("display", "none");
                }
            })
            function onchage(value) {
               // alert(value);
                if (value == 1)
                {
                    $("#zx").css("display", "block");
                    $("#ourbankname").css("display", "block");
                    $("#OurZFB").css("display", "none");
                    $("#OurWX").css("display", "none");
                    $("#hcyh").css("display", "none");
                    $("#hczh").css("display", "none");
                    $("#khyhs").css("display", "none");
                    $("#gs").css("display", "none");
                    $("#khms").css("display", "none");
                    $("#scpz").css("display", "none");
                    $("#bzs").css("display", "none");
                    $("#img").css("display", "none");
                }
                if (value == 0) {
                    $("#hcyh").css("display", "block");
                    $("#hczh").css("display", "block");
                    $("#khyhs").css("display", "block");
                    $("#gs").css("display", "block");
                    $("#khms").css("display", "block");
                    $("#scpz").css("display", "block");
                    $("#bzs").css("display", "block");
                    $("#img").css("display", "block");
                    $("#zx").css("display", "block");
                    $("#ourbankname").css("display", "none");
                    $("#OurZFB").css("display", "none");
                    $("#OurWX").css("display", "none"); 
                    $("#zx").css("display", "none");
                }
                if (value == 2) {
                    $("#zx").css("display", "block");
                    $("#ourbankname").css("display", "none");
                    $("#OurZFB").css("display", "block");
                    $("#OurWX").css("display", "none");
                    $("#hcyh").css("display", "none");
                    $("#hczh").css("display", "none");
                    $("#khyhs").css("display", "none");
                    $("#gs").css("display", "none");
                    $("#khms").css("display", "none");
                    $("#scpz").css("display", "none");
                    $("#bzs").css("display", "none");
                    $("#img").css("display", "none");
                }
                if (value == 3) {
                    $("#zx").css("display", "block");
                    $("#ourbankname").css("display", "none");
                    $("#OurZFB").css("display", "none");
                    $("#OurWX").css("display", "block");
                    $("#hcyh").css("display", "none");
                    $("#hczh").css("display", "none");
                    $("#khyhs").css("display", "none");
                    $("#gs").css("display", "none");
                    $("#khms").css("display", "none");
                    $("#scpz").css("display", "none");
                    $("#bzs").css("display", "none");
                    $("#img").css("display", "none");
                }
            }
        </script>
    </form>
</body>
</html>
