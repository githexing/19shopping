﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Web.Login" %>

<!DOCTYPE html>
<html>
<head> 
    <meta charset="UTF-8">   
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title><%--登录--%><%=GetLanguage("Login") %></title>
    <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="css/core.css" />
    <link rel="stylesheet" type="text/css" href="css/components.css" />
    <link rel="stylesheet" type="text/css" href="css/icons.css" />
    <link rel="stylesheet" type="text/css" href="css/pages.css" />
    <link rel="stylesheet" type="text/css" href="css/menu.css" />
    <link rel="stylesheet" type="text/css" href="css/responsive.css" />
        <link rel="stylesheet" type="text/css" href="/css/sweetalert2.min.css" />
     <link rel="stylesheet" type="text/css" href="css/login.css"/>
</head>
<body>
  <%-- <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>--%>
    <form class="form-horizontal" id="Form1" name="colorform" runat="server">
        <asp:Panel ID="panLogin" runat="server" DefaultButton="btnLogin"> 
        <%--  <asp:UpdatePanel ID="UpdatePanel1" runat="server">
              <ContentTemplate>--%>

             
             <div class="particles-pages"  id="particles-js"></div>
    	<div class="login-bg1"></div>
    	<div class="login-bg2"></div>
    	<div class="login-bg3"></div>
        <div class="clearfix"></div>
        <div class="wrapper-page">
            <div class="text-center">
                <a href="#" class="logo">
                	<img src="images/login-logo.png"/>
                </a>
            </div>
            <div class="m-t-40 card-box">
                <div class="text-center tit-tab clearfix" id="tit-tab">
                    <h4 class="text-uppercase font-bold m-b-0 active">账号密码登录</h4>
                    <h4 class="text-uppercase font-bold m-b-0 ">短信验证码登录</h4>
                </div>
                        <div class="panel-body"> 

                        <div class="form-group ">
                            <div class="col-xs-12">
                         <input class="form-control" id="Phone"   runat="server" maxlength="20" type="text" placeholder="用户名"/>
                            </div>
                        </div>

                        <div class="form-group" id="tb-pa1">
                            <div class="col-xs-12">
                              <input class="form-control" type="password" id="TBPassWord" runat="server" placeholder="密码"/> <%--required=""--%>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="col-xs-12">
                            	<div class="input-group">
                                    <input type="text" class="form-control" id="TBCode" runat="server" placeholder="验证码"/>
                                    <span class="input-group-btn">
                                       <asp:ImageButton ID="ImageButton1" runat="server" Style="width: 80px; height: 38px; border: 0px; cursor: pointer;" ImageUrl="~/ValidatedCode.aspx" />
                                    </span>
                                </div>
                            </div>
                        </div>
						
                        <div class="form-group" id="tb-pa2" style="display: none;">
                            <div class="col-xs-12">
                            	<div class="input-group">
                          <input class="form-control" id="Text2" runat="server" type="text" maxlength="6"   placeholder="短信验证码">
                                    <span class="input-group-btn">
                                          <%--<asp:Button ID="Button1" runat="server" class="send-btn"  AutoPostBack="true"  OnClick="DX_btnLogin_Click" Text="发送验证码" />--%>
                                        <%--<asp:LinkButton  class="send-btn" ID="Button2" runat="server" OnClientClick="return asd()"  Text="发送验证码" />--%>
                                        <a id="Yanzhengma"  class="send-btn"  onclick="asd()">发送验证码</a>
                                    </span>
                                </div>
                            </div>
                        </div>
                            
                        <div class="form-group">
                            <div class="col-xs-12">
                            	  <select name="" class="form-control" id="LangType" runat="server">
                                    <%--<option value="0">-请选择-</option>--%>
                                    <option value="1" selected="selected">中文</option>
                                    <option value="2">English</option>
                                </select>
                            </div>
                        </div>
                        
                        
                        <div class="form-group text-center m-t-30">
                            <div class="col-xs-12">
                                <asp:Button ID="btnLogin" runat="server" class="btn btn-custom btn-bordred btn-block" OnClientClick="return CheckText();" type="submit" OnClick="btnLogin_Click" Text="登 录" />
                            
                            </div>
                        </div>
                            </div>
                </div>
            </div>
           <%--  </ContentTemplate>
          </asp:UpdatePanel>--%>
                            </asp:Panel>
        
                    </form>

                
          <script src="js/modernizr.min.js"></script>
<script>
            var resizefunc = [];
        </script>
<script src="js/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/detect.js"></script>
<script src="js/fastclick.js"></script>
<script src="js/jquery.slimscroll.js"></script>
<script src="js/jquery.blockui.js"></script>
<script src="js/waves.js"></script>
<script src="js/jquery.nicescroll.js"></script>
<script src="js/jquery.scrollto.min.js"></script>
<script src="js/jquery.core.js"></script>
<script src="js/jquery.app.js"></script>
<script src="js/particles.min.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">
    function asd() {
        var phone=$("#Phone").val()
        var YZM = $("#TBCode").val();
        $.ajax({
            url: "/APPService/Yanzhengma.ashx?phone=" + phone + "&&YZM=" + YZM + "&&Type=1",
            type:"post",
            success: function (data) {
                var data = eval('(' + data + ')');
                alert(data.message); 
            }

        })

    } 



	//
	$("#tit-tab h4").click(function(){
		$(this).addClass("active").siblings().removeClass("active");
		if($(this).index()==0){
			$("#tb-pa1").css("display","block");
			$("#tb-pa2").css("display","none");
		} else {
			$("#tb-pa1").css("display","none");
			$("#tb-pa2").css("display","block");
		}
	})
	
	
	// 背景动画
particlesJS("particles-js", {
  "particles": {
    "number": {
      "value": 40,
      "density": {
        "enable": true,
        "value_area": 800
      }
    },
    "color": {
      "value": "#ffffff"
    },
    "shape": {
      "type": "circle",
      "stroke": {
        "width": 0,
        "color": "#000000"
      },
      "polygon": {
        "nb_sides": 5
      },
      "image": {
        "src": "img/github.svg",
        "width": 100,
        "height": 100
      }
    },
    "opacity": {
      "value": 0.5,
      "random": false,
      "anim": {
        "enable": false,
        "speed": 1,
        "opacity_min": 0.1,
        "sync": false
      }
    },
    "size": {
      "value": 3,
      "random": true,
      "anim": {
        "enable": false,
        "speed": 40,
        "size_min": 0.1,
        "sync": false
      }
    },
    "line_linked": {
      "enable": true,
      "distance": 150,
      "color": "#ffffff",
      "opacity": 0.4,
      "width": 1
    },
    "move": {
      "enable": true,
      "speed": 6,
      "direction": "none",
      "random": false,
      "straight": false,
      "out_mode": "out",
      "bounce": false,
      "attract": {
        "enable": false,
        "rotateX": 600,
        "rotateY": 1200
      }
    }
  },
  "interactivity": {
    "detect_on": "canvas",
    "events": {
      "onhover": {
        "enable": false,
        "mode": "grab"
      },
      "onclick": {
        "enable": false,
        "mode": "push"
      },
      "resize": true
    },
    "modes": {
      "grab": {
        "distance": 140,
        "line_linked": {
          "opacity": 1
        }
      },
      "bubble": {
        "distance": 100,
        "size": 40,
        "duration": 2,
        "opacity": 8,
        "speed": 3
      },
      "repulse": {
        "distance": 200,
        "duration": 0.4
      },
      "push": {
        "particles_nb": 4
      },
      "remove": {
        "particles_nb": 2
      }
    }
  },
  "retina_detect": true
});
</script>
</body>
</html>
