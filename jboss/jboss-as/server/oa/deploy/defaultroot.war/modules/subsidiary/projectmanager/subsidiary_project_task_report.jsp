<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>  
<%@ page language="java" import="java.util.*" %>
<%@ page isELIgnored ="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
	<title>任务汇报</title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_list.jsp"%>
	<!--这里可以追加导入模块内私有的js文件或css文件-->
	<style type="text/css">
	body,div {
	}
	.divBackgroundColor {
		background: #f7f7f7;
	}
	td {
		padding-left:10px;
	}
	table {
		border-color: #e7e7e7;
		border-style: solid;
	}
	.reportToolbarTable {
	    border-width: 1px;
	    padding: 3px 5px 3px 0px;
	}
	.reportListTable {
	    border-left-width: 1px;
	    border-right-width: 1px;
	    border-bottom-width: 1px;
	}
	</style>
</head>
<script>
function iframeResizeHeight(frame_name,body_name,offset) {
	parent.document.getElementById(frame_name).height=document.getElementById(body_name).scrollHeight+offset;
}

function Resize(){
 	var frame_name="reportIframe";
 	var body_name="main";
 	if(parent.document.getElementById(frame_name)){
  		return iframeResizeHeight(frame_name,body_name,0);
 	}
}
</script>
<body onload="Resize();">
<div id="main" class="divBackgroundColor">
	<s:form name="queryForm" id="queryForm" action="projectTask!projectTaskReport.action" method="post" theme="simple">
		<s:hidden id="taskId" name="taskId" value="%{taskPO.taskId}"/>
		<!-- SEARCH PART START -->  
	    <%@ include file="/public/include/form_list.jsp"%>  
	    <!-- MIDDLE  BUTTONS START -->  
	   	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="reportToolbarTable">     
	        <tr>  
	        	<td align="left">
	        		任务汇报<span class="MustFillColor">(<s:property value="#request.taskReportList.size" default="0"/>)</span>
	        		<%if(!("1".equals(request.getParameter("isView")))){ %>
	                 <input type="button" class="btnButton4font" onclick="addTaskReport('<s:property value="%{taskPO.taskId}"/>','<s:property value="%{taskPO.taskStatus}"/>','<s:property value="%{taskPO.isArranged}"/>','<s:property value="%{taskPO.taskFinishRate}"/>')" value="新　建" />
	        	     <%} %>
	               
	            </td>  
	        </tr>  
	    </table>  
	    <!-- MIDDLE  BUTTONS END --> 
	    
	    <!-- LIST TITLE PART START -->       
	    <table width="100%" border="0" cellpadding="0" cellspacing="1" class="reportListTable">  
	        <!-- thead必须存在且id必须为headerContainer -->  
			<% int tag= 0;%>
	        <s:iterator value="#request.taskReportList" status="status">
	        	<tr bgcolor="#CCCCCC">
	        		<td height="23" style="border-right:0px">
	        			<s:property value="empName"/>&nbsp;&nbsp;于&nbsp;&nbsp;<s:date name="reportTime" format="yyyy-MM-dd HH:mm:ss" />&nbsp;&nbsp;
			        	<s:if test='finishRate != null && !"".equals(finishRate)'>
			        		<font color="red">完成：<s:property value="finishRate"/>%</font>
			        	</s:if>
			        	<s:else>
			        		&nbsp;
			        	</s:else>
	        		</td>
	        	</tr>
	        	<tr bgcolor="#FFFFFF">
					<td height="20" colspan="4" style="border-right:0px">
						内容：<s:property value="reportInfo"/>
					</td>
				</tr>
				 <% List list = (List)request.getAttribute("reportAccessoryList"+tag);	
		 
					String str1="";
					String str2="";
				    if(list.size()>0){
					for(int j =0;j<list.size();j++){
					     Object[] objs = (Object[])list.get(j);
						  str1=str1+objs[0]+"|";
						  str2=str2+objs[1]+"|";
						  
					}
					 str1 = str1.substring(0,str1.length()-1);
					 str2 = str2.substring(0,str2.length()-1);

					String ss1 = "realFileName"+tag;
					String ss2 = "saveFileName"+tag;
					String uniqueId="uniqueId"+tag;
				  %>
					<tr>
						<td height="20" colspan="4" style="border-right:0px">							
							<input type="hidden" name="<%=ss1%>" id="<%=ss1%>" value="<%=str1 %>" />  
							<input type="hidden" name="<%=ss2%>" id="<%=ss2%>" value="<%=str2 %>" />  
						   	<jsp:include page="/public/upload/uploadify/upload_include.jsp" flush="true">   
							   <jsp:param name="accessType"       value="include" />
							   <jsp:param name="dir"      value="taskCenter" />  
							   <jsp:param name="uniqueId"    value="<%=uniqueId%>" />  
							   <jsp:param name="realFileNameInputId"    value="<%=ss1%>" />
							   <jsp:param name="saveFileNameInputId"    value="<%=ss2%>" />
							   <jsp:param name="canModify"       value="no" />
							</jsp:include>
						</td>
						<style type="text/css">
                     body{margin-top:0px;}
                </style>
					</tr>
					<%}%>
			
			<%tag=tag+1;%>
	        </s:iterator>
	       
	    </table>  
	    <!-- LIST TITLE PART END -->  
	</s:form>
	</div>
</body>

<script type="text/javascript">
	//初始化列表页form表单,"queryForm"是表单id，可修改。   
    //$(document).ready(function(){ 
      //  initListFormToAjax({formId:"queryForm"});          
    //});  
    function addTaskReport(taskId, taskStatus, isArranged, taskFinishRate) {
		var preTaskName = "${preTaskName}";
		if(preTaskName == "") {
			var reportUrl = "<%=rootPath%>/taskCenter!taskReportView.action?taskId=" + taskId + "&taskStatus=" + taskStatus + "&isArranged=" + isArranged + "&taskFinishRate=" + taskFinishRate;
			/* Added by Qian Min for bug 12145 [BEGIN] */
			// 注：为"刷新父页面"而添加，我就不懂了。。。
			reportUrl += '&reportPlace=1';
			/* Added by Qian Min for bug 12145 [END] */
			openWin({url:reportUrl,width:800,height:600,winName:'taskReportView'});
		} else {
			whir_alert("前驱任务" + preTaskName + "未完成。",null);
		}
	}
	
	
$(window.parent.document).find("#reportIframe").load(function () {
    var main = $(window.parent.document).find("#reportIframe");
    var thisheight = $(document).height() + 120;
    main.height(thisheight);
});
</script>

</html>



