<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Member.aspx.cs" Inherits="Web.admin.business.Member" %>

<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>�������Ա</title>
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
    <form id="Form1" class="box_con" runat="server">
        <div class="mainwrapper" style="top: 0px; background-color: #E8E8FF">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h4 class="panel-title">�������Ա��ѯ</h4>
                </div>
                <div class="panel-body">
                    <form class="form-inline" action="#">
                        <div class="mb15">
                            <div class="form-group mt10">
                                <label class="control-label">ѡ������:</label>
                                <div class="form-control nopadding noborder">
                                    <asp:DropDownList ID="dropType" runat="server" class="width100p selectval mwidth168">
                                        <asp:ListItem Value="0">��ѡ��</asp:ListItem>
                                        <asp:ListItem Value="1">��Ա���</asp:ListItem>
                                        <asp:ListItem Value="2">��Ա����</asp:ListItem>
                                        <asp:ListItem Value="3">�Ƽ��˱��</asp:ListItem>
                                        <asp:ListItem Value="4">�����˱��</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <input name="txtInput" id="txtInput" class="form-control" runat="server" type="text" />
                            </div>
                            <div class="form-group mt10">
                                <label class="control-label">��ͨ����:</label>
                                <asp:TextBox ID="txtStar" tip="����ע������" runat="server" onfocus="WdatePicker()" CssClass="form-control datepicker"></asp:TextBox>
                                <label class="control-label">��</label>
                                <asp:TextBox ID="txtEnd" tip="����ע������" runat="server" onfocus="WdatePicker()" class="form-control datepicker"></asp:TextBox>
                            </div>
                        </div>
                        <div class="mb15">
                            <div class="form-group">
                                <asp:LinkButton ID="btnSearch" runat="server" class="btn btn-primary mr5" iconcls="icon-search"
                                    OnClick="btnSearch_Click"><i class="fa fa-search"></i> �� �� </asp:LinkButton>
                                <asp:LinkButton ID="lbtnExport" runat="server" class="btn btn-primary mr5" iconcls="icon-print"
                                    OnClick="lbtnExport_Click"><i class="fa fa-download"></i> ����Excel </asp:LinkButton>
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
                                <th style="min-width: 100px;">�Ƽ��˱��</th>
                                <th style="min-width: 80px;">��Ա���</th>
                                <th style="min-width: 80px;">��Ա����</th>
                                <th style="min-width: 80px;">��Ա����</th>
                                <th style="min-width: 80px;">�������ı��</th>
                                <th style="min-width: 80px;">ע������</th>
                                <th style="min-width: 80px;">����</th>
                            </tr>
                        </thead>
                        <asp:Repeater ID="Repeater1" runat="server" OnItemCommand="Repeater1_ItemCommand">
                            <ItemTemplate>
                                <tr>
                                    <td align="center">
                                        <%#Eval("RecommendCode")%>
                                    </td>
                                    <td align="center">
                                        <a href="UserDetail.aspx?UserID=<%# Eval("UserID")%>">
                                            <%# Eval("UserCode")%></a>
                                    </td>
                                    <td align="center">
                                        <%#Eval("TrueName")%>
                                    </td>
                                    <td align="center">
                                        <%#levelBLL.GetLevelName(Convert.ToInt32(Eval("LevelID")), currentCulture)%>
                                    </td>
                                    <td align="center">
                                        <%#Eval("user006")%>
                                    </td>
                                    <td align="center">
                                        <%#Eval("RegTime")%>
                                    </td>
                                    <td align="center">
                                        <asp:LinkButton ID="lbtnOpend" runat="server" CommandArgument='<%# Eval("UserID") %>'
                                            class="btn btn-info" iconcls="icon-ok" Visible='true' CommandName="open"
                                            OnClientClick="javascript:return confirm('ȷ��Ҫ�����Ա��')"><i class="fa fa-key"></i>��ͨ</asp:LinkButton>
                                        <%--<asp:LinkButton ID="lbtnEmpty" runat="server" CommandArgument='<%# Eval("UserID") %>'
                                            class="btn btn-info" iconcls="icon-ok" Visible="true" CommandName="Empty"
                                            OnClientClick="javascript:return confirm('ȷ��Ҫ�����Ա��')">��ͨ�յ�</asp:LinkButton>--%>
                                        <asp:LinkButton ID="lbtnRemove" runat="server" CommandArgument='<%# Eval("UserID") %>' class="btn btn-danger"
                                            iconcls="icon-no" Visible='<%#Eval("IsOpend").ToString()=="0"?true:false %>'
                                            CommandName="Remove" OnClientClick="javascript:return confirm('ȷ��Ҫɾ���˻�Ա��')"><i class="fa fa-minus"></i>ɾ��</asp:LinkButton>
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                        <tr id="divno" runat="server" class="none">
                            <td colspan="7" align="center">��Ǹ��Ŀǰ���ݿ�����������ʾ��</td>
                        </tr>
                    </table>
                    <div class="nextpage cBlack">
                        <webdiyer:AspNetPager ID="AspNetPager1" runat="server" SkinID="AspNetPagerSkin" FirstPageText="��ҳ"
                            LastPageText="βҳ" NextPageText="��һҳ" PrevPageText="��һҳ" AlwaysShow="True" InputBoxClass="pageinput"
                            NumericButtonCount="3" PageSize="12" ShowInputBox="Never" ShowNavigationToolTip="True"
                            SubmitButtonClass="pagebutton" UrlPaging="false" pageindexboxtype="TextBox" showpageindexbox="Always"
                            SubmitButtonText="" textafterpageindexbox=" ҳ" textbeforepageindexbox="ת�� " Direction="LeftToRight"
                            HorizontalAlign="Right" OnPageChanged="AspNetPager1_PageChanged">
                        </webdiyer:AspNetPager>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
