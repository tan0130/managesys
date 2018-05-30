<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>查询所有用户信息</title>
</head>

<body>
	<div id="toolbar">
		<a href="javascript:openAdd()" class="easyui-linkbutton" iconCls="icon-add" plain="true">添加</a>
		<a href="javascript:remove()" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>
		<a href="javascript:openEdit()"  class="easyui-linkbutton" iconCls="icon-edit" plain="true">编辑</a>
		<a href="javascript:query()" class="easyui-linkbutton" iconCls="icon-reload" plain="true">刷新</a>
		<a href="javascript:doCancel()" class="easyui-linkbutton" iconCls="icon-undo" plain="true">撤销</a>
		<div id="search" style="float:right">
			<input id="ss" class="easyui-searchbox" searcher="doSearch" prompt="请输入工号" style="width:130px;vertical-align:middle"/>
		</div>
	</div>
	<table id="tb" border="1" class="easyui-datagrid" style="width:500px;height:500px" data-options="fit:true,pagination:true" toolbar="#toolbar">
		
	</table>
	
	<!-- 添加人员信息对话框 -->
	<div id="add-dialog" class="easyui-dialog" data-options="closed:true,iconCls:'icon-save'" style="width:350px">
		<form id="add-form" method="post">
			<table>
				<tr>
				 	<td width="60" align="right" style="margin-left:20px">用户名:</td>
				 	<td><input type="text" id="nickName" name="nickName"/></td>
				</tr>
				<tr>
					<td align="right">姓&nbsp;&nbsp;&nbsp;名:</td>
					<td><input type="text" id="userName" name="userName"/></td>
				</tr>
				<tr>
					<td align="right">密&nbsp;&nbsp;&nbsp;码:</td>
					<td><input type="text" id="userPwd" name="userPwd"/></td>
				</tr>
				<tr>
					<td align="right">性&nbsp;&nbsp;&nbsp;别:</td>
					<!-- <td><input type="radio" id="sex" name="sex" value="男" checked="checked"/>男
						<input type="radio" id="sex" name="sex" value="女"/>女
					</td> -->
					<td>
						<select name="sex" class="easyui-combobox" panelHeight="auto" style="width:100px">
							<option selected="true" value="男">男</option>
							<option value="女">女</option>
						</select>
					</td>
				</tr>
				<tr>
					<td align="right">电&nbsp;&nbsp;&nbsp;话:</td>
					<td><input type="text" id="tel" name="tel"/></td>
				</tr>
				<tr>
					<td align="right">邮&nbsp;&nbsp;&nbsp;箱:</td>
					<td><input type="text" id="email" name="email"/></td>
				</tr>
				<tr>
					<td align="right">备&nbsp;&nbsp;&nbsp;注:</td>
					<td><textarea rows="6" id="mark" name="mark" style="width:260px"></textarea></td>
				</tr>
			</table>
		</form>
	</div>
	<script type="text/javascript">
    function pagerFilter(data){            
		if (typeof data.length == 'number' && typeof data.splice == 'function'){// is array                
			data = {                   
				total: data.length,                   
				rows: data               
			}            
		}        
		var dg = $(this);         
		var opts = dg.datagrid('options');          
		var pager = dg.datagrid('getPager');          
		pager.pagination({                
			onSelectPage:function(pageNum, pageSize){                 
			opts.pageNumber = pageNum;                   
			opts.pageSize = pageSize;                
			pager.pagination('refresh',{pageNumber:pageNum,pageSize:pageSize});                  
			dg.datagrid('loadData',data);                
		}          
		});           
		if (!data.originalRows){               
			data.originalRows = (data.rows);       
		}         
		var start = (opts.pageNumber-1)*parseInt(opts.pageSize);          
		var end = start + parseInt(opts.pageSize);        
		data.rows = (data.originalRows.slice(start, end));         
		return data;       
	}
    query();
    function query() {
	 $('#tb').datagrid({
	    	url:'/user/getAllUser',
	    	method: 'GET',
			loadFilter:pagerFilter,	// 分页过滤器
			//queryParams: params, // 传入查询参数
			rownumbers:true, // 是否显示行号
			pageSize:10, // 第一页显示的条数
			pageList:[10,20,30,50,60,100], // 分页的条数
			pagination:true, // 分页按钮
			refresh:true, // 刷新按钮
			loadMsg: '正在加载用户的信息.......',
			multiSort:true,
			striped: true, // 显示斑马线
			singleSelect: false, // 只支持单选
			//fitColumns:true,
			fit:true, // 高度自适应
			nowrap: true, // 提高加载性能
			columns:[[
				{ field:'ck',checkbox:true},
				{ field:'id',title:'用户编号',width:"15%"},
				{ field:'nickname',title:'用户名',width:"15%"},
				{ field:'username',title:'姓名',width:"15%"},
				{ field:'sex',title:'性别',width:"8%"},
				{ field:'tel',title:'电话',width:"15%"},
				{ field:'email',title:'邮箱',width:"15%"},
				{ field:'mark',title:'备注',width:"15%"}
			]]
	    });
    }
	 
	 // 添加人员信息
	 function add() {
		 $('#add-form').form('submit',{
			url:'/user/addUser',
		 	success:function(data) {
		 		if(data == "success") {
		 			$.messager.alert('信息提示','添加成功！','info');
		 			$('#add-form').form('reset');
		 			query();
		 		} else {
		 			$.messager.alert('信息提示','添加失败','info');
		 			query();
		 		}
		 	},
		 	error:function() {
		 		$.messager.alert('信息提示','服务器不可用','info');
		 	}
		 });
	 }
	 // 打开添加窗口
	 function openAdd() {
		$('#add-form').form('clear');
		$('#add-dialog').dialog({
			closed: false,
			modal: true,
			title: "添加信息",
			buttons: [{
				text: '添加',
				iconCls: 'icon-ok',
				handler: add
			}, {
				text: '重置',
				iconCls: 'icon-reset',
				handler:function() {
					$('#add-form').form('clear');
				}
				
			}]
		});
	 }
	 
	 // 删除人员
	 function remove() { 
		 var items = $('#tb').datagrid('getChecked');
		 var result = null;
		 if(items.length == 0) {
			 $.messager.alert('信息提示','请选中要删除的行！','info');
		 } else {
			 var ids = []; // 用于存放要删除的id
			 $(items).each(function(){
				 ids.push(this.id);
			 });
			 var rowIndex = 0;
			 
			 $.messager.confirm('信息提示','确定要删除记录？',function(result){
				 for (var i = ids.length - 1; i >= 0; i--) {	
					 rowIndex = ids[i];
					 console.log(rowIndex);
				 if(result) {
					 $.ajax({
						url: '../../../managesys/user/deleteUser?id=' + rowIndex,
						type: 'POST',
						async: false,
						success:function(data) {
							if(data == "success") {
								result = true;
							} else {
								result = false;
							}
						},
						error:function() {
							$.messager.alert('信息提示','服务器不可用！','info');
						}
					 });
				 } else {
					 query();
				 }
			 };
			 if(result == true) {
				 $.messager.alert('信息提示','删除成功！','info');
				 query();
			 } else {
				 $.messager.alert('信息提示','删除失败！','info');
				 query();
			 }
			 });
		 }
	 }
	 
	 // 编辑按钮
	 function edit() {
		 var item = $('#tb').datagrid('getSelected');
		  $('#add-form').form('submit',{
				 url: '../../../managesys/user/editUser?id=' + item.id,
				 success:function(data) {
					if(data == "success") {
						$.messager.alert('信息提示','提交成功','info');
						$('#add-dialog').dialog('close');
						query();
					} else {
						$.messager.alert('信息提示','提交失败','info');
						query();
					}
				 },
			 	error:function() {
			 		$.messager.alert('信息提示','服务不可用','info');
			 	}
			 });
	 }
	 
	 // 打开编辑窗口
	 function openEdit() {
		 $('#add-form').form('clear');
		 var items = $('#tb').datagrid('getSelections'); // 
		 var ids = [];
		 $(items).each(function(){
			 ids.push(this.id);
		 });
//		 console.log(ids.length);
		 if(ids.length != 1) {
			 $.messager.alert('信息提示','一次只能编辑一行，你已选择'+ids.length+'个用户','info');
		 } else {
		 var item = $('#tb').datagrid('getSelected');
		 
			 $('#add-dialog').dialog({
				closed: false,
				modal: true,
				title: '修改信息',
				buttons: [{
					text: '确定',
					iconCls: 'icon-ok',
					handler: edit
				},{
					text: '取消',
					iconCls: 'icon-cancel',
					handler:function() {
						$('#add-dialog').dialog('close');
					}
				}]
			 });
		 	// 在对话框回显选中行的值
			$('#nickName').val(item.nickname);
            $('#userName').val(item.username); 
            $('#userPwd').val('*****');
            $('#sex').val();
            $('#tel').val(item.tel);  
            $('#email').val(item.email); 
            $('#mark').val(item.mark);
		 }
	 }
	 
	 // 实现全局搜索功能
	 function doSearch(value,name) {
		 var text = $('#ss').searchbox('getValue');
		 if(text == 0) {
			 $.messager.alert('信息提示','请输入要查询的工号','info');
			 query();
		 } else {
			 $('#tb').datagrid({
		    	url:'../../../managesys/user/getUserByIdList?id='+ value,
		    	method: 'GET',
				loadFilter:pagerFilter,	// 分页过滤器
				//queryParams: params, // 传入查询参数
				rownumbers:true, // 是否显示行号
				pageSize:10, // 第一页显示的条数
				pageList:[10,20,30,50,60,100], // 分页的条数
				pagination:true, // 分页按钮
				refresh:true, // 刷新按钮
				loadMsg: '正在加载用户的信息.......',
				multiSort:true,
				striped: true, // 显示斑马线
				singleSelect: false, // 只支持单选
				//fitColumns:true,
				fit:true, // 高度自适应
				nowrap: true, // 提高加载性能
				columns:[[
					{ field:'ck',checkbox:true},
					{ field:'id',title:'用户编号',width:"15%"},
					{ field:'nickname',title:'用户名',width:"15%"},
					{ field:'username',title:'姓名',width:"15%"},
					{ field:'sex',title:'性别',width:"8%"},
					{ field:'tel',title:'电话',width:"15%"},
					{ field:'email',title:'邮箱',width:"15%"},
					{ field:'mark',title:'备注',width:"15%"}
				]]
		    });
		 }
	 }
	 
	 function doCancel(index) {
		 $('#tb').datagrid('cancleEdit',index);
		 editRow = undifined;
	 }
	</script>
</body>
</html>
