<%@ Page Title="" Language="C#" MasterPageFile="~/user/index.Master" AutoEventWireup="true" CodeBehind="ActiveUser.aspx.cs" Inherits="Web.user.member.ActiveUser" %>

<asp:content id="Content1" contentplaceholderid="head" runat="server">

</asp:content>
<asp:content runat="server" contentplaceholderid="ContentPlaceHolder1">
    <div class="content">
        <div class="container">
            <div class="row">
                <div class="col-sm-12">
                    <div class="card-box" id="div1" runat="server">
                        <h4 class="header-title m-t-0 m-b-30"><%--会员资料--%><%=GetLanguage("MemberInformation") %></h4>
                        <div class="row">
                            <div class="form-horizontal col-sm-12">
                                <div class="form-group">
                                    <label class="col-md-2 control-label"><%--会员编号--%><%=GetLanguage("MembershipNumber") %></label>
                                    <div class="col-md-10">
                                        <input name="txtUserCode" type="text" id="txtUserCode" class="form-control" runat="server" disabled="disabled" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-2 control-label">激活金额</label>
                                    <div class="col-md-10">
                                        <input name="txtRegMoney" type="text" id="txtRegMoney" class="form-control regm" runat="server" disabled="disabled" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-2 control-label">激活单数</label>
                                    <div class="col-md-10">
                                        <input name="txtActiveNum" type="text" id="txtActiveNum" class="form-control actnum" runat="server" oninput="jisuan(this.value)" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-2 control-label">总金额</label>
                                    <div class="col-md-10">
                                        <label class="form-control" id="totalmoney">0</label>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-2 control-label">激活方式</label>
                                    <div class="col-md-10">
                                        <asp:DropDownList ID="dropPayType" runat="server" CssClass="form-control">
                                            <asp:ListItem  Value="0" >请选择</asp:ListItem>
                                            <asp:ListItem  Value="1" >50%注册分+50%激活分激活</asp:ListItem>
                                            <asp:ListItem  Value="2" >100%注册分</asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-2 control-label">支付密码</label>
                                    <div class="col-md-10">
                                        <input name="txtPayPwd" type="text" id="txtPayPwd" class="form-control" runat="server" />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group m-b-0 m-b-5">
                                <div class="col-sm-offset-2 col-sm-2">
                                    <asp:Button ID="btnSubmit" runat="server" class="btn btn-success" OnClick="btnSubmit_Click" Text="激 活"/>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card-box" id="div2" runat="server">
                        <div class="row">
                            <label>已激活</label>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        function jisuan(num) {
            var reg = $(".regm").val();
            if (!(/(^[1-9]\d*$)/.test(num)))
            {
                $(".actnum").val("");
                alert('输入的不是正整数');
                return false;
            }
            var total = reg * num;
            $("#totalmoney").text(total);
        }
    </script>
</asp:content>
