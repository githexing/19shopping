<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="OrderList.aspx.cs" Inherits="Web.admin.product.OrderList" %>

<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link rel="stylesheet" type="text/css" href="../Content/base.css" />
    <link rel="stylesheet" type="text/css" href="../Content/themes/default/easyui.css" />
    <link rel="stylesheet" type="text/css" href="../Content/themes/icon.css" />

    <script type="text/javascript" src="../../JS/jquery-1.7.1.min.js"></script>

    <script type="text/javascript" src="../../JS/jquery.easyui.min.js"></script>

    <script type="text/javascript" src="../Scripts/Common.js"></script>

    <script type="text/javascript" language="javascript" src="../../Js/My97DatePicker/WdatePicker.js"></script>

    <script src="../Scripts/main-layout.js" type="text/javascript"></script>
</head>

<body class="subBody">
    <form id="form1" runat="server" class="box_con">
        <div class="Member_right">
            <div class="operation">
                <fieldset class="fieldset">
                    <legend class="legSearch">搜索</legend>
                    <table width="99%" border="0" cellspacing="0" cellpadding="0" class="">
                        <tr>
                            <td>
                                会员编号：
                                <input name="txtInput" id="txtInput" class="input_select" runat="server" type="text" />
                                购买模式：
                                <asp:DropDownList runat="server" ID="dropBuyType">
                                    <asp:ListItem Value="0">请选择</asp:ListItem>
                                    <asp:ListItem Value="1">报单</asp:ListItem>
                                    <asp:ListItem Value="2">复投</asp:ListItem>
                                </asp:DropDownList>
                                结算日期：<asp:TextBox ID="txtStar" tip="输入结算日期"
                                    runat="server" onfocus="WdatePicker()" class="input_select"></asp:TextBox>
                                至<asp:TextBox ID="txtEnd" tip="输入结算日期" runat="server" onfocus="WdatePicker()" class="input_select"></asp:TextBox>
                                <asp:LinkButton ID="LinkButton4" runat="server" class="easyui-linkbutton" iconcls="icon-search"
                                    OnClick="btnSearch_Click"> 搜 索 </asp:LinkButton>
                                <asp:LinkButton ID="LinkButton3" runat="server" class="easyui-linkbutton"
                                    iconcls="icon-print" OnClick="daochu_Click"> 导 出 </asp:LinkButton>
                            </td>

                        </tr>
                    </table>
                </fieldset>
            </div>
            <!--end operation 操作-->
            <div class="dataTable">
                <table width="99%" border="0" cellspacing="0" cellpadding="0" class="t1">
                    <tr>
                        <th align="center">时间
                        </th>
                        <th align="center">订单号
                        </th>
                        <th align="center">会员编号
                        </th>
                        <th align="center">购买数量
                        </th>
                        <th align="center">总金额/总积分
                        </th>
                        <th align="center">收货人姓名
                        </th>
                        <th align="center">收货地址
                        </th>
                        <th align="center">联系电话
                        </th>
                        <th align="center">支付类型
                        </th>
                    </tr>
                    <asp:Repeater ID="rptOrder" runat="server">
                        <ItemTemplate>
                            <tr>
                                <td align="center">
                                    <%#Convert.ToDateTime(Eval("OrderDate")).ToString("yyyy-MM-dd HH:mm:ss")%>
                                </td>
                                <td align="center">
                                    <%#Eval("OrderCode")%>
                                </td>

                                <td align="center">
                                    <%#Eval("UserCode")%>
                                </td>
                                <td align="center">
                                    <%#Eval("OrderSum")%>
                                </td>

                                <td align="center">
                                    <%#Eval("OrderTotal")%>
                                </td>

                                <td align="center">
                                    <%#Eval("order7")%>
                                </td>

                                <td align="center">
                                    <%#Eval("UserAddr")%>
                                </td>

                                <td align="center">
                                    <%#Eval("order6")%>
                                </td>
                                <td align="center">
                                    <%#Eval("OrderType").ToString()=="1"?"激活分+注册分":""%>
                                    <%#Eval("OrderType").ToString()=="2"?"注册分":""%>
                                    <%#Eval("OrderType").ToString()=="3"?"复利分":""%>
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                    <tr runat="server" id="trNull">
                        <td colspan="12" align="center">
                            <div id="divno" runat="server" class="NoData">
                                <span class="cBlack">抱歉！目前数据库暂无数据显示。</span>
                            </div>
                        </td>
                    </tr>
                </table>
                <div class="yellow">
                    <webdiyer:aspnetpager id="AspNetPager1" runat="server" skinid="AspNetPagerSkin" firstpagetext="首页"
                        lastpagetext="尾页" nextpagetext="下一页" onpagechanged="AspNetPager1_PageChanged"
                        prevpagetext="上一页" alwaysshow="True" inputboxclass="pageinput" numericbuttoncount="3"
                        pagesize="12" showinputbox="Never" shownavigationtooltip="True" submitbuttonclass="pagebutton"
                        urlpaging="false" pageindexboxtype="TextBox" showpageindexbox="Always" submitbuttontext=""
                        textafterpageindexbox=" 页" textbeforepageindexbox="转到 ">
                    </webdiyer:aspnetpager>
                </div>
            </div>
            <!--end data 表格数据-->
        </div>
    </form>
</body>
</html>
