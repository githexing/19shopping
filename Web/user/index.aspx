<%@ Page Language="C#" MasterPageFile="~/user/index.Master" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="Web.user.index" %>

<%@ Register Src="~/userControl/Right.ascx" TagPrefix="uc2" TagName="Right" %>
<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<asp:content contentplaceholderid="ContentPlaceHolder1" runat="server">
     
<script type="text/javascript" src="/JS/jquery.qrcode.min.js"></script>
    <style type="text/css">
        @media (max-width:700px){
            .col-xs-4 h2{ font-size:18px}
            .card-box{padding: 20px 5px}
        }
    </style>
        <div class="content">
            <div class="container">
                <div class="row">
                    <%--<div class="col-xs-4">
                        <div class="card-box widget-user">
                            <div class="text-center">
                                <h2 class="text-warning"><asp:Literal runat="server" ID="ltUserCode"></asp:Literal></h2>
                                <h5>会员编号</h5>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-4">
                        <div class="card-box widget-user">
                            <div class="text-center">
                                <h2 class="text-warning"><asp:Literal runat="server" ID="ltNicheng"></asp:Literal></h2>
                                <h5>昵称</h5>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-4">
                        <div class="card-box widget-user">
                            <div class="text-center">
                                <h2 class="text-warning"><asp:Literal runat="server" ID="ltLevelName"></asp:Literal></h2>
                                <h5>当前等级</h5>
                            </div>
                        </div>
                    </div>--%>
                    <div class="col-xs-4">
                        <div class="card-box widget-user">
                            <div class="text-center">
                                <h2 class="text-success"><asp:Literal runat="server" ID="ltTotalFhDian"></asp:Literal></h2>
                                <h5>
                                    龙珠总量
                                </h5>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-4">
                        <div class="card-box widget-user">
                            <div class="text-center">
                                <h2 class="text-success"><asp:Literal runat="server" ID="ltOutFhd"></asp:Literal></h2>
                                <h5>出局龙珠</h5>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-4">
                        <div class="card-box widget-user">
                            <div class="text-center">
                                <h2 class="text-success"><asp:Literal runat="server" ID="ltSettleFhd"></asp:Literal></h2>
                                <h5>共享龙珠</h5>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-xs-4">
                        <div class="card-box widget-user">
                            <div class="text-center">
                                <h2 class="text-pink"><%=LoginUser.Emoney%></h2>
                                <h5>注册分</h5>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-4">
                        <div class="card-box widget-user">
                            <div class="text-center">
                                <h2 class="text-pink"><%=LoginUser.BonusAccount%></h2>
                                <h5>奖励分</h5>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-4">
                        <div class="card-box widget-user">
                            <div class="text-center">
                                <h2 class="text-pink"><%=LoginUser.StockMoney%></h2>
                                <h5>复利分</h5>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-4">
                        <div class="card-box widget-user">
                            <div class="text-center">
                                <h2 class="text-pink"><%=LoginUser.StockAccount%></h2>
                                <h5>激活分</h5>
                            </div>
                        </div>
                    </div>
                    <%--<div class="col-xs-4">
                        <div class="card-box widget-user">
                            <div class="text-center">
                                <h2 class="text-pink"><%=LoginUser.GLmoney%></h2>
                                <h5>购物分</h5>
                            </div>
                        </div>
                    </div>--%>
                    <div class="col-xs-4">
                        <div class="card-box widget-user">
                            <div class="text-center">
                                <h2 class="text-warning"><asp:Literal runat="server" ID="ltLeftScore"></asp:Literal></h2>
                                <h5>左市场</h5>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-4">
                        <div class="card-box widget-user">
                            <div class="text-center">
                                <h2 class="text-warning"><asp:Literal runat="server" ID="ltRightScore"></asp:Literal></h2>
                                <h5>右市场</h5>
                            </div>
                        </div>
                    </div>
                    <%--<div class="col-xs-4">
                        <div class="card-box widget-user">
                            <div class="text-center">
                                <h4 class="text-info"><asp:Literal runat="server" ID="ltRecUrl"></asp:Literal></h4>
                                <h5>推广链接</h5>
                            </div>
                        </div>
                    </div>--%>
                </div>
                
                <%--<script type="text/javascript">
                    function toUtf8(str) {
                        var out, i, len, c;
                        out = "";
                        len = str.length;
                        for (i = 0; i < len; i++) {
                            c = str.charCodeAt(i);
                            if ((c >= 0x0001) && (c <= 0x007F)) {
                                out += str.charAt(i);
                            } else if (c > 0x07FF) {
                                out += String.fromCharCode(0xE0 | ((c >> 12) & 0x0F));
                                out += String.fromCharCode(0x80 | ((c >> 6) & 0x3F));
                                out += String.fromCharCode(0x80 | ((c >> 0) & 0x3F));
                            } else {
                                out += String.fromCharCode(0xC0 | ((c >> 6) & 0x1F));
                                out += String.fromCharCode(0x80 | ((c >> 0) & 0x3F));
                            }
                        }
                        return out;
                    }
                    var left = $("#hdleft").val();
                    var right = $("#hdright").val();
                    console.log('sds');
                    console.log(left);
                    console.log(right);
                    $('#leftcode').qrcode(left);
                    $('#rightcode').qrcode(right);
                </script>--%>


                <div class="row">
                    <div class="col-sm-12">
                        <div class="card-box">
                            <h4 class="header-title m-t-0 m-b-30"><%--新闻中心--%><%=GetLanguage("NewsInformation") %></h4>
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="table-merge table-responsive">
                                        <table class="table table-condensed m-0">
                                            <thead>
                                                <tr>
                                                    <th><%--序号--%><%=GetLanguage("SerialNumber") %></th>
                                                    <th><%--标题--%><%=GetLanguage("Title") %></th>
                                                    <th><%--时间--%><%=GetLanguage("Time") %></th>
                                                    <th><%--操作--%><%=GetLanguage("Operation") %></th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <asp:Repeater ID="Repeater1" runat="server">
                                                    <ItemTemplate>
                                                        <tr class="<%# (this.Repeater1.Items.Count + 1) % 2 == 0 ? "odd":"even"%>">
                                                            <td th-name="序号"><%# this.Repeater1.Items.Count + 1%></td>
                                                            <td th-name="标题"><%# getstring(Language,Eval("NewsTitle").ToString(),18)%></a></td>
                                                            <td th-name="时间"><%#Convert.ToDateTime(Eval("PublishTime")).ToString("")%></td>
                                                            <td th-name="操作"><a href="/user/member/NoticeDetail.aspx?ID=<%#Eval("ID") %>" class="btn btn-info btn-sm"><%--查看--%><%=GetLanguage("check") %></a></td>
                                                        </tr>
                                                    </ItemTemplate>
                                                </asp:Repeater>
                                                <tr id="tr1" runat="server">
                                                    <td colspan="4" class="colspan">
                                                        <div class="form-control-static text-center"><i class="fa fa-warning text-warning"></i><%=GetLanguage("Manager")%><!--抱歉！目前数据库暂无数据显示。--></div>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
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
