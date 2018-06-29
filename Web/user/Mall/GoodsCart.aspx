<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="/user/Index.Master" CodeBehind="GoodsCart.aspx.cs" Inherits="Web.user.Mall.GoodsCart" %>

<asp:content runat="server" contentplaceholderid="ContentPlaceHolder1">
    <script type="text/javascript">
        $(document).ready(function () {
            $(".nav-nav").eq(3).addClass("nav-active")
        });
    </script>
    <style type="text/css">
        .divnone {
            display: none;
        }

        .divnxs {
            display: block;
        }

        .cart-list {
        }

        .cart-li {
            padding: 20px 0;
            margin: 0 20px;
            border-bottom: 1px solid #f5f5f5;
        }

        .cart-img {
            max-width: 220px;
            max-height: 120px;
            float: left;
            margin-right: 10px;
            overflow: hidden;
        }

            .cart-img img {
                max-width: 100%;
            }

        .cart-info {
            float: left;
            width: 500px;
        }

        .cart-title {
            margin: 0 10px 10px 0;
            overflow: hidden;
            -ms-text-overflow: ellipsis;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        .cart-sp {
            margin-bottom: 5px;
        }

        .cart-del {
            display: inline-block;
            padding: 5px 8px;
            background: #e98034;
            color: #fff;
            border-radius: 4px;
            margin-bottom: 10px;
        }

            .cart-del:hover,
            .cart-del:focus {
                color: #fff;
                text-decoration: none;
            }

            .cart-del:hover {
                background-color: #ff984e;
            }

        .cart-numbtn {
        }

            .cart-numbtn input:focus {
                outline: none;
            }

            .cart-numbtn input[type=button] {
                width: 35px;
                height: 35px;
                border: 1px solid #eee;
                background-color: #fff;
                border-radius: 4px;
            }

                .cart-numbtn input[type=button]:hover {
                    background-color: #eee;
                }

            .cart-numbtn input[type=number] {
                width: 80px;
                height: 35px;
                border: 1px solid #eee;
                border-radius: 4px;
                text-align: center;
            }

            .cart-numbtn input[type=text] {
                width: 80px;
                height: 35px;
                border: 1px solid #eee;
                border-radius: 4px;
                text-align: center;
            }
    </style>

    <asp:ScriptManager runat="server"></asp:ScriptManager>
    <div class="content">
        <div class="container">
			<!--主体开始-->
			<div class="row">
			    <div class="col-md-12 tablet-column-reset form-inline">
				    <div class="panel panel-default">
						<div class="panel-heading">
	                        <h3 class="panel-title">购物车</h3>
		                </div>
								
						<div class="widget-body" style="padding: 20px;overflow: auto;">
                            <div style="margin:20px 0 0 20px;" class="">
                                <div class="form-group">
							        <label class="control-label">请选择收货方式：</label>
                                    <select id="shtype" class="form-control">
                                        <option value="0">请选择</option>
                                        <option value="1">所属服务中心自提</option>
                                        <option value="2">公司发快递</option>
                                    </select>
                                </div>
                            </div>
							<%--<asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                <ContentTemplate>
						    <div style="margin:20px 0 0 20px;" class="">
                                <div class="form-group">
							        <label class="control-label">请选择收货地址：</label>
                                    <asp:DropDownList CssClass="form-control" runat="server" ID="dropAddress" AutoPostBack="True" OnSelectedIndexChanged="dropAddress_SelectedIndexChanged"></asp:DropDownList>
                                </div>
                                <div class="form-group">
								    <label class="control-label">详细地址：</label><asp:Label runat="server" ID="lbAddess"></asp:Label>
								</div>
							</div>
                                </ContentTemplate>
                            </asp:UpdatePanel>--%>
						</div>
								
						<div id="divlist" class="cart-list">
                            <div class="cart-li clearfix">
                                <input type="checkbox" class="allselect" id="btnselectAll"/>全选
                            </div>
                            <asp:Repeater runat="server" ID="RepeaterCar">
                                <ItemTemplate>
                                    <div class="cart-li clearfix">
                                        <div class="cart-img">
                                            <input type="checkbox" class="cartselect" value='<%#Eval("ID") %>' runat="server" />
                                        </div>
							            <div class="cart-img">
                                            <img src='../../Upload/<%#Eval("Pic1") %>' alt=""/>
							            </div>
								        <div class="cart-info">
									        <h3 class="cart-title"><a href='Goodsdetail.aspx?gid=<%#Eval("GoodsID") %>'><%#Eval("GoodsName") %></a></h3>
									        <%--<div class="cart-sp">颜色分类：红色</div>--%>
									        <div class="cart-sp">价格：¥<%#Eval("RealityPrice") %></div>
									        <%--<div class="cart-sp">数量：<%#Eval("Goods006") %></div>--%>
								        </div>
								        <div class="cart-handle">
									        <a href="javascript:;" class="cart-del" >删除</a>
									        <div class="cart-numbtn">
										        <input type="button" name="" id="minus" class="minus" value="-" />
										        <input type="text" name="" id="cartnum" class="cartnum" value='<%#Eval("Goods006") %>' 
                                                    onkeyup="value=value.replace(/[^\d]/g,'')"
                                                    onafterpaste="this.value=this.value.replace(/[^\d]/g,'') "/>
										        <input type="button" name="" id="add" class="add" value="+" />
                                                <input type="hidden" class="carid" runat="server" value='<%#Eval("ID") %>' />
									        </div>
								        </div>
							        </div>
                                </ItemTemplate>
                            </asp:Repeater>
                            <input type="hidden" id="hdVlaue" runat="server" class="hdVlaue" value="0"/>
                            <input type="hidden" id="hduid" runat="server" class="hduid" value="0"/>
                            <div class="checkcart" style="font-size:13px;text-align:right;padding: 0 20px 20px 20px;">
                                <p>总价：<span class="prices">￥0</span></p>
                                <input type="button" id="paybtn" value="支付" class="btn btn-primary" />
                            </div>
						</div>
                        
						<footer class="data-footer innerAll half text-right clearfix"></footer>
                        <div id="divempty" style="font-size:18px;text-align:center;">
                            <div class="emptycart">您的购物车是空的～</div>
                        </div>
					</div>
                    
				</div>
			</div>
		</section>
    </div>
    <script type="text/javascript" src="../../JS/jquery-1.7.1.min.js"></script>
    <script type="text/javascript">
        $(function () {
            var $allselect = $(".allselect");
            var $cartselect = $(".cartselect");
            var selectnum = 0;
            var $minus = $(".minus");
            var $add = $(".add");
            var $cartnum = $(".cartnum");
            var $paybtn = $("#paybtn");
            var $allpricebox = $(".checkcart .prices");
            var $price = $(".cart-list .cart-sp");
            var $hdid = $(".carid");
            var $delid = $(".cart-del");

            var $divD = $("#divempty");
            var $divE = $("#divlist");
            var a = $(".hdVlaue").val();
            if (a == 0) {
                $divD.addClass("divnone");
                $divE.addClass("divnxs");
            }
            else {
                $divD.addClass("divnone");
                $divE.addClass("divnxs");
            }

            function getprice() {
                var $totalprice = 0;
                $.each($cartnum, function (i, o) {
                    if ($cartselect.eq(i).prop("checked")) {
                        var price = $price.eq(i).html();
                        //console.log('price:' + price);
                        //console.log('num:' + o.value);
                        $totalprice = $totalprice + (o.value * price.substr(4)) * 100;
                    }
                });

                $totalprice = parseInt($totalprice);
                $allpricebox.html('￥' + $totalprice / 100);
            }

            $delid.on('click', function () {
                var a = $delid.index(this);
                var cid = $hdid.eq(a).val();
                console.log(cid);
                $.ajax({
                    type: 'POST',
                    url: '/APPService/Mall.ashx',
                    data: { act: "del", cartid: cid },
                    success: function (result) {
                        var data = eval('(' + result + ')');
                        alert(data.message);
                        if (data.state == 'success') {
                            window.location.reload();
                        }
                    },
                    error: function (msg) {
                        //$(".notice").html('Error:'+msg);
                        console.log(msg);
                    }
                });
            });

            $minus.on('click', function () {
                var a = $minus.index(this);
                //console.log("index:" + a);
                var num = $cartnum.eq(a).val();
                num = parseInt(num) - 1;
                var cid = $hdid.eq(a).val();
                $.ajax({
                    type: 'POST',
                    url: '/APPService/Mall.ashx',
                    data: { act: "minus", cartid: cid, num: num },
                    success: function (result) {
                        var data = eval('(' + result + ')');
                        alert(data.message);
                        if (data.state == 'success') {
                            $cartnum.eq(a).val(num);
                            if (selectnum) {
                                getprice();
                            }
                        }
                    },
                    error: function (msg) {
                        //$(".notice").html('Error:'+msg);
                        console.log(msg);
                    }
                });
            });

            $add.on('click', function () {
                var b = $add.index(this);
                var num = $cartnum.eq(b).val();
                num = parseInt(num) + 1;
                var cid = $hdid.eq(b).val();
                $.ajax({
                    type: 'POST',
                    url: '/APPService/Mall.ashx',
                    data: { act: "add", cartid: cid, num: num },
                    success: function (result) {
                        var data = eval('(' + result + ')');
                        alert(data.message);
                        if (data.state == 'success') {
                            $cartnum.eq(b).val(num);
                            if (selectnum) {
                                getprice();
                            }
                        }
                    },
                    error: function (msg) {
                        console.log(msg);
                    }
                });
            });

            $cartselect.on('click', function () {
                if (this.checked) {
                    selectnum++;
                } else {
                    selectnum--;
                }
                //if (selectnum < $cartselect.length) {
                //    $allselect.removeClass("checked");
                //} else {
                //    $allselect.addClass("checked");
                //}
                if (selectnum) {
                    $paybtn.html('支付(' + selectnum + ')');
                } else {
                    $paybtn.html('支付');
                }
                getprice();
            });
            //全选
            $allselect.on('click', function () {
                if ($(this).hasClass("checked")) {
                    $cartselect.prop("checked", null);
                    $(this).removeClass("checked");
                    selectnum = 0;
                } else {
                    selectnum = $cartselect.length;
                    $cartselect.prop("checked", "true");
                    $(this).addClass("checked");
                }

                if (selectnum) {
                    $paybtn.html('支付(' + selectnum + ')');
                } else {
                    $paybtn.html('支付');
                }
                getprice();
            });

            $paybtn.on('click', function () {
                $(this).attr('disabled', 'true');
                var idsstr = "";
                var isc = "";
                var iuid = $(".hduid").val();
                var list = [];
                $cartselect.each(function (index, item) { //遍历table里的全部checkbox
                    var va = $(this).val();
                    idsstr += va + ","; //获取所有checkbox的值
                    if ($(this).is(":checked")) {//如果被选中
                        isc += va + ","; //获取被选中的值
                        var num = $cartnum.eq(index).val();
                        if (num <= 0) {
                            alert("购物车中商品的数量必须大于0");
                        }
                        list.push({ "id": va, "num": num });
                    }
                });
                console.log(list);
                isc = isc.substring(0, isc.length - 1);
                //console.log("总：" + idsstr);
                //console.log("选：" + isc);
                var paytype = 4;
                if (paytype <= 0) {
                    alert("请选择结算的账户");
                    setTimeout("$('#paybtn').removeAttr('disabled')", 2000);
                    return;
                }
                if (isc.length == 0) {
                    alert("请选择购物车中的商品");
                    setTimeout("$('#paybtn').removeAttr('disabled')", 2000);
                    return;
                }
                var addrid = 0;//
                //if (addrid <= 0) {
                //    alert("请选择收货地址");
                //    setTimeout("$('#paybtn').removeAttr('disabled')",2000);
                //    return;
                //}
                var shtype = $("#shtype").find("option:selected").val();
                console.log(shtype);
                if (shtype == 0) {
                    alert("请选择收货方式");
                    setTimeout("$('#paybtn').removeAttr('disabled')", 2000);
                    return;
                }
                if (isc.length > 0) {
                    $.ajax({
                        type: 'POST',
                        url: '/APPService/Mall.ashx',
                        data: { act: "pay", cartidlist: JSON.stringify(list), uid: iuid, paytype: paytype, addrid: addrid, shtype:shtype },
                        success: function (result) {
                            var data = eval('(' + result + ')');
                            alert(data.message);
                            if (data.state == 'success') {
                                window.location.reload();
                            }
                        },
                        error: function (msg) {
                            console.log(msg);
                        }
                    });
                }
                setTimeout("$('#paybtn').removeAttr('disabled')", 2000);
            });

            //正整数验证
            function isPInt(str) {
                var g = /^[1-9]*[1-9][0-9]*$/;
                return g.test(str);
            }
            //更新购物车数量
            $cartnum.on('change', function () {
                var c = $cartnum.index(this);
                //console.log('c:' + c);
                var cid = $hdid.eq(c).val();
                //console.log('cid:' + cid);
                var num = $(this).val();
                //console.log('num:' + num);
                if (!isPInt(num)) {
                    alert("购物车数量格式错误");
                    return;
                }
                if (num <= 0) {
                    alert("购物车数量必须大于0");
                    return;
                }
                $.ajax({
                    type: 'POST',
                    url: '/APPService/Mall.ashx',
                    data: { act: "add", cartid: cid, num: num },
                    success: function (result) {
                        var data = eval('(' + result + ')');
                        alert(data.message);
                        if (data.state == 'success') {
                            $cartnum.eq(c).val(num);
                            if (selectnum) {
                                getprice();
                            }
                        }
                    },
                    error: function (msg) {
                        console.log(msg);
                    }
                });
            })

            //var a = $(".hdVlaue").val();
            //var divD = document.getElementsByClassName("divlist");
            //var divE = document.getElementsByClassName("divempty");
            //if (a == 0) {//空
            //    divD.style.display = "none";
            //    divE.style.display = "block";
            //}
            //else {
            //    divD.style.display = "block";
            //    divE.style.display = "none";
            //}
        });

    </script>
</asp:content>
