<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BonusByUser.aspx.cs" Inherits="Web.admin.finance.BonusByUser" %>

<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
    <meta http-equiv="x-ua-compatible" content="ie=7" />
    <title>������ϸ</title>
    <link rel="stylesheet" type="text/css" href="../css/style.css" />
    <link rel="stylesheet" type="text/css" href="../style/jquery-ui-1.10.3.css" />
    <script type="text/javascript" src="../../JS/jquery-1.7.1.min.js"></script>
    <script type="text/javascript" src="../../JS/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="../Scripts/Common.js"></script>
    <script type="text/javascript" language="javascript" src="/Js/My97DatePicker/WdatePicker.js"></script>
    <script src="../Scripts/main-layout.js" type="text/javascript"></script>
</head>
<body class="subBody">
    <form runat="server">
        <div class="mainwrapper" style="top: 0px; background-color: #E8E8FF">
            <div class="panel panel-default">
                <div class="panel-body">
                    <table class="table table-bordered table-primary mb30">
                        <thead>
                            <tr>
                                <th style="min-width: 80px;">ֱ�����̽����ۼ�</th>
                                <th style="min-width: 80px;">��������ۼ�</th>
                                <th style="min-width: 80px;">��������ۼ�</th>
                                <th style="min-width: 80px;">���˽����ۼ�</th>
                                <th style="min-width: 80px;">ѧϰ�����ۼ�</th>
                                <th style="min-width: 80px;">��г�����ۼ�</th>
                                <th style="min-width: 80px;">Ӧ���ۼ�</th>
                                <th style="min-width: 80px;">�ۺϷ�����ۼ�</th>
                                <th style="min-width: 80px;">�������ۼ�</th>
                                <th style="min-width: 80px;">���������ۼ�</th>
                                <th style="min-width: 80px;">�г�Ȩ���ۼ�</th>
                                <th style="min-width: 80px;">ʵ���ۼ�</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td data-attr="ֱ�����̽����ۼ�"><%=GetBonus(0,2) %></td>
                                <td data-attr="��������ۼ�"><%=GetBonus(0,1) %></td>
                                <td data-attr="��������ۼ�"><%=GetBonus(0,4) %></td>
                                <td data-attr="���˽����ۼ�"><%=GetBonus(0,3) %></td>
                                <td data-attr="ѧϰ�����ۼ�"><%=GetBonus(0,5) %></td>
                                <td data-attr="��г�����ۼ�"><%=GetBonus(0,6) %></td>
                                <td data-attr="Ӧ���ۼ�"><%=getBonusYF(0,1) %></td>
                                <td data-attr="�ۺϷ�����ۼ�"><%=getBonusFWF(0) %></td>
                                <td data-attr="�������ۼ�"><%=getBonusFBF(0) %></td>
                                <td data-attr="���������ۼ�"><%=getBonusCFXF(0) %></td>
                                <td data-attr="�г�Ȩ���ۼ�"><%=GetBonus(0,7) %></td>
                                <td data-attr="ʵ���ۼ�"><%=getBonusSF(0) %></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="panel panel-default">
                <div class="panel-heading">
                    <h4 class="panel-title">������ϸ��ѯ</h4>
                </div>
                <div class="panel-body">
                    <form class="form-inline" action="#">
                        <div class="form-group mt10">
                            <label class="control-label">��������:</label>
                            <asp:TextBox ID="txtStar" tip="�����������" runat="server" onfocus="WdatePicker()" class="form-control datepicker"></asp:TextBox>
                            <label class="control-label">��</label>
                            <asp:TextBox ID="txtEnd" tip="�����������" runat="server" onfocus="WdatePicker()" class="form-control datepicker"></asp:TextBox>
                        </div>
                        <div class="form-group mt10">
                            <asp:LinkButton ID="LinkButton2" runat="server" class="btn btn-primary mr5" iconcls="icon-search"
                                OnClick="btnSearch_Click"><i class="fa fa-search"></i> �� �� </asp:LinkButton>
                        </div>
                    </form>
                </div>
            </div>
            <div class="panel panel-default">
                <div class="panel-body">
                    <table class="table table-bordered table-primary mb30">
                        <thead>
                            <tr>
                                <th style="min-width: 80px;">�û�</th>
                                <th style="min-width: 80px;">ֱ�����̽���</th>
                                <th style="min-width: 80px;">�������</th>
                                <th style="min-width: 80px;">�������</th>
                                <th style="min-width: 80px;">���˽���</th>
                                <th style="min-width: 80px;">ѧϰ����</th>
                                <th style="min-width: 80px;">��г����</th>
                                <th style="min-width: 80px;">Ӧ��</th>
                                <th style="min-width: 80px;">�ۺϷ����</th>
                                <th style="min-width: 80px;">������</th>
                                <th style="min-width: 80px;">��������</th>
                                <th style="min-width: 80px;">�г�Ȩ��</th>
                                <th style="min-width: 80px;">ʵ��</th>
                                <th style="min-width: 80px;">��������</th>
                                <th style="min-width: 80px;">����</th>
                            </tr>
                        </thead>
                        <asp:Repeater ID="Repeater1" runat="server" runat="server">
                            <ItemTemplate>
                                <tr>
                                    <td align="center">
                                        <%#Eval("yhm")%>
                                        <%--�û�--%>
                                    </td>
                                    <td align="center">
                                        <%#Eval("tj")%>
                                        <%--ֱ�����̽��� Amount 2--%>
                                    </td>
                                    <td align="center">
                                        <%#Eval("dp")%><%--������� Amount 1--%>
                                    </td>
                                    <td align="center">
                                        <%#Eval("gl")%><%--�������  Amount 4--%>
                                    </td>
                                    <td align="center">
                                        <%#Eval("jd")%><%--���˽��� Amount 3--%>
                                    </td>
                                    <td align="center">
                                        <%#Eval("xx")%>
                                    </td>
                                    <td align="center">
                                        <%#Eval("hx")%>
                                    </td>
                                    <td align="center">
                                        <%#Eval("yf")%><%--Ӧ�� Amount--%>
                                    </td>
                                    <td align="center">
                                        <%#Eval("fwf")%><%--�ۺϷ���� Revenue--%>
                                    </td>
                                    <td align="center">
                                        <%#Eval("fbf")%>
                                    </td>
                                    <td align="center">
                                        <%#Eval("cfxf")%><%--�������� Bonus006--%>
                                    </td>
                                    <td align="center">
                                        <%#Eval("bd")%><%--�г�Ȩ�� bd --%>
                                    </td>
                                    <td align="center">
                                        <%#Eval("sf")%><%--ʵ��sf --%>
                                    </td>
                                    <td align="center">
                                        <%#Eval("SttleTime")%><%--��������--%>
                                    </td>
                                    <td align="center">
                                        <asp:LinkButton ID="LinkButton1" runat="server" class="btn btn-info" iconcls="icon-search"
                                            PostBackUrl='<%#Eval("SttleTime","BonusDetail.aspx?SttleTime={0}") %>'><i class="fa fa-share-square-o"></i>�鿴��ϸ</asp:LinkButton>
                                        <a class="btn btn-danger" href='BonusByUserDel.aspx?uid=<%#Eval("uid") %>&SttleTime= <%#Eval("SttleTime")%>'><i class="fa fa-minus"></i>ɾ��</a>
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                        <tr id="trBonusNull" runat="server" class="none">
                            <td colspan="12" align="center">��Ǹ��Ŀǰ���ݿ�����������ʾ��</td>
                        </tr>
                    </table>
                    <div class="nextpage cBlack">
                        <webdiyer:AspNetPager ID="AspNetPager1" runat="server" SkinID="AspNetPagerSkin" FirstPageText="��ҳ"
                            LastPageText="βҳ" NextPageText="��һҳ" PrevPageText="��һҳ" AlwaysShow="True" InputBoxClass="pageinput"
                            NumericButtonCount="3" PageSize="12" ShowInputBox="Never" ShowNavigationToolTip="True"
                            SubmitButtonClass="pagebutton" UrlPaging="false" pageindexboxtype="TextBox" showpageindexbox="Always"
                            SubmitButtonText="" textafterpageindexbox=" ҳ" textbeforepageindexbox="ת�� " OnPageChanged="AspNetPager1_PageChanged">
                        </webdiyer:AspNetPager>
                    </div>
                </div> 
            </div>
        </div>
    </form>
</body>
</html>
