<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="/user/index.Master" CodeBehind="Agent.aspx.cs" Inherits="Web.user.team.Agent" %>

<asp:Content runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <div class="content">
        <div class="container">
            <div class="row">
                <div class="col-sm-12">
                    <div class="card-box">
                        <h4 class="header-title m-t-0 m-b-30">申请服务中心</h4>
                        <div class="row">
                            <div class="form-inline col-sm-12">
                                <div class="form-group" runat="server" id="div1">
                                    <label>服务中心编号</label>
                                    <asp:Label runat="server" ID="ltAgentCode" CssClass="form-control"></asp:Label>
                                </div>
                                <div class="form-group" runat="server" id="div2">
                                    <label>提示</label>
                                    <asp:Label runat="server" ID="ltAudit" CssClass="form-control"></asp:Label>
                                </div>
                                <asp:Button ID="btnSubmit" runat="server"  OnClick="btnSubmit_Click" Text="提 交" class="btn btn-success  btn-md"/>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>