<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%
    request.setAttribute("path", request.getContextPath());
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>操作菜单</title>
<link rel="stylesheet" href="../../resources/css/easyui.css"/>
<link rel="stylesheet" href="../../resources/css/icon.css"/>
<link rel="stylesheet" href="../../resources/css/menu.css"/>
<script type="text/javascript" src="../../resources/js/jquery.min.js"></script>
<script type="text/javascript" src="../../resources/js/jquery.easyui.min.js"></script>
<script type="text/javascript" src="../../resources/js/jquery.validate.js"></script>
<script type="text/javascript" src="../../resources/js/easyui-lang-zh_CN.js"></script>
</head>

<body class="easyui-layout">
	<div class="menu-hd" data-options="region:'north',border:false,split:true">	
    	<div class="sys-name">员工信息管理系统</div>
    	<span>${user.userName }</span>
    </div>
    <div class="menu-sidebar" data-options="region:'west',border:true,split:true,title:'菜单管理'">
    	<div class="easyui-accordion" data-options="border:false,fit:true">
        	<div title="快捷菜单" data-options="iconCls:'application_cascade'">
                <ul class="easyui-tree menu-tree">
                    <li iconCls="icon-password"><a href="javascript:void(0)" data-icon="icon-password" data-link="/user/toPae1" iframe="0">密码修改</a></li>
                	<li iconCls="icon-user"><a href="javascript:void(0)" data-icon="icon-user" data-link="../pages/allinfo.html" iframe="0">用户信息</a></li>
                </ul>
            </div>
        </div>
    </div>
    <div class="" data-options="region:'center'">
    	<div id="menu-tabs" class="easyui-tabs" data-options="border:false,fit:true">
        </div>
    </div> 
    <div class="menu-footer" data-options="region:'south',border:true,split:true">
    	<span style="float:left">v1.0</span>
        <%--<span style="float:center">&copy;&nbsp;2018-2025&nbsp;版权所有</span>--%>
        <span style="float:right" id="currentTime"></span>
    </div>
    
    <!--右键菜单-->
    <div id="mm" class="easyui-menu" style="width:140px">
    	<div id="refresh" data-options="iconCls:'icon-arrow_refresh'">刷新</div>
        <div class="menu-sep"></div>
        <div id="close">关闭当前页</div>
        <div id="closeOther">关闭其它页</div>
        <div id="closeAll">关闭全部</div>
        <div class="menu-sep"></div>
        <div id="closeRight">关闭右侧项</div>
        <div id="closeLeft">关闭左侧项</div>
    </div>
    
    <script type="text/javascript">
	// 重写时间格式
	window.onload = setInterval(function(){
		document.getElementById('currentTime').innerHTML = (new Date()).Format("yyyy-MM-dd hh:mm:ss");
	},1000);
    Date.prototype.Format = function (fmt) { 
        var o = {
            "M+": this.getMonth() + 1, //月份 
            "d+": this.getDate(), //日 
            "h+": this.getHours(), //小时 
            "m+": this.getMinutes(), //分 
            "s+": this.getSeconds(), //秒 
            "q+": Math.floor((this.getMonth() + 3) / 3), //季度 
            "S": this.getMilliseconds() //毫秒 
        };
        if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
        for (var k in o)
        if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
        return fmt;
    }
	
	// 设置点击事件
	$(function(){
		$('.menu-tree a').bind("click",function(){
			var title = $(this).text();
			var url = $(this).attr('data-link');
			var iconCls = $(this).attr('data-icon');
			var iframe = $(this).attr('iframe')==1?true:false;
			addTab(title,url,iconCls,iframe);
		});
		
		// 绑定右键菜单
		$(document).bind('contextmenu',function(e){
			$('#mm').menu('show',{
				left:e.pageX,
				top:e.pageY,
			});
			var subTitle = $(this).children(".tabs-closable").text();
			$('#mm').data("currentTab",subTitle);
			$('#menu-tabs').tabs('select',subTitle);
			return false;
		});
		
		// 选项卡关闭事件
		tabCloseEvent();
	});
	
	// 选项卡初始化
	$('#menu-tabs').tabs({
		tools:[{
			iconCls:'icon-reload',
			border: false,
			handler:function(){
				$('#menu-datagrid').datagrid('reload');	
			}	
		}]
	});
	
	// 添加标签页
	function addTab(title,href,iconCls,iframe){
		var tabPanel = $('#menu-tabs');
		if(!tabPanel.tabs('exists',title)){
			var content = '<iframe scrolling="auto" frameborder="0" src="'+ href + '" style="width:100%;height:100%;"></iframe>';	
			if(iframe){
				tabPanel.tabs('add',{
					title:title,
					content:content,
					iconCls:iconCls,
					fit:true,
					closable:true
				});	
			} else {
				tabPanel.tabs('add',{
					title:title,
					href:href,
					iconCls:iconCls,
					fit:true,
					closable:true
				});	
			}
		} else {
			tabPanel.tabs('select',title);	
		}
	}
	
	// 选项卡关闭事件
	function tabCloseEvent(){
		$('#mm').menu({
			onClick:function(item){
				tabClose(item.id);	
			}	
		});	
		return false;
	}
	
	// 关闭选项卡
	function tabClose(action){
		var allTabs = $('#menu-tabs').tabs('tabs');
		var currentTab = $('#menu-tabs').tabs('getSelected');
		var allTabTitle = [];
		$.each(allTabs,function(i,n){
			allTabTitle.push($(n).panel('options').title);
		});
		switch(action) {
			// 刷新页面
			case "refresh":
				//var iframe = $(currentTab.panel('options').content);
				$('#menu-tabs').tabs('update',{
					tab: currentTab,
					options: {
						//content:addTab()	
					}
				});	
				break;
				
			// 关闭选中页面
			case "close":
				var current_tab = currentTab.panel('options').title;
				$('#menu-tabs').tabs('close',current_tab);
				break;
				
			// 关闭全部
			case "closeAll":
				$.each(allTabTitle,function(i,n){
					$('#menu-tabs').tabs('close',n);
				});
				break;
				
			// 关闭其它
			case "closeOther":
				var current_tab = currentTab.panel('options').title;
				$.each(allTabTitle,function(i,n){
					if(n != current_tab) {
						$('#menu-tabs').tabs('close',n)	
					}	
				});
				break;
				
			// 关闭右侧选项卡
			case "closeRight":
				var tabIndex = $('#menu-tabs').tabs('getTabIndex',currentTab);
				if(tabIndex == allTabs.length - 1) {
					alert("已经是最后一个页面了");
					return false;	
				}
				$.each(allTabTitle,function(i,n){
					if(i > tabIndex) {
						$('#menu-tabs').tabs('close',n);
					}
				});
				break;
				
			// 关闭左侧选项卡
			case "closeLeft":
				var tabIndex = $('#menu-tabs').tabs('getTabIndex',currentTab);
				if(tabIndex == 0) {
					alert("左侧已经没有页面了");
					return false;
				}
				$.each(allTabTitle,function(i,n){
					if(i < tabIndex) {
						$('#menu-tabs').tabs('close',n);	
					}
				});
				break;
		}	
	}
	
    </script>
</body>
</html>
