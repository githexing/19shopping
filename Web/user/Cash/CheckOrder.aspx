<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/user/index.Master" CodeBehind="CheckOrder.aspx.cs" Inherits="Web.user.Cash.CheckOrder" %>

<asp:Content runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
     <script src="/js/clipboard.min.js"></script>
       <style>
        .controls {
            position: relative;
        }

        .selectimage {
            position: absolute;
            width: 84px !important;
            height: 34px !important;
            padding: 0 !important;
            left: 0;
            top: 0;
            opacity: 0;
            cursor: pointer;
            box-sizing: border-box;
        }
    </style>
     <script>
        function IsPC() {
            var userAgentInfo = navigator.userAgent;
            var Agents = ["Android", "iPhone",
                  "SymbianOS", "Windows Phone",
                  "iPad", "iPod"];
            var flag = true;
            for (var v = 0; v < Agents.length; v++) {
                if (userAgentInfo.indexOf(Agents[v]) > 0) {
                    flag = false;
                    break;
                }
            }
            return flag;
        }

        $(function () {
           var clipboard3 = new ClipboardJS('.btn3');
                        clipboard3.on('success', function (e) {
                            //  console.log(e);
                                alert("���Ƴɹ���")
                        });
                        clipboard3.on('error', function (e) {
                            //  console.log(e);
                            if (!IsPC()) {
                                alert("����ʧ�ܣ����ֶ�����")
                            }
                        });

                        var $this = $('#bagaddr');
                        console.log($this);
                        var text_length = $this.val().length;//��ȡ��ǰ�ı���ĳ���  
                        var current_width = parseInt(text_length) * 16;//��16�Ǹı�ǰ�Ŀ�ȳ��Ե�ǰ�ַ����ĳ���,���ÿ���ַ��ĳ���  
                        console.log(current_width)
                        $this.css("width", current_width + "px");
        })
    </script>
        <!-- Start content -->
        <div class="content">
            <div class="container">
				<div class="row">
					
				</div>
				
				<div class="row">
					<div class="col-sm-12">
						<div class="card-box">
                            <h4 class="header-title m-t-0 m-b-30"><%=GetLanguage("OrderInformation")%><%--������Ϣ--%></h4>
                            <div class="row form-horizontal">
                        		<div class="form-group col-sm-6">
                                    <label class="col-sm-3 control-label"><%=GetLanguage("OrderNumber")%>��<%--�������--%></label>
                                    <div class="col-sm-9 form-control-static"> <asp:Literal ID="ltOrderCode" runat="server"></asp:Literal></div>
                                </div>
                    			<div class="form-group col-sm-6">
                                    <label class="col-sm-3 control-label"><%=GetLanguage("OrderTime")%>��<%--�¶�ʱ��--%></label>
                                    <div class="col-sm-9 form-control-static"><asp:Literal ID="ltOrderDate" runat="server"></asp:Literal>  </div>
                                </div>
                    			<div class="form-group col-sm-6">
                                    <label class="col-sm-3 control-label"><%=GetLanguage("BuyNote")%>��<%--����ע--%></label>
                                    <div class="col-sm-9 form-control-static"> <asp:Literal ID="ltBRemark" runat="server"></asp:Literal></div>
                                </div>
                    			<div class="form-group col-sm-6">
                                    <label class="col-sm-3 control-label"><%=GetLanguage("SalesNote")%>��<%--���۱�ע--%></label>
                                    <div class="col-sm-9 form-control-static"> <asp:Literal ID="ltSRemark" runat="server"></asp:Literal></div>
                                </div>
                    			
                            </div>
						</div>
					</div>
                </div>
				
                	<div class="row">
					<div class="col-sm-12">
						<div class="card-box">
                            <h4 class="header-title m-t-0 m-b-30"><%=GetLanguage("CommodityInfo")%><%--��Ʒ��Ϣ--%></h4>
                            <div class="row form-horizontal">
                        		<div class="form-group col-sm-6">
                                    <label class="col-sm-3 control-label">��������<!--��������-->��</label>
                                    <div class="col-sm-9 form-control-static">
                                        <asp:Literal ID="ltSellNumber" runat="server"></asp:Literal>
                                    </div>
                                </div>
                                <div class="form-group col-sm-6">
                                    <label class="col-sm-3 control-label">��������<!--��������-->��</label>
                                    <div class="col-sm-9 form-control-static">
                                        <asp:Literal ID="ltBuyNumber" runat="server"></asp:Literal>
                                    </div>
                                </div>
                    			<div class="form-group col-sm-6">
                                    <label class="col-sm-3 control-label"> ֧�����<%--֧�����--%>��</label>
                                    <div class="col-sm-9 form-control-static">
                                     <asp:Literal ID="ltAmount" runat="server"></asp:Literal>
                                    </div>
                                </div>
                            </div>
						</div>
					</div>
                </div>
				 	<div class="row">
					<div class="col-sm-12">
						<div class="card-box">
                            <h4 class="header-title m-t-0 m-b-30"><%=GetLanguage("SellerInfo")%><%--������Ϣ--%></h4>
                            <div class="row form-horizontal">
                        		<div class="form-group col-sm-6" style="display:none;">
                                    <label class="col-sm-3 control-label"><%=GetLanguage("MembershipNumber") %><%--��Ա���--%></label>
                                    <div class="col-sm-9 form-control-static">
                                        <asp:Literal ID="ltUserCode" runat="server"></asp:Literal>
                                    </div>
                                </div>
                                <div class="form-group col-sm-6">
                                    <label class="col-sm-3 control-label"><%=GetLanguage("MemberNickname")%>��<%--�ǳ�--%></label>
                                    <div class="col-sm-9 form-control-static">
                                        <asp:Literal ID="ltNiceName" runat="server"></asp:Literal>
                                    </div>
                                </div>
                                 <div class="form-group col-sm-6">
                                    <label class="col-sm-3 control-label"><%=GetLanguage("ContactPhone")%>��<%--�ֻ�����--%></label>
                                    <div class="col-sm-9 form-control-static">
                                        <asp:Literal ID="ltPhoneNum" runat="server"></asp:Literal>
                                    </div>
                                </div>
                                
                                 
                           <h5 class="page-header"></h5>
                        
                                 <div class="form-group col-sm-6" style="height:26px;">
                                    <label class="col-sm-3 control-label"><%=GetLanguage("ReceiveAccount") %>��<%--�տ��˻�--%></label>
                                    <div class="col-sm-9 form-control-static">
                                        <div class="input-group">
                                         <asp:Literal ID="ltReceiveAccount" runat="server"></asp:Literal>  
                                        </div>
                                    </div>
                                </div>
                                       
                                <div class="form-group col-sm-6">
                                    <label class="col-sm-3 control-label"></label>
                                    <div class="col-sm-9 form-control-static">
                                        
                                    </div>
                                </div>
                              
                               <div class="form-group col-sm-6" id="divBankAccount" runat="server">
                                    <label class="col-sm-3 control-label"><%=GetLanguage("BankAccount")%>��<%--�����ʺ�--%></label>
                                    <div class="col-sm-9 form-control-static">
                                        <asp:Literal ID="ltBankAccount" runat="server"></asp:Literal>
                                    </div>
                                </div>
                                                                
                                <div class="form-group col-sm-6" id="divBankAccountUser" runat="server">
                                    <label class="col-sm-3 control-label"><%=GetLanguage("AccountName")%>��<%--��������--%></label>
                                    <div class="col-sm-9 form-control-static">
                                        <asp:Literal ID="ltBankAccountUser" runat="server"></asp:Literal>
                                    </div>
                                </div>
                                <div class="form-group col-sm-6" id="divQRNiceName" runat="server">
                                    <label class="col-sm-3 control-label"><%=GetLanguage("MemberNickname")%>��<%--�ǳ�--%></label>
                                    <div class="col-sm-9 form-control-static">
                                        <asp:Literal ID="ltQRNiceName" runat="server"></asp:Literal>
                                    </div>
                                </div>
                                 <div class="form-group col-sm-6" id="divOutQrCode"  runat="server">
                                        <label class="col-md-3 control-label"><asp:Label ID="lblOutQRCodeTitle" runat="server">�տ��ά��</asp:Label>��</label>
                                        <div class="col-md-9">
                                           <asp:Image ID="imgOutQRCode" runat="server" ImageUrl="" style="height:200px;" /> 
                                        </div>
                                  
                                 </div>
                                <div class="form-group col-sm-6" id="divBagAddress"  runat="server">
                                        <label class="col-md-3 control-label"><asp:Label ID="Label1" runat="server">��ַǮ��</asp:Label>��</label>
                                        <div class="col-md-9">
                                           <%--<asp:Literal ID="ltBagAddress" runat="server"></asp:Literal>--%>
                                            <input  id="bagaddr" style="border:0px;" class="bagaddr"  type="text" value="<%=BagAddress %>" />
                                            <input class="btn fa-copy btn3" type="button"  data-clipboard-action="copy"  data-clipboard-target="#bagaddr"  value="����" />
                                        </div>
                                    
                    			
                            </div>
                                 
                            </div>
						</div>
					</div>
                </div>
                <div class="row" id="divBuyerInfo" runat="server">
                	<div class="col-sm-12">
						<div class="card-box">
                          
                             <h6><%=GetLanguage("BuyersInfo")%><%--�����Ϣ--%>��</h6>
                            <div class="row form-horizontal">
                        		<div class="form-group col-sm-6">
                                    <label class="col-sm-3 control-label"> <%=GetLanguage("MemberNickname")%><%--��Ա���--%>��&nbsp;</label>
                                    <div class="col-sm-9 form-control-static">
                                      <asp:Literal ID="ltBUserCode" runat="server"></asp:Literal>
                                    </div>
                                </div>
                    			
                    			<div class="form-group col-sm-6">
                                    <label class="col-sm-3 control-label">   <%=GetLanguage("ContactPhone")%>��<%--����ֻ�����--%></label>
                                    <div class="col-sm-9 form-control-static">
                                      <asp:Literal ID="ltBPhoneNum" runat="server"></asp:Literal>
                                    </div>
                                </div>
                               
                                <div class="form-group  col-sm-6">
                                    <label class="col-md-3 control-label">ͼƬƾ֤<!--�ϴ�ƾ֤-->��<span class="required">&nbsp;</span>
                                    </label>
                                     <div class="col-md-9">
                                    <span class="file-input has-error">
                                        <div class="file-preview">
                                            <div class="file-drop-zone clearfix">
                                                <div class="file-preview-frame">
                                                            
                                                    <img id="previewImage" class="previewImage" runat="server" src="/images/uploadfile.png" style="min-width: 160px; max-height: 120px;" alt="����ͼƬ" />
                                                    <input type="hidden" id="hiddenupimage" name="hiddenupimage" value="" />
                                                </div>
                                            </div>
                                        </div>
                                    </span>
                                         </div>
                                </div>
                                <div class="form-group" id="divUploadImage" runat="server">
                                    <label class="col-md-2 control-label"></label>
                                    <div class="col-md-10" id="upload">
                                      
                                        <div  class="controls input-icon" >
                                            <a class="btn btn-primary"><%=GetLanguage("Selectpicture") %></a>
                                            <input type="file" id="selectImage3" name="selectImage3" class="btn selectimage" />
                                            <input type="button" id="uploadImage" name="uploadImage" value='<%=GetLanguage("upload") %>' class="file btn btn-primary" style="display:none;" />
                                        </div>
                                    </div>
                               </div>
                            </div>
                            
						</div>
					</div>
                </div>
                 </div>
                <!-- End row -->
             <div class="row" >
					<div class="col-sm-12">
						<div class="card-box">
                            <div class="form-group m-b-0">
                                <div class="row form-horizontal">
                                        <div class="col-sm-9 form-control-static">
                    <asp:Button ID="btnCheck" runat="server" class="btn btn-custom " OnClick="btnCheck_Click" />
                                &nbsp;&nbsp;<asp:Button ID="btnBack" runat="server" class="btn btn-none " OnClick="btnBack_Click" />
                                       
                                        </div>
                                    </div>
                                </div>
						</div>
					</div>
                </div>
            </div> <!-- container -->

        </div> <!-- content -->
       <script src="/js/jquery.form.js" type="text/javascript"></script>
    <script>
          $("#uploadImage").click(function () {

              if ($('#selectImage3').val().length <= 0) {
                  alert('��ѡ���ϴ���ͼƬ');
                  return;
              }
              $("form").ajaxSubmit({
                  url: '/Handle/UploadImage.ashx',
                  beforeSubmit: function () {
                      //$("#upload").append(wait);
                      $("#upload img").css("display", "inline");
                  },
                  success: function (data) {
                      $("#upload img").fadeOut(2000);
                      if (data != "�ϴ�ʧ��") {
                          $(".previewImage").attr("src", "/upload/" + data).hide().fadeIn(2000);
                          $('#hiddenupimage').val("/upload/" + data);
                      }
                      else {
                          alert("�ϴ�ʧ��");
                      }
                  },
                  error: function (ex) {
                      alert(ex.msg);
                  }
              });
          });
          $('#selectImage3').change(function () {
              $("#uploadImage").click();
          });

    </script>
     <script src="/js/BigPicture.min.js"></script>
        <script>

            (function () {

                function setClickHandler(id, fn) {
                    document.getElementById(id).onclick = fn;
                }

                setClickHandler('<%=previewImage.ClientID%>', function (e) {
                    if ($(e.target).attr("src") == "") return;
                    e.target.tagName === 'IMG' && e.target.className === 'previewImage' && BigPicture({
                        el: e.target,
                        imgSrc: $(e.target).attr("src")
                    });
                });

            })();
        </script>
    </asp:Content>
