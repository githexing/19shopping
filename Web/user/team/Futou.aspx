<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="/user/index.Master"  CodeBehind="Futou.aspx.cs" Inherits="Web.user.team.Futou" %>

<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<asp:Content runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <script type="text/javascript" src="/Js/My97DatePicker/WdatePicker.js"></script>
   
        <!-- Start content -->
        <div class="content">
            <div class="container">

                <div class="row">
                    <div class="col-sm-12">
                        <div class="card-box">
                            <h4 class="header-title m-t-0 m-b-30">一键复投</h4>
                            <div class="row">
                                <div class="form-inline col-sm-12">
                                    <div class="form-group">
                                        <label><%=GetLanguage("MembershipNumber")%><%--会员编号--%>:</label>
                                      <%=LoginUser.UserCode %>
                                    </div> 
                                </div>
                                    <div class="form-inline col-sm-12">
                                    <div class="form-group">
                                        <label>复投单价:</label>
                                      <%=getParamAmount("Futou1") %>
                                    </div> 
                                </div>
                                    <div class="form-inline col-sm-12">
                                    <div class="form-group">
                                        <label>复投数量:</label>
                                        <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control"></asp:TextBox>
                                    </div> 
                                </div>
                                   <div class="form-inline col-sm-12">
                                    <div class="form-group">
                                        <label>请选择支付方式:</label>
                                       <asp:DropDownList ID="DropDownList1" class="form-control" runat="server">
                                    <asp:ListItem  Value="0">-请选择-</asp:ListItem> 
                                     <asp:ListItem Value="1">50%注册分+50%激活分</asp:ListItem>
                                     <asp:ListItem Value="2">注册分</asp:ListItem>
                                     <asp:ListItem Value="3">复利分</asp:ListItem>
                                </asp:DropDownList>
                                    </div> 
                                </div>
                              
                                  <div class="form-inline col-sm-12">

                                        <div class="form-group">
                                        <label ><%=GetLanguage("SecondPassword") %><!--二级密码-->：</label>  
                                                <asp:TextBox ID="txtSecondPassword" CssClass="form-control" runat="server" TextMode="password"/>
                                             
                                    </div>
                                         </div>



                                   <div class="form-inline col-sm-12">
                                    <div class="form-group">
                                        <asp:Button ID="Button1" runat="server" Text="一键复投"  class="btn btn-success   btn-md" OnClick="Button1_Click" />
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
</asp:Content>
