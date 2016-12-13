<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	table{
		width:500px;
		align:right;
	}
</style>
<!--<script type="text/javascript" src="jquery-2.1.4.js"></script>-->
<script type="text/javascript">
	/*$(document).ready(function(){
		//???????class=left??????????12px
		$(".left").css("box-shadow","insert");
		//????????input????
		$("input").css("border","dashed 1px #000000");
		//ID??????id=message????????
		$("#message").css("border","dotted 1px #000000");
		//??????
		$("*").css("font-size","12px");
		//??$("span,legend")??<span><legend>????
		$("span,legend").css("color",#f33);
		//?????,??name????hobby?????????checked??
		$("input[name='hobby']").attr("checked",true);
	});*/
		//????
	function checkGender()
	{
		var genderNum=document.getElementByName("gender");
		var gender="";
		for(var i=0;i<genderNum.length;++i)
		{
			//gender???
			if(genderNum[i].checked)
			gender=genderNum[i].value;
		}
		if(gender=="")
		{
			document.getElementById("tips_gender").innerHTML="<em  style='color:#ff0000'>????????</em>";
			return false;
		}
		else
		{
			document.getElementById("tips_gender").innerHTML="OK";
		}
	}
	function checkForm()
	{	
		if(document.getElementById("txtUser").value.length<6||document.getElementById("txtUser").value.length>18)
		{
			document.getElementById("tips_username").innerHTML="<em  style='color:#ff0000'>????6-18?????</em>";
			document.getElementById("txtUser").focus();
			return false;
		}
		else
		{
			document.getElementById("tips_username").innerHTML="OK";
		}		
		//?????
		var reg=/[^A-Za-z0-9_]+/;
		var regs= /^[a-zA-Z0-9_\u4e00-\u9fa5]+$/;
		if(document.getElementById("txtPwd").value.length<6||document.getElementById("txtPwd").value.length>18||regs.test(document.getElementById("txtPwd").value))
		{
			document.getElementById("tips_password").innerHTML="<em  style='color:#ff0000'>???6-18????????????????????</em>";
			document.getElementById("txtPwd").focus();
			return false;
		}
		else
		{
			document.getElementById("tips_password").innerHTML="OK";
		}		
		if(document.getElementById("txtRpt").value!=document.getElementById("txtPwd").value)
		{
			document.getElementById("tips_repeat").innerHTML="<em  style='color:#ff0000'>???????</em>";
			document.getElementById("txtRpt").focus();
			return false;
		}
		else
		{
			document.getElementById("tips_repeat").innerHTML="OK";
		}		
		//??????
		if(document.getElementById("selUser").selectedIndex==0)
		{
			document.getElementById("tips_usertype").innerHTML="<em  style='color:#ff0000'>????????</em>";
			document.getElementById("selUser").focus();
			return false;
		}
		else
		{
			document.getElementById("tips_usertype").innerHTML="OK";
		}
		//??????
		if(document.getElementById("txtDate").value=="")
		{
			document.getElementById("tips_birthdate").innerHTML="<em  style='color:#ff0000'>????????</em>";
			document.getElementById("txtDate").focus();
			return false;
		}
		else
		{
			document.getElementById("tips_birthdate").innerHTML="OK";
		}
		
		
		//    email
		var email=document.getElementById("txtMail").value;
		var pattern=/^[a-zA-Z0-9#_\^\$\.\*\+\-\?\=\!\:\|\\\/\(\)\[\]\{\}]+@[a-zA-Z0-9]+((\.[a-zA-Z0-9_-]{2,3}){1,2})$/;
		if(email.length==0)
		{
			document.getElementById("tips_email").innerHTML="<em style='color:#ff0000'>??????</em>";
			document.getElementById("txtMail").focus();
			return false;
		}
		else if(!pattern.test(mail))
		{
			document.getElementById("tips_email").innerHTML="<em style='color:#ff0000'>email???</em>";
			document.getElementById("txtMail").focus();
			return false;
		}
		else
		{
			document.getElementById("tips_email").innerHTML="OK";
		}
		//??????
		if(document.getElementById("txtIntro").value.length>100)
		{
			document.getElementById("tips_introduction").innerHTML="<em  style='color:#ff0000'>??????100??</em>";
			document.getElementById("txtIntro").focus();
			return false;
		}
		else
		{
			document.getElementById("tips_introduction").innerHTML="OK";
		}
	}
	//??
	function changeHobby()
	{
		var hobby=0;
		var objNum=document.getElementByName("hobby");
		for(var i=0;i<objNum.length;++i)
		{
			//??hobby?????
			if(objNum[i].checked==true)
				hobby++;
		}
		if(hobby>=1)
		{
			document.getElementById("tips_hobby").innerHTML="OK";
		}
		else
		{
			document.getElementById("tips_hobby").innerHTML="<em  style='color:#ff0000'>??????</em>";
			return false;
		}
	}
</script>
</head>
<body>
<form action="#" method="post" id="myform">
<fieldset>
	<legend>????</legend>
	<table>
		<!-- ??? -->
		<tr>
			<td>???</td>
			<td><input name="username" type="text" id="txtUser" onBlur="return checkForm()"></td>
			<td><span id="tips_username">*????6-18?????</span></td>
		</tr>
		<!-- ?? -->
		<tr>	
			<td>??</td>
			<td><input name="password" type="password" id="txtPwd" onBlur="return checkForm()"></td>
			<td><span id="tips_password">*???6-18?????,?????????????</span></td>
		</tr>
		<!-- ???? -->	
		<tr>
			<td>????</td>
			<td><input type="password" name="repeat" id="txtRpt" onBlur="return checkForm()"></td>
			<td><span id="tips_repeat"></span></td>
		</tr>
		<!-- ???? -->	
		<tr>
			<td>????</td>
			<td>
				<select name="usertype" id="selUser" onBlur="return checkForm()">
					<option value="0">?????</option>
					<option value="1">???</option>
					<option value="2">??</option>
				</select> 
			</td>
			<td><span id="tips_usertype">*???????</span></td>
		</tr>
		<!-- ????-->
		<tr>
			<td>??</td>
			<td>
				?:<input type="radio" name="gender" id="tips_gender" onBlur="return checkGender()">
				?:<input type="radio" name="gender" id="tips_gender" onBlur="return checkGender()">
			</td>
			<td><span id="tips_gender"></span></td>
		</tr>
		<!-- ????-->	
		<tr>
			<td>????</td>
			<td><input type="date" name="birthdate" id="txtDate" onBlur="return checkForm()"></td>
			<td><span id="tips_birthdate">*?????????</span></td>
		</tr>
		<!-- ????-->		
		<tr>
			<td>????</td>
			<td>
				<input type="checkbox" name="hobby" id="hobby"  value="reading" onBlur="return changeHobby()">??
				<input type="checkbox" name="hobby" id="hobby"  value="running" onBlur="return changeHobby()">??
				<input type="checkbox" name="hobby" id="hobby"  value="music" onBlur="return changeHobby()">??
			</td>
			<td><span id="tips_hobby">*???????</span></td>
		</tr>
		<!-- ????-->
		<tr>
			<td>????</td>
			<td><input type="email" name="email" id="txtMail" onBlur="return checkForm()"></td>
			<td><span id="tips_email">*???????</span></td>
		</tr>
		<!-- ????-->
		<tr>
			<td>????</td>
			<td><textarea name="introduction" id="txtIntro" onBlur="return checkForm()" rows="5"></textarea></td>
			<td><span id="tips_introduction">*100???</span></td>
		</tr>
		<tr align="center">
			<td>
				<input type="submit" name="submit" value="??">
				<input type="reset" name="reset" value="??">
			</td>
		</tr>
	</table>
</fieldset>
</form>
</body>
</html>