<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page isELIgnored ="false" %>
<%
	String local = session.getAttribute("org.apache.struts.action.LOCALE").toString();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title><%=Resource.getValue(local,"Gov","gov.jbwjcy")%></title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_list.jsp"%>
	<!--这里可以追加导入模块内私有的js文件或css文件-->
</head>

<body class="MainFrameBox">
	<!--这里的表单id queryForm 允许修改 -->
	<s:form name="queryForm" id="queryForm" action="/defaultroot/GovDocReceiveProcess!receiveFileListData.action" method="post" theme="simple">

	<!-- SEARCH PART START -->
	<%@ include file="/public/include/form_list.jsp"%>
<!-- <input type="hidden" name="receiveType"  value="<%=com.whir.component.security.crypto.EncryptUtil.htmlcode(request.getParameter("receiveType"))%>"/>
<input type=hidden  name="seqId" value="<%=com.whir.component.security.crypto.EncryptUtil.htmlcode(request.getParameter("seqId"))%>" /> -->
<input type="hidden" name="receiveType"  value="${param.receiveType}"/>
<input type=hidden  name="seqId"  value="${param.seqId}" />
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="SearchBar">  
        <tr>
            <td class="whir_td_searchtitle"  nowrap><%=Resource.getValue(local,"Gov","gov.govtitle")%>：</td>
            <td class="whir_td_searchinput">
                <s:textfield id="queryTitle" name="queryTitle" size="16" cssClass="inputText" />
            </td>
			 <td class="whir_td_searchtitle"  nowrap><%=Resource.getValue(local,"Gov","gov.textnum")%>：</td>
            <td class="whir_td_searchinput">
                <input type="text" id="topicWord" name="queryNumber" size="14" value="" class="inputText"  />
            </td>
            <td class="whir_td_searchtitle"  nowrap><%=Resource.getValue(local,"Gov","gov.blstatus")%>：</td>
            <td class="whir_td_searchinput">
                <select id="transactStatus" class="easyui-combobox" name="queryStatus" style="width:150px" >  
					<option value="">--<%=Resource.getValue(local,"common","comm.select1")%>--</option>
					<option value="0" <%if("0".equals(request.getParameter("queryStatus"))){%>selected<%}%>><%=Resource.getValue(local,"Gov","gov.blz")%> </option>
					<option value="1" <%if("1".equals(request.getParameter("queryStatus"))){%>selected<%}%>><%=Resource.getValue(local,"Gov","gov.blwb")%></option>
					<option value="2" <%if("2".equals(request.getParameter("queryStatus"))){%>selected<%}%>><%=Resource.getValue(local,"Gov","gov.tuihui")%></option></select>
					 
				</select>
            </td>
           
	
        </tr>
        <tr>
            <td class="whir_td_searchtitle" nowrap ><%=Resource.getValue(local,"Gov","gov.swdw")%>：</td>
            <td class="whir_td_searchinput">
                <input type="text" Class="inputText" name="queryReceiveFileUnit" id="queryNumber" size="16" value=""   />
            </td>
            <td class="whir_td_searchtitle" nowrap><%=Resource.getValue(local,"Gov","gov.lwdw")%>：</td>
            <td class="whir_td_searchinput">
                <input type="text" Class="inputText" id="createdOrg" name="queryComeFileUnit" size="16" value=""   />
            </td>
			<td class="whir_td_searchtitle" nowrap><%=Resource.getValue(local,"Gov","gov.lsh")%>：</td>
            <td class="whir_td_searchinput">
				 <input type="text" Class="inputText" id="zjkySeq" name="zjkySeq" size="16" value=""   />
            </td>
           
        </tr>
         <tr>
            <td class="whir_td_searchtitle" nowrap><%=Resource.getValue(local,"Gov","gov.lwrq")%>：</td>
            <td class="whir_td_searchinput" nowrap>
            
        		<!--<input type="checkbox" name="queryItem1" id="goodDay0" value="1"/>-->
				   <input name="queryBeginDate1"  id="queryBeginDate1"   class="Wdate whir_datebox"   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true,maxDate:'#F{$dp.$D(\'queryEndDate1\');}'})" /> <%=Resource.getValue(local,"Gov","gov.zhi")%>    
				   <input name="queryEndDate1" id="queryEndDate1"  class="Wdate whir_datebox"   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true,minDate:'#F{$dp.$D(\'queryBeginDate1\');}'})" />  
	        </td>


	        </td>
            <td class="whir_td_searchtitle" nowrap><%=Resource.getValue(local,"Gov","gov.blsx")%>：</td>
            <td class="whir_td_searchinput" nowrap>
            	

        		<!--<input type="checkbox" name="queryItem2" id="goodDay0" value="1"/>-->
				<input name="queryBeginDate2"  id="queryBeginDate2"   class="Wdate whir_datebox"   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true,maxDate:'#F{$dp.$D(\'queryEndDate2\');}'})" /> <%=Resource.getValue(local,"Gov","gov.zhi")%>     
				<input name="queryEndDate2" id="queryEndDate2"  class="Wdate whir_datebox"   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true,minDate:'#F{$dp.$D(\'queryBeginDate2\');}'})" />  

	        </td>
			<td colspan="2" align="right">
				<!-- refreshListForm 是公共方法，queryForm 为上面的表单id-->
                <input type="button" class="btnButton4font"  onclick="refreshListForm('queryForm');"  value="<%=Resource.getValue(local,"common","comm.searchnow")%>" />
				<!--resetForm(obj)为公共方法-->
                <input type="button" class="btnButton4font" value="<%=Resource.getValue(local,"common","comm.clear")%>" onclick="resetForm(this);" />
            </td>
        </tr>
    </table>
	<!-- SEARCH PART END -->
    
	<!-- 操作按纽栏	-->
	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="toolbarBottomLine">
	    <tr>
	        <td align="right">
	           <input name="" type="button" value="" class="btnButton4font" style="display:none"/>
			   	<input type="button" class="btnButton4font" onclick="ajaxBatchDelete('<%=rootPath%>/GovDocReceiveProcess!delBatch.action','id','id,tableId,deleTitle,isDelete',this);" value="<%=Resource.getValue(local,"common","comm.delselect")%>" />
				
			   	<input name="" type="button" value="<%=Resource.getValue(local,"common","comm.selectedExport")%>" class="btnButton4font" style="display:"  onClick="exportOut(1);"/>
	           <input name="" type="button" value="<%=Resource.getValue(local,"Gov","gov.export")%>" class="btnButton4font" style="display:"  onClick="exportOut(0);"/>
	        </td>
	    </tr>
	</table>
	
	<!-- LIST TITLE PART START -->	
    <table width="100%" border="0" cellpadding="1" cellspacing="1" class="listTable">
		<!-- thead必须存在且id必须为headerContainer -->
		<thead id="headerContainer">
        <tr class="listTableHead">
			<td whir-options="field:'id',width:'2%',checkbox:true,renderer:generateCHBX" ><input type="checkbox" name="items" id="items" onclick="setCheckBoxState('id',this.checked);" ></td>


			<td whir-options="field:'zjkySeq',width:'16%'" ><%=Resource.getValue(local,"Gov","gov.lsh")%></td>
			<td whir-options="field:'orgName',width:'11%'"><%=Resource.getValue(local,"Gov","gov.swdw")%></td> 
			
			<td whir-options="field:'receiveFileSendFileUnit',width:'12%'"><%=Resource.getValue(local,"Gov","gov.lwdw")%></td> 
			<td whir-options="field:'receiveFileReceiveDate', width:'8%',renderer:common_DateFormat"><%=Resource.getValue(local,"Gov","gov.lwrq")%></td> 
			<td whir-options="field:'receiveFileFileNumber', width:'10%'"><%=Resource.getValue(local,"Gov","gov.textnum")%></td>   
			<td whir-options="field:'receiveFileTitle', width:'20%',renderer:show"><%=Resource.getValue(local,"Gov","gov.govtitle")%></td> 
			<td whir-options="field:'receiveFileStatus',width:'5%',renderer:getStatus"><%=Resource.getValue(local,"Gov","gov.blstatus")%></td> 
			<td whir-options="field:'transactStatus',width:'8%',renderer:myOperate"><%=Resource.getValue(local,"common","comm.opr")%></td> 
        </tr>
		</thead>
		<!-- tbody必须存在且id必须为itemContainer -->
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
		
	function exportOut(flag){
		/*var $form = $('#exportForm');
		if ($form.length > 0) {
			$form.remove();//去除前一次导出时的form
		}*/
	 
		var ids = '';
		if(flag == '1'){
			ids = getCheckBoxData4J({rangeId:'queryForm', checkbox_name:'id', attr_name:'id'});
			if(ids == ''){
				whir_alert('<%=Resource.getValue(local,"Gov","gov.qxzydcjl")%> ', null);
				return;
			}
		}
	 
		var params = '?selectIds='+ids+'&exportData=1&exportTitle=收文管理-办理查阅导出';
	 
		commonExportExcel({formId:'queryForm', action:'/defaultroot/GovDocReceiveProcess!export.action'+params});
	}
	//*************************************下面的函数属于公共的或半自定义的*************************************************//

	//初始化列表页form表单,"queryForm"是表单id，可修改。
	$(document).ready(function(){		
		initListFormToAjax({formId:'queryForm'});		

	});
	


	//自定义查看栏内容
	function show1(po,i){
		var html =  '<a href="javascript:void(0)" onclick="openWin({url:\'GovDocReceiveProcess!showfile.action?from=blcyview&p_wf_openType=modifyView&p_wf_tableId='+po.tableId+'&p_wf_recordId='+po.id+'\',width:620,height:290,isResizable: true,isFull: true,winName:\'21212\'});">'+po.receiveFileTitle+'</a>';
		return html;
	}

	//获取标题
	function show(po,i){
		var title = po.receiveFileTitle;
		title = title.replace(">","&gt");
		title = title.replace("<","&lt");
		var xgsw = "";
		if(po.countNum>0){
			xgsw = "<a href=\"#\" onclick= \"javascript:getAssociate("+po.tableId+","+po.id+",'"+po.receiveFileTitle+"')\"><font color=\"red\">[相关发文]</font></a>";
		}
		var html =  '<a href="javascript:void(0)" onclick="openWin({url:\'GovDocReceiveProcess!editfile.action?from=blcyview&p_wf_openType=modifyView&p_wf_tableId='+po.tableId+'&p_wf_recordId='+po.id+'\',width:620,height:290,isResizable: true,isFull: true,winName:\'21212\'});">'+po.receiveFileTitle+'</a>'+xgsw;

		return html;
	}

	//function moder(editId,editType,tableId,isBack) {
	function getAssociate(tableId,sendFileId,filetitle){
		openWin({url:'GovDocReceiveProcess!receiveAssociate.action?winOpen=1&receiveFileId=' + sendFileId+'&filetitle='+filetitle,width:620,isFull: true,height:290,winName:'getAssociateWin'});
		//MM_openBrWindow("GovSendFileAction.do?action=sendAssociate&winOpen=1&sendFileId=" + sendFileId+"&filetitle="+filetitle,'','TOP=0,LEFT=0,scrollbars=yes,resizable=yes,width=600,height=300') ;
	}



	
	//导出
	function exportExcel() {
		queryForm.action="GovDocReceiveProcess!export.action";
		queryForm.target = "_blank";
		queryForm.submit();
		queryForm.action="GovDocReceiveProcess!receiveFileListData.action";
	}
	
	//自定义操作栏内容
	function myOperate(po,i){
	var defendRight = getIsDelete(po,i);
		
	//	alert(po.receiveFileStatus);
		var html =  '<a href="javascript:void(0)" onclick="openWin({url:\'GovDocReceiveProcess!editfile.action?from=blcyedit&workStatus=1&isEdit=1&p_wf_tableId='+po.tableId+'&p_wf_openType=modifyView&p_wf_recordId='+po.id+'\',isFull: true,width:620,height:290,winName:\'showUser\'});"><img border="0" src="<%=rootPath%>/images/modi.gif" title="<%=Resource.getValue(local,"common","comm.supdate")%>" ></a><a href="javascript:void(0)" onclick="ajaxDelete(\'GovDocReceiveProcess!delBatch.action?p_wf_tableId='+po.tableId+'&deleTitle='+encodeURIComponent(po.receiveFileTitle)+'&p_wf_recordId='+po.id+'\',this);"><img border="0" src="<%=rootPath%>/images/del.gif" title="<%=Resource.getValue(local,"common","comm.sdel")%>" ></a>';
		//if(po.isSyncToInfomation == "1"){
		//	html += '<img border="0" src="<%=rootPath%>/images/changePwd.gif" alt="同步到信息管理" ></a>';
		//}
		//if(po.isSyncToInfomation != "1"){
		//	html += '<a href="javascript:void(0)" onclick="InfoSynchronization(\''+po.id+'\',\''+po.receiveFileFileNumber+'\',\''+po.receiveFileTitle+'\',\''+''+'\',\''+ po.createdEmp+'\',\'\',\'\');"><img border="0" src="<%=rootPath%>/images/changePwd.gif" alt="同步到信息管理" ></a>';
		//}
									 if(po.receiveFileStatus== null){
                                   		
                                     }else if(po.receiveFileStatus==0){
                                        html += '<a href="javascript:void(0)" onclick="qzjs(\''+po.id+'\',\''+po.tableId+'\');"><img border="0" src="<%=rootPath%>/images/cxtj.gif" alt="<%=Resource.getValue(local,"common","comm.qzjs")%>"  title="<%=Resource.getValue(local,"common","comm.qzjs")%>"></a>';
                                     }else if(po.receiveFileStatus==1){
                                    	 //out.print("&nbsp;");
                                         //out.print("办理完毕");
                                     }else if(po.receiveFileStatus==2){
                                        // out.print("退回");
										 html += '<a href="javascript:void(0)" onclick="qzjs(\''+po.id+'\',\''+po.tableId+'\');"><img border="0" src="<%=rootPath%>/images/cxtj.gif" alt="<%=Resource.getValue(local,"common","comm.qzjs")%>"  title="<%=Resource.getValue(local,"common","comm.qzjs")%>"></a>';
                                     }else{
                                     	//out.print("&nbsp;");
                                     }
		//html+='<img border="0" src="<%=rootPath%>/images/cxtj.gif" alt="强制结束" ></a>';
		if(defendRight){
			return html;
		}else{
			return "&nbsp;";
		}
	}
		//强制结束
	function qzjs(recordId,tableId){
		//alert("该功能尚未实现。");
		//if(confirm('确定强制结束吗?')) {
			//document.all.qzjs.src="/defaultroot/work_flow/workflow_qzjs.jsp?workId="+workId+"&recordId="+recordId+"&processId="+processId+"&tableId="+tableId;
			//location.reload();
			//window.location.href
			//document.all.qzjs.src="/defaultroot/govezoffice/gov_documentmanager/govdocumentmanager_qzjs.jsp?recordId="+recordId+"&tableId="+tableId;
			
			//searcher();
		//}

		 ajaxOperate( {
			urlWithData: '/defaultroot/modules/govoffice/gov_documentmanager/govdocumentmanager_qzjs.jsp?module=receive&recordId='+recordId+'&tableId='+tableId, // 业务访问的url地址：带数据.
			tip:'<%=Resource.getValue(local,"common","comm.qzjs")%> ', // 提示.
			isconfirm:true , // 是否需要确认提示.
			formId:'queryForm' , // 待刷新列表的表单id.
			callbackfunction:null // 回调函数.
		});

   


	}

	//*************************************下面的函数属于各个模块 完全 自定义的*************************************************//

	function getStatus(po,i){
		if(po.receiveFileStatus == "0"){
			return "<%=Resource.getValue(local,"Gov","gov.blz")%> ";
		}
		if(po.receiveFileStatus == "1"){
			return "<%=Resource.getValue(local,"Gov","gov.blwb")%> ";
		}
		if(po.receiveFileStatus == "2"){
			return "<%=Resource.getValue(local,"Gov","gov.tuihui")%> ";
		}
	}

  
