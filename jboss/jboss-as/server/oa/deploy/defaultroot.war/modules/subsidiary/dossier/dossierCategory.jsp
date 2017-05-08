<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>一级类目设置列表</title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_list.jsp"%>
	<!--这里可以追加导入模块内私有的js文件或css文件-->
</head>
<%
  String userId = session.getAttribute("userId").toString();
%>
<body class="MainFrameBox">
	<s:form name="queryForm" id="queryForm" action="/dossierCategory!getList.action" method="post" theme="simple">
	<!-- SEARCH PART START -->
	<%@ include file="/public/include/form_list.jsp"%>
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="SearchBar">
        <tr>
            <td class="whir_td_searchtitle2">类目名称：</td>
            <td class="whir_td_searchinput2">
                <s:textfield id="name" name="name" cssClass="inputText" />
            </td>
            <td class="SearchBar_toolbar">
                <input type="button" class="btnButton4font"  onclick="refreshListForm('queryForm');"  value="<s:text name="comm.searchnow"/>" />
				<!--resetForm(obj)为公共方法-->
                <input type="button" class="btnButton4font" value="<s:text name="comm.clear"/>" onclick="resetForm(this);" />
            </td>
        </tr>
    </table>
	<!-- SEARCH PART END -->
    
	<!-- MIDDLE	BUTTONS	START -->
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="toolbarBottomLine">  
        <tr >
			<td align="left">
                <span id="targetFixed" style="height:20px; padding:1px;" class="target_fixed"></span>
            </td>
            <td align="right">
                <input type="button" class="btnButton4font" onclick="openWin({url:'<%=rootPath%>/dossierCategory!add.action',width:900,height:600,winName:'新增一级类目'});" value="<s:text name="comm.add"/>" />
            </td>
        </tr>
    </table>
    <!-- MIDDLE	BUTTONS	END -->
    
	<!-- LIST TITLE PART START -->	
    <table width="100%" border="0" cellpadding="1" cellspacing="1" class="listTable">
		<thead id="headerContainer">
        <tr class="listTableHead">
			<td whir-options="field:'name',width:'44%'">类目名称</td> 
			<td whir-options="field:'level',width:'4%'">级别</td> 
			<td whir-options="field:'orgName',width:'44%'">所属机构</td> 
			<td whir-options="field:'',width:'8%',renderer:myOperate">操作</td> 
        </tr>
		</thead>
		<tbody  id="itemContainer" >
		
		</tbody>
    </table>
    <!-- LIST TITLE PART END -->
    
    <!-- PAGER START -->
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="Pagebar">
        <tr>
            <td>
                <%@ include file="/public/page/pager.jsp"%>
            </td>
        </tr>
    </table>
    <!-- PAGER END -->
	</s:form>
</body>
	<script type="text/javascript">
	//*************************************下面的函数属于公共的或半自定义的*************************************************//
	
	//初始化列表页form表单,"queryForm"是表单id，可修改。
	$(document).ready(function(){
		initListFormToAjax({formId:"queryForm"});
	});
	
	//自定义操作栏内容
	function myOperate(po,i){
		var html ='';
		//if(<%=userId%> == po.createdEmp){
		   html =  '<a href="javascript:void(0)" onclick="openWin({url:\'<%=rootPath%>/dossierCategory!load.action?id='+po.id+'&verifyCode='+po.verifyCode+'\',width:900,height:600,winName:\'修改一级类目\'});"><img border="0" src="<%=rootPath%>/images/modi.gif" title="修改" ></a><a href="javascript:void(0)" onclick="deleteData('+po.id+');"><img border="0" src="<%=rootPath%>/images/del.gif" title="删除" ></a>';
		//}
		html += '&nbsp;';
		return html;
	}
	
	function deleteData(id){
	   whir_confirm("将同时删除其子类目，确认删除吗？",function(){
	       ajaxOperate({urlWithData:'<%=rootPath%>/dossierCategory!delete.action?id='+id+'',tip:'删除',isconfirm:false,formId:'queryForm',callbackfunction:null})
	   });
	}
	//*************************************下面的函数属于各个模块 完全 自定义的*************************************************//
   </script>
</html>