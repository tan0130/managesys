
<form id="signform" method="post">
    <div class="pwd-table">
    	<span class="tb-label">工号:</span><input type="text" id="userId" name="userId" class="easyui-validatebox textbox" style="margin-left:75px;width:150px"/><br/>
    	<span class="tb-label">旧密码:</span><input type="password" id="oldPwd" name="oldPwd" class="easyui-validatebox textbox" style="margin-left:60px;width:150px"/><br/>
        <span class="tb-label">新密码:</span><input type="password" id="newPwd" name="newPwd" class="easyui-validatebox textbox" style="margin-left:60px;width:150px"/><br/>
        <span class="tb-label">确认密码:</span><input type="password" id="rePwd" name="rePwd" class="easyui-validatebox textbox" style="margin-left:45px;width:150px"/><br/>
        <div class="alert">*密码不少于6位，且不能和旧密码一致</div>
        <span>
        	<input type="submit" class="btn1" value="确认" />
            <input type="reset" class="btn2" value="重置"/>
        </span>
    </div>
</form>
<script type="text/javascript">

// 自定义校验规则
$.validator.addMethod("idCheck", function(value, element) {
	var id = $('#userId').val();
	$.ajax({
		type: 'get',
		url: '../../../managesys/user/getUserById',
		async: false,
		data: {
			id: id
		},
		success:function(data) {
			if(data == "true") {
				value = true;
			} else {
				value = false;
			}
		},
		error:function() {
			$.messager.alert('信息提示', '服务器出错了', 'info');
		}
	});
	return this.optional(element) || value;
},'用户不存在');

// 自定义规则验证密码是否正确
$.validator.addMethod("pwdCheck", function(value, element) {
	var id = $('#userId').val();
	var password = $('#oldPwd').val();
	$.ajax({
		type: 'get',
		async: false,
		url: '../../../managesys/user/getUserByIdAndPwd',
		data: {
			id: id,
			password: password
		},
		success:function(data) {
			if(data == "true") {
				value = true;
			} else {
				value = false;
			}
		},
		error:function(data) {
			$.messager.alert('信息提示', '服务器不可用', 'info');
		}
	});
	return this.optional(element) || value;
},'密码不正确');

$().ready(function(){
	var id = $('#userId').val();
	var password = $('#newPwd').val();
	$('#signform').validate({
		rules:{
			userId: {
				required: true,
				idCheck: true
			},
			oldPwd: {
				required: true,	
				pwdCheck: true,
				minlength: 6,
				maxlength: 12
			},
			newPwd: {
				required: true,
				minlength: 6,
				maxlength: 12,	
				notEqualTo: "#oldPwd"
			},
			rePwd: {
				required: true,
				equalTo: "#newPwd"	
			}	
		},
		messages: {
			userId: {
				required: "该项为必填项",
				idCheck: "用户不存在"
			},
			oldPwd: {
				required: "该项为必填项",
				pwdCheck: "密码不正确",
				minlength: "密码长度不小于6",
				maxlength: "密码长度不大于12",
			},
			newPwd: {
				required: "该项为必填项",
				minlength: "密码长度不小于6",
				maxlength: "密码长度不大于12",
				notEqualTo: "新密码不能和旧密码一样"	
			},
			rePwd: {
				required: "该项为必填项",
				equalTo: "两次密码输入不一致"	
			}
		},
		submitHandler:function(form){
			$.ajax({
				type: 'post',
				async: false,
				url: '../../../managesys/user/editPassword',
				data: {
					id: id,
					password: password
				},
				success:function(data) {
					if(data == "success") {
						$.messager.alert('信息提示', '密码修改成功,请记住新密码', 'info');
					} else {
						$.messager.alert('信息提示', '密码修改失败', 'info');
					}
				},
				error:function(data) {
					$.messager.alert('信息提示', '服务器不可用', 'info');
				}
			});
		}
			
	});	
});
</script>

