!function(e){function t(t){function o(e){h.active&&(a(e),t.getPlaceholder().trigger("plotselecting",[r()]))}function n(t){1==t.which&&(document.body.focus(),void 0!==document.onselectstart&&null==x.onselectstart&&(x.onselectstart=document.onselectstart,document.onselectstart=function(){return!1}),void 0!==document.ondrag&&null==x.ondrag&&(x.ondrag=document.ondrag,document.ondrag=function(){return!1}),l(h.first,t),h.active=!0,m=function(e){i(e)},e(document).one("mouseup",m))}function i(e){return m=null,void 0!==document.onselectstart&&(document.onselectstart=x.onselectstart),void 0!==document.ondrag&&(document.ondrag=x.ondrag),h.active=!1,a(e),g()?s():(t.getPlaceholder().trigger("plotunselected",[]),t.getPlaceholder().trigger("plotselecting",[null])),!1}function r(){if(!g())return null;var o={},n=h.first,i=h.second;return e.each(t.getAxes(),function(e,t){if(t.used){var r=t.c2p(n[t.direction]),s=t.c2p(i[t.direction]);o[e]={from:Math.min(r,s),to:Math.max(r,s)}}}),o}function s(){var e=r();t.getPlaceholder().trigger("plotselected",[e]),e.xaxis&&e.yaxis&&t.getPlaceholder().trigger("selected",[{x1:e.xaxis.from,y1:e.yaxis.from,x2:e.xaxis.to,y2:e.yaxis.to}])}function c(e,t,o){return e>t?e:t>o?o:t}function l(e,o){var n=t.getOptions(),i=t.getPlaceholder().offset(),r=t.getPlotOffset();e.x=c(0,o.pageX-i.left-r.left,t.width()),e.y=c(0,o.pageY-i.top-r.top,t.height()),"y"==n.selection.mode&&(e.x=e==h.first?0:t.width()),"x"==n.selection.mode&&(e.y=e==h.first?0:t.height())}function a(e){null!=e.pageX&&(l(h.second,e),g()?(h.show=!0,t.triggerRedrawOverlay()):d(!0))}function d(e){h.show&&(h.show=!1,t.triggerRedrawOverlay(),e||t.getPlaceholder().trigger("plotunselected",[]))}function u(e,o){var n,i,r,s,c=t.getAxes();for(var l in c)if(n=c[l],n.direction==o&&(s=o+n.n+"axis",e[s]||1!=n.n||(s=o+"axis"),e[s])){i=e[s].from,r=e[s].to;break}if(e[s]||(n="x"==o?t.getXAxes()[0]:t.getYAxes()[0],i=e[o+"1"],r=e[o+"2"]),null!=i&&null!=r&&i>r){var a=i;i=r,r=a}return{from:i,to:r,axis:n}}function f(e,o){var n,i=t.getOptions();"y"==i.selection.mode?(h.first.x=0,h.second.x=t.width()):(n=u(e,"x"),h.first.x=n.axis.p2c(n.from),h.second.x=n.axis.p2c(n.to)),"x"==i.selection.mode?(h.first.y=0,h.second.y=t.height()):(n=u(e,"y"),h.first.y=n.axis.p2c(n.from),h.second.y=n.axis.p2c(n.to)),h.show=!0,t.triggerRedrawOverlay(),!o&&g()&&s()}function g(){var e=5;return Math.abs(h.second.x-h.first.x)>=e&&Math.abs(h.second.y-h.first.y)>=e}var h={first:{x:-1,y:-1},second:{x:-1,y:-1},show:!1,active:!1},x={},m=null;t.clearSelection=d,t.setSelection=f,t.getSelection=r,t.hooks.bindEvents.push(function(e,t){var i=e.getOptions();null!=i.selection.mode&&(t.mousemove(o),t.mousedown(n))}),t.hooks.drawOverlay.push(function(t,o){if(h.show&&g()){var n=t.getPlotOffset(),i=t.getOptions();o.save(),o.translate(n.left,n.top);var r=e.color.parse(i.selection.color);o.strokeStyle=r.scale("a",.8).toString(),o.lineWidth=1,o.lineJoin="round",o.fillStyle=r.scale("a",.4).toString();var s=Math.min(h.first.x,h.second.x),c=Math.min(h.first.y,h.second.y),l=Math.abs(h.second.x-h.first.x),a=Math.abs(h.second.y-h.first.y);o.fillRect(s,c,l,a),o.strokeRect(s,c,l,a),o.restore()}}),t.hooks.shutdown.push(function(t,i){i.unbind("mousemove",o),i.unbind("mousedown",n),m&&e(document).unbind("mouseup",m)})}e.plot.plugins.push({init:t,options:{selection:{mode:null,color:"#e8cfac"}},name:"selection",version:"1.1"})}(jQuery);