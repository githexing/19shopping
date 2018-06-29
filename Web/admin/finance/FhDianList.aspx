<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FhDianList.aspx.cs" Inherits="Web.admin.finance.FhDianList" %>

<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>龙珠列表</title>
    <link rel="stylesheet" type="text/css" href="../css/style.css" />
    <link rel="stylesheet" type="text/css" href="../style/select2.css" />
    <link rel="stylesheet" type="text/css" href="../style/jquery-ui-1.10.3.css" />
    <script type="text/javascript" src="../../JS/jquery-1.7.1.min.js"></script>
    <script type="text/javascript" src="../../JS/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="../Scripts/Common.js"></script>
    <script type="text/javascript" language="javascript" src="/Js/My97DatePicker/WdatePicker.js"></script>
    <script src="../Scripts/main-layout.js" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="mainwrapper" style="top: 0px; background-color: #E8E8FF">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h4 class="panel-title">查询</h4>
                </div>
                <div class="panel-body">
                    <form class="form-inline" action="#">
                        <div class="mb15">
                            <div class="form-group mt10">
                                <label class="control-label">会员编号:</label>
                                <input name="txtUserCode" id="txtUserCode" class="form-control" runat="server" type="text" />
                            </div>
                        </div>
                        <div class="mb15">
                            <div class="form-group">
                                <asp:LinkButton ID="btnSearch" runat="server" class="btn btn-primary mr5" iconcls="icon-search"
                                    OnClick="btnSearch_Click"><i class="fa fa-search"></i> 搜 索 </asp:LinkButton>
                            </div>
                        </div>
                    </form>
                </div>
                <!-- panel-body -->
            </div>
            <div class="panel panel-default">
                <div class="panel-body">
                    <table class="table table-bordered table-primary mb30">
                        <thead>
                            <tr>
                                <th style="min-width: 80px;">会员编号</th>
                                <th style="min-width: 80px;">会员昵称</th>
                                <th style="min-width: 80px;">龙珠总量</th>
                                <th style="min-width: 80px;">已出局</th>
                                <th style="min-width: 80px;">在分红</th>
                            </tr>
                        </thead>
                        <asp:Repeater ID="Repeater1" runat="server">
                            <ItemTemplate>
                                <tr>
                                    <td align="center">
                                        <a href="UserDetail.aspx?UserID=<%# Eval("UserID")%>">
                                            <%# Eval("UserCode")%></a>
                                    </td>
                                    <td align="center">
                                        <%#Eval("NiceName")%>
                                    </td>
                                    <td align="center">
                                        <%#Eval("TotalLz")%>
                                    </td>
                                    <td align="center">
                                        <%#Eval("OutLz")%>
                                    </td>
                                    <td align="center">
                                        <%#Eval("InLz")%>
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                        <tr id="divno" runat="server" class="none">
                            <td colspan="7" align="center">抱歉！目前数据库暂无数据显示。</td>
                        </tr>
                    </table>
                    <div class="nextpage cBlack">
                        <webdiyer:AspNetPager ID="AspNetPager1" runat="server" SkinID="AspNetPagerSkin" FirstPageText="首页"
                            LastPageText="尾页" NextPageText="下一页" PrevPageText="上一页" AlwaysShow="True" InputBoxClass="pageinput"
                            NumericButtonCount="3" PageSize="12" ShowInputBox="Never" ShowNavigationToolTip="True"
                            SubmitButtonClass="pagebutton" UrlPaging="false" pageindexboxtype="TextBox" showpageindexbox="Always"
                            SubmitButtonText="" textafterpageindexbox=" 页" textbeforepageindexbox="转到 " Direction="LeftToRight"
                            HorizontalAlign="Right" OnPageChanged="AspNetPager1_PageChanged">
                        </webdiyer:AspNetPager>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