//查询
function InfoSynchronization(id,o1,o2,o3,o4,o5,o6){
	//var srcurl="InformationAction.do?action=otherAdd&channelType=0&_type=4&userDefine=0&_fileId="+id;
	var srcurl="/defaultroot/Information!add.action?module=1&action=otherAdd&channelType=0&_type=4&userDefine=0&_fileId="+id;

	if(o1!=""&&o1!="null"){
		srcurl+="&_docNO="+o1;
	}
	if(o2!=""){
		srcurl+="&_title="+o2;
	}
	if(o3!=""&&o3!="null"){
		srcurl+="&_content="+o3;
	}
	if(o4!=""&&o4!="null"){
		srcurl+="&_author="+o4;
	}
	if(o5!=""&&o5!="null"){
		srcurl+="&_accessName="+o5;
	}
	if(o6!=""&&o6!="null"){
		srcurl+="&_accessSaveName="+o6;
	}
	openWin({url:srcurl,width:620,height:350,isFull:true,winName:'_blank'});
	//postWindowOpen(srcurl,'','TOP=0,LEFT=0,scrollbars=yes,resizable=yes,width=800,height=600');
}

	//自定义操作栏内容
	function generateCHBX(po,i){
		var isDelete = getIsDelete(po,i);
		var html = 'tableId="'+ po.tableId + '"' + ' deleTitle="'+encodeURIComponent(po.receiveFileTitle) + '"' + ' isDelete= "'+isDelete+'"';
		if(!isDelete){
			html = html + ' disabled = "true"  '; 			
		}
		return html;
	}
	//获取是否有权限显示按钮
	function getIsDelete(po,i){

		var defendScopeType =("${request.defendScopeType}");

		var defendRight = false;
		if( "${session.userId}" == po.createdEmp){
			//alert(1);
			defendRight = true;
		}else if( "${session.orgId}" == po.documentSendFileWriteOrg){
			//alert(11);
			defendRight = true;
		}else if( po.orgIdString.indexOf("$${session.orgId}$") >=0 ){
			//alert(111+""+ po.orgIdString);
			defendRight = true;
		}else if( "${request.defendOrgRange}".indexOf(",${session.orgId},") >= 0){
			//alert(1111);
			defendRight = true;
		}
		defendRight = false;
		if( defendScopeType == "0"){
			defendRight = true;
		}else if( defendScopeType == "1"){
			if( "${session.userId}" == po.createdEmp){
				//alert(1);
				defendRight = true;
			}
		}else if( defendScopeType == "3"){
			if( po.createdOrg == ${session.orgId} ){
				//alert(111+""+ po.orgIdString);
				defendRight = true;
			}
		}else if( defendScopeType == "2"){
			if( "${request.defendOrgRange}".indexOf(","+po.createdOrg+",") >= 0){
				//alert(1111);
				defendRight = true;
			}
		}else if( defendScopeType == "4"){
			//alert("${request.defendOrgRange}" + "--------" +"${request.userRange}" );
			if( "${request.defendOrgRange}".indexOf(","+po.createdOrg+",") >= 0 ||  "${request.userRange}".indexOf("$"+po.createdEmp+"$") >= 0){
				//alert(1111);
				defendRight = true;
			}
		}
		return defendRight;	
	}
   </script>

</html>


