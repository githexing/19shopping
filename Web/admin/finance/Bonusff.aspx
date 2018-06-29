<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Bonusff.aspx.cs" Inherits="Web.admin.finance.Bonusff" %>

<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<!DOCTYPE html >
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="x-ua-compatible" content="ie=7" />
    <title>奖金发放</title>
    <link rel="stylesheet" type="text/css" href="../css/style.css" />
    <link rel="stylesheet" type="text/css" href="../style/jquery-ui-1.10.3.css" />

    <script type="text/javascript" src="../../JS/jquery-1.7.1.min.js"></script>
    <script type="text/javascript" src="../../JS/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="../Scripts/Common.js"></script>
    <script type="text/javascript" language="javascript" src="/Js/My97DatePicker/WdatePicker.js"></script>
    <script src="../Scripts/main-layout.js" type="text/javascript"></script>
</head>
<body>
    <form id="Form1" class="box_con" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>

        <div class="panel panel-default">
            <div class="panel-heading">
                <h4 class="panel-title">共享奖励</h4>
            </div>
            <div class="panel-body">
                <table class="table table-bordered table-primary mb30">
                    <thead>
                        <tr>
                            <th style="min-width: 80px;">今日业绩</th>
                            <th style="min-width: 80px;">当前可分红点</th>
                            <th style="min-width: 80px;">每个分红点金额</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td data-attr="今日业绩">
                                <asp:Literal runat="server" ID="ltAddYeji"></asp:Literal>
                            </td>
                            <td data-attr="当前可分红点">
                                <asp:Literal runat="server" ID="LtTotalFhd"></asp:Literal>
                            </td>
                            <td data-attr="每个分红点金额">
                                <asp:Literal runat="server" ID="ltEveryFhdMoney"></asp:Literal>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <asp:UpdatePanel runat="server" ID="UpdatePanel1">
                    <ContentTemplate>

                        <table class="table table-bordered table-primary mb30">
                            <thead>
                                <tr>
                                    <th style="min-width: 80px;">分红金额</th>
                                    <th style="min-width: 80px;">每个分红点实际金额</th>
                                    <th style="min-width: 80px;">操作</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td data-attr="分红金额">
                                        <asp:TextBox ID="txtFhMoney" CssClass="form-control" onkeyup="value=value.replace(/[^\d.]/g,'')" runat="server" AutoPostBack="true" OnTextChanged="txtFhMoney_TextChanged"></asp:TextBox>
                                    </td>
                                    <td data-attr="每个分红点实际金额">
                                        <asp:Literal runat="server" ID="ltRealFhdMoney"></asp:Literal>
                                    </td>
                                    <td data-attr="操作">
                                        <asp:LinkButton ID="LinkButton1" runat="server" class="btn btn-block btn-lg btn-rounded btn-primary" iconcls="icon-save"
                                            OnClick="LinkButton1_Click" OnClientClick="javascript:return confirm('确定发放共享奖励吗？')">提交</asp:LinkButton>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
            <div class="panel-heading">
                <h4 class="panel-title">荣誉股东奖</h4>
            </div>
            <div class="panel-body">
                <table class="table table-bordered table-primary mb30">
                    <thead>
                        <tr>
                            <th style="min-width: 80px;">会员编号</th>
                            <th style="min-width: 80px;">荣誉奖金额</th>
                            <th style="min-width: 80px;">操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td data-attr="会员编号">
                                <asp:TextBox ID="txtUserCode" CssClass="form-control" runat="server"></asp:TextBox>
                            </td>
                            <td data-attr="荣誉奖金额">
                                <asp:TextBox ID="txtMoney" CssClass="form-control" runat="server" onkeyup="value=value.replace(/[^\d.]/g,'')"></asp:TextBox>
                            </td>
                            <td data-attr="操作">
                                <asp:LinkButton ID="LinkButton2" runat="server" class="btn btn-block btn-lg btn-rounded btn-primary" iconcls="icon-save"
                                    OnClick="LinkButton2_Click" OnClientClick="javascript:return confirm('确定发放荣誉奖吗？')">提交</asp:LinkButton>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <div class="mainwrapper" style="top: 0px; background-color: #E8E8FF">
            <div class="row">
                <div class="col-md-4">

                </div>
            </div>
            <br />
            <br />
            <div class="panel panel-default" style="display: none;">
                <div class="panel-body">
                    <table class="table table-bordered table-primary mb30">
                        <thead>
                            <tr>
                                <th style="min-width: 80px; text-align: center;">操作名称</th>
                                <th style="min-width: 80px; text-align: center;">时间</th>
                                <th style="min-width: 80px; text-align: center;">操作</th>
                            </tr>
                        </thead>
                        <tbody>
                            <asp:Repeater ID="Repeater1" runat="server">
                                <ItemTemplate>
                                    <tr>

                                        <td data-attr="操作名称">
                                            <%#Eval("LogCode")%><!--1.操作名称-->
                                        </td>
                                        <td data-attr="操作时间">
                                            <%#Eval("LogDate")%><!--2.操作时间-->
                                        </td>
                                        <td data-attr="完成时间">
                                            <%#Eval("Log4")%><!--完成时间-->
                                        </td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                            <tr id="tr1" runat="server">
                                <td colspan="8" align="center" class="none">抱歉！目前暂无数据显示。</td>
                            </tr>
                        </tbody>
                    </table>
                    <div class="nextpage cBlack">
                        <webdiyer:AspNetPager ID="AspNetPager1" runat="server" CssClass="pagination" LayoutType="Ul" PagingButtonLayoutType="UnorderedList" PagingButtonSpacing="0" CurrentPageButtonClass="active"
                            FirstPageText="首页"
                            LastPageText="尾页" NextPageText="下一页" PrevPageText="上一页" AlwaysShow="True" InputBoxClass="pageinput"
                            NumericButtonCount="3" PageSize="12" ShowInputBox="Never" ShowNavigationToolTip="True"
                            SubmitButtonClass="pagebutton" UrlPaging="false" PageIndexBoxType="TextBox" ShowPageIndexBox="Always"
                            SubmitButtonText="转到" TextAfterPageIndexBox=" ҳ" TextBeforePageIndexBox="转到 " Direction="LeftToRight"
                            HorizontalAlign="Center" OnPageChanged="AspNetPager1_PageChanged">
                        </webdiyer:AspNetPager>
                    </div>
                </div>
                <!-- row -->
            </div>
        </div>

    </form>
</body>
</html>
