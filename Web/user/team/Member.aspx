<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="/user/index.Master" CodeBehind="Member.aspx.cs" Inherits="Web.user.team.Member" %>

<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<asp:Content runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <script type="text/javascript" src="/Js/My97DatePicker/WdatePicker.js"></script>
   
        <!-- Start content -->
        <div class="content">
            <div class="container">

                <div class="row">
                    <div class="col-sm-12">
                        <div class="card-box">
                            <h4 class="header-title m-t-0 m-b-30"><%=GetLanguage("OpenMembership")%><%--待激活会员--%></h4>
                            <div class="row">
                                <div class="form-inline col-sm-12">
                                    <div class="form-group">
                                        <label><%=GetLanguage("MembershipNumber")%><%--会员编号--%></label>
                                        <input name="txtUserCode" id="txtUserCode" runat="server" class="form-control" type="text" />
                                    </div>
                                    <div class="form-group">
                                        <label><%=GetLanguage("RegistrationHours")%><%--注册时间--%></label>
                                        <div class="input-daterange input-group" id="date-range">
                                            <%if (GetLanguage("LoginLable") == "zh-cn")
                                                {%>
                                            <asp:TextBox ID="txtStart" tip="注册时间" runat="server" onfocus="WdatePicker()" class="form-control" name="start"></asp:TextBox>
                                            <%}
                                                else
                                                {%>
                                            <asp:TextBox ID="txtStartEn" tip="Opening date" runat="server" onfocus="WdatePicker({lang:'en'})" class="form-control" name="start"></asp:TextBox>
                                            <%} %>
                                            <span class="input-group-addon bg-inverse b-0 text-white"><%=GetLanguage("To")%><%--至--%></span>
                                            <%if (GetLanguage("LoginLable") == "zh-cn")
                                                {%>
                                            <asp:TextBox ID="txtEnd" tip="注册时间" runat="server" onfocus="WdatePicker()" class="form-control" name="end"></asp:TextBox>
                                            <%}
                                                else
                                                {%>
                                            <asp:TextBox ID="txtEndEn" tip="Opening date" runat="server" onfocus="WdatePicker({lang:'en'})" class="form-control" name="end"></asp:TextBox>
                                            <%} %>
                                        </div>
                                    </div>
                                    <asp:Button ID="btnSearch" runat="server"  OnClick="btnSearch_Click" Text="提 交" class="btn btn-success  btn-md"/>

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
                                                    <th><%=GetLanguage("LoginInformation")%><%--登录资料--%></th>
                                                    <th><%=GetLanguage("MemberName")%><%--会员姓名--%></th>
                                                    <th><%=GetLanguage("DeclarationNumber")%><%--服务中心编号--%></th>
                                                    <th><%=GetLanguage("ReferenceNumber")%><%--推荐人编号--%></th>
                                                    <th><%=GetLanguage("RegistrationHours")%><%--注册时间--%></th>
                                                    <th>激活金额</th>
                                                    <th>激活单量</th>
                                                    <th>激活总额</th>
                                                    <th>支付密码</th>
                                                    <th><%=GetLanguage("Operation")%><%--操作--%></th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <asp:Repeater ID="Repeater1" runat="server" OnItemCommand="Repeater1_ItemCommand">
                                                    <ItemTemplate>
                                                        <tr>
                                                            <td>
                                                                <a href="../member/PersonalInfo.aspx?UserID=<%# Eval("UserID")%>">
                                                                    <%# Eval("UserCode")%></a>
                                                            </td>
                                                            <td><%#Eval("NiceName")%></td>
                                                            <td><%#Eval("AgentCode")%></td>
                                                            <td><%#Eval("RecommendCode")%></td>
                                                            <td><%#Eval("RegTime")%></td>
                                                            <td>
                                                                <%#Eval("RegMoney")%>
                                                                <input id='regmoney_<%#Eval("UserID")%>' type="hidden" value='<%#Eval("RegMoney")%>'>
                                                            </td>
                                                            <td>
                                                                <input type="text" id="txtActiveNum" runat="server" class='form-control acnum_<%#Eval("UserID")%>' oninput='<%#Eval("UserID", "jisuan(\"{0}\",this.value)")%>' />
                                                            </td>
                                                            <td>
                                                                <span id='totalmoney_<%#Eval("UserID")%>' class="totalmoney"></span>
                                                            </td>
                                                            <td>
                                                                <input type="password" runat="server" class="form-control" id="txtPayPwd" />
                                                            </td>
                                                            <td>
                                                                <asp:DropDownList ID="DropDownList1" runat="server" CssClass="form-control">
                                                                    <asp:ListItem  Value="0" >请选择</asp:ListItem>
                                                                    <asp:ListItem  Value="1" >50%注册分+50%激活分激活</asp:ListItem>
                                                                    <asp:ListItem  Value="2" >100%注册分</asp:ListItem>
                                                                </asp:DropDownList>
                                                                <asp:LinkButton ID="lbtnOpend" runat="server" CommandArgument='<%# Eval("UserID") %>'
                                                                    class="btn btn-info" iconcls="icon-ok" Visible='true' CommandName="open"
                                                                    ><i class="fa fa-key"></i>激活</asp:LinkButton>
                                                            </td>
                                                        </tr>
                                                    </ItemTemplate>
                                                </asp:Repeater>
                                                <tr id="tr1" runat="server">
                                                    <td colspan="7" class="colspan">
                                                        <div class="form-control-static text-center">
                                                            <i class="fa fa-warning text-warning"></i>
                                                            <%=GetLanguage("Manager")%>
                                                        </div>
                                                    </td>
                                                </tr>

                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-12">
                                    <webdiyer:AspNetPager ID="AspNetPager1" runat="server" CssClass="pagination" LayoutType="Ul" PagingButtonLayoutType="UnorderedList"
                                        NumericButtonCount="3" PageSize="12"
                                        ShowNavigationToolTip="True" SubmitButtonClass="pagebutton" UrlPaging="false" PagingButtonSpacing="0" CurrentPageButtonClass="active"
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

    <script type="text/javascript">
        function jisuan(a,num) {
            var reg = $("#regmoney_" + a).val();
            if (!(/(^[1-9]\d*$)/.test(num)))
            {
                $(".acnum" + a).val("");
                alert('输入的不是正整数');
                return false;
            }
            var total = reg * num;
            $("#totalmoney_" + a).text(total);
        }
    </script>
</asp:Content>
