<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>工作汇报-通用-列表页面</title>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
    <%@ include file="/public/include/meta_base.jsp"%>
    <%@ include file="/public/include/meta_list.jsp"%>
    <!--这里可以追加导入模块内私有的js文件或css文件-->
    <!-- 人员浮动卡片 [BEGIN] -->
    <script src="<%=rootPath%>/scripts/main/whir.userInfo.card.js" language="javascript"></script>
    <style type="text/css">   
        .trigger1:hover{color:red}   
    </style>
    <!-- 人员浮动卡片 [END] -->
    
    <script src="<%=rootPath%>/modules/personal/workreport/workreport_common_js.js" type="text/javascript"></script>
    <script src="<%=rootPath%>/modules/personal/workreport/workreport_common_list_js.js" type="text/javascript"></script>
    <script src="<%=rootPath%>/scripts/i18n/<%=whir_locale%>/PersonalworkResource.js" type="text/javascript"></script>
</head>

<body class="MainFrameBox">
    <s:form name="queryForm" id="queryForm" action="${ctx}/WorkReportAction!list.action" method="post" theme="simple">
    
    <s:hidden name="menuType" id="menuType" value="%{menuType}" />  
    <s:hidden name="reportType" id="reportType" value="%{reportType}" />  
    <s:hidden name="projectId" id="projectId" value="%{projectId}" />  
    <!-- SEARCH PART START -->
    <%@ include file="/public/include/form_list.jsp"%>
    
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="SearchBar">
        <tr>
        <s:if test="#request.menuType=='mine'">
            <td class="whir_td_searchtitle"><s:text name="workreport.status" />：</td>
            <td class="whir_td_searchinput">
                <select name="queryReportSendType" id="queryReportSendType" class="easyui-combobox" style="width:100px;" data-options="panelHeight:'auto',  selectOnFocus:true">
                    <option value="">--<s:text name="innercontact.select"/>--</option>
                    <option value="0"><s:text name="workreport.draft" /></option>
                    <option value="1"><s:text name="workreport.alreadysend" /></option>
                </select>
            </td>
        </s:if>
        <s:else>
            <td class="whir_td_searchtitle"><s:text name="workreport.year"/></td>
            <td class="whir_td_searchinput" >
                <input name="queryReportYear" id="queryReportYear" class="easyui-combobox" style="width:100px;" data-options="
                            url:'modules/personal/workreport/combobox_time_year.json',
                            valueField: 'id',
                            textField: 'text'
                        ">
            </td>
        </s:else>
        <s:if test="#request.reportType=='week' || #request.reportType=='month' || #request.reportType=='projectRep' || #request.reportType=='newReport'">
            <td class="whir_td_searchtitle"><s:text name="workreport.reportduration" />：</td>
            <td class="whir_td_searchinput">
                <s:textfield id="queryReportCourse" name="queryReportCourse" size="16" cssClass="inputText" />
            </td>
        </s:if>
        <s:else>
            <td class="whir_td_searchtitle"><s:text name="workreport.title" />：</td>
            <td class="whir_td_searchinput">
                <s:textfield id="queryReportTitle" name="queryReportTitle" size="16" cssClass="inputText" />
            </td>
        </s:else>
            <td class="whir_td_searchtitle"><s:text name="workreport.reportcontent" />：</td>
            <td class="whir_td_searchinput">
                <s:textfield id="queryReportContent" name="queryReportContent" size="16" cssClass="inputText" />
            </td>
        </tr>
        <s:if test="#request.menuType=='underling' || #request.menuType=='query'">
        <tr>
            <td class="whir_td_searchtitle"><s:text name="workreport.fill" />：</td>
            <td class="whir_td_searchinput">
                <s:hidden name="queryReportEmpId" id="queryReportEmpId" />
                <s:textfield name="queryReportEmpName" id="queryReportEmpName" size="16" cssClass="inputText" readonly="true" /><a href="javascript:void(0);" class="selectIco" onclick="openSelect({allowId:'queryReportEmpId', allowName:'queryReportEmpName', select:'user', single:'yes', show:'user', range:'*0*'});"></a>
            </td>
            <td class="whir_td_searchtitle"><s:text name="workreport.department" />：</td>
            <td class="whir_td_searchinput">
                <s:hidden name="queryReportOrgId" id="queryReportOrgId" />
                <s:textfield name="queryReportOrgName" id="queryReportOrgName" size="16" cssClass="inputText" readonly="true" /><a href="javascript:void(0);" class="selectIco" onclick="openSelect({allowId:'queryReportOrgId', allowName:'queryReportOrgName', select:'org', single:'yes', show:'org', range:'*0*'});"></a>
            </td>
            <td class="whir_td_searchtitle"><s:text name="workreport.duty" />：</td>
            <td class="whir_td_searchinput">
                <s:textfield name="queryReportDuty" id="queryReportDuty" size="16" cssClass="inputText" />
            </td>
        </tr>
        </s:if>
        <tr>
            <td class="whir_td_searchtitle"><s:text name="workreport.reportdate" />：</td>
            <td class="whir_td_searchinput" nowrap>
                <input type="text" class="Wdate whir_datebox" name="queryByTimeFrom" id="queryByTimeFrom" value="" onfocus="WdatePicker({el:'queryByTimeFrom',isShowWeek:false, isShowClear:true, readOnly:true,maxDate:'#F{$dp.$D(\'queryByTimeTo\')}'})"/>  
                <s:text name="workreport.to" />
                <input type="text" class="Wdate whir_datebox" name="queryByTimeTo" id="queryByTimeTo" value="" onfocus="WdatePicker({el:'queryByTimeTo',isShowWeek:false, isShowClear:true, readOnly:true, minDate:'#F{$dp.$D(\'queryByTimeFrom\')}'})"/>
            </td>
        <s:if test="#request.menuType=='query'">
            <td class="whir_td_searchtitle"><s:text name="workreport.subto" />：</td>
            <td class="whir_td_searchinput">
                <s:hidden name="queryReportReaderId" id="queryReportReaderId" />
                <s:textfield name="queryReportReaderName" id="queryReportReaderName" size="16" cssClass="inputText" readonly="true" /><a href="javascript:void(0);" class="selectIco" onclick="openSelect({allowId:'queryReportReaderId', allowName:'queryReportReaderName', select:'user', single:'yes', show:'user', range:'*0*'});"></a>
            </td>
        </s:if>
        <s:if test="#request.reportType=='other'">
            <td class="whir_td_searchtitle"><s:text name="workreport.type" />：</td>
            <td class="whir_td_searchinput">
                <select name="queryReportType" id="queryReportType" class="easyui-combobox" style="width:100px;" data-options="panelHeight:'auto',  selectOnFocus:true">
                    <option value="">--<s:text name="workreport.all" />--</option>
                    <option value="0"><s:text name="workreport.everyday" /></option>
                    <option value="2"><s:text name="workreport.everyhalfmonth" /></option>
                    <option value="4"><s:text name="workreport.everyquarter" /></option>
                    <option value="5"><s:text name="workreport.everyhalfyear" /></option>
                    <option value="6"><s:text name="workreport.everyyear" /></option>
                    <option value="7"><s:text name="workreport.temporary" /></option>
                </select>
            </td>
        </s:if>
        <s:else>
            <s:if test="#request.menuType=='mine' || #request.menuType=='underling'">
            <td class="whir_td_searchtitle">&nbsp;</td>
            <td class="whir_td_searchinput">&nbsp;</td>
            </s:if>
        </s:else>
        <s:if test="#request.menuType=='query' && #request.reportType=='other'">
        </tr>
        <tr>
            <td class="SearchBar_toolbar" colspan="6">
        </s:if>
        <s:else>
            <td class="SearchBar_toolbar" colspan="2">
        </s:else>
                <input type="button" class="btnButton4font"  onclick="refreshListForm('queryForm');"  value='<s:text name="comm.searchnow"/>' />
                <!--resetForm(obj)为公共方法-->
                <input type="button" class="btnButton4font" value='<s:text name="comm.clear"/>' onclick="resetForm(this);" />
            </td>
        </tr>
    </table>
    <!-- SEARCH PART END -->
    
    <!-- MIDDLE BUTTONS START -->
   <table width="100%" border="0" cellpadding="0" cellspacing="0" class="toolbarBottomLine">  
        <tr >
            <td align="right">
            <s:if test="#request.menuType=='mine'">
                <s:if test="#request.projectId != null">
                <input type="button" class="btnButton4font" onclick="location_href('<%=rootPath%>/WorkReportAction!listProj.action?menuType=mine')" value='<s:text name="myworklog.back"/>' />
                </s:if>
                <input type="button" class="btnButton4font" onclick="addWorkReport();" value='<s:text name="comm.add"/>' />
                <input type="button" class="btnButton4font" onclick="batchDelMineReport();" value='<s:text name="comm.delselect"/>' />
            </s:if>
            <s:if test="#request.menuType=='underling'">
                <s:if test="#request.projectId != null">
                <input type="button" class="btnButton4font" onclick="location_href('<%=rootPath%>/WorkReportAction!listProj.action?menuType=underling')" value='<s:text name="myworklog.back"/>' />
                </s:if>
                <input type="button" class="btnButton4font" onclick="batchViewUnderlingReport();" value='<s:text name="workreport.Batchview"/>' />
                <input type="button" class="btnButton4font" onclick="batchDelUnderlingReport();" value='<s:text name="comm.delselect"/>' />
            </s:if>
            <%
                if (isForbiddenPad) {
                    // "部门月绩效汇总"、"公司即系汇总"按钮在IPAD上不显示
                    // Added by Qian Min for ezOFFICE 11.0.0.11 at 2013-10-14 
            %>
                    <s:if test="#request.performanceSummaryOfOrg=='true'">
                        <input type="button" class="btnButton8font" onclick="performanceSummary('org');" value='<s:text name="workreport.depeffect"/>' />
                    </s:if>
                    <s:if test="#request.performanceSummaryOfCom=='true'">
                        <input type="button" class="btnButton8font" onclick="performanceSummary('com');" value='<s:text name="workreport.companyeffect"/>' />
                    </s:if>
            <%
                }
            %>
            </td>
        </tr>
    </table>
    <!-- MIDDLE BUTTONS END -->

    <!-- LIST PART START -->    
    <table width="100%" border="0" cellpadding="1" cellspacing="1" class="listTable">
        <thead id="headerContainer">
            <tr class="listTableHead">
            <s:if test="#request.menuType=='mine'">
                <td whir-options="field:'workReportId', width:'2%', checkbox:true, renderer:showCheckBox" >
                    <input type="checkbox" name="items" id="items" onclick="setCheckBoxState('workReportId',this.checked);" >
                </td>
                <td whir-options="field:'', width:'6%', renderer:showSendType"><s:text name="workreport.status" /></td> 
            </s:if>
            <s:if test="#request.menuType=='underling'">
                <td whir-options="field:'workReportId', width:'2%', checkbox:true" >
                    <input type="checkbox" name="items" id="items" onclick="setCheckBoxState('workReportId',this.checked);" >
                </td>
                <td whir-options="field:'', width:'5%', renderer:showIHadRead"><s:text name="workreport.status" /></td> 
                <td whir-options="field:'reportEmpName', width:'6%', renderer:showReportEmp"><s:text name="workreport.fill" /></td> 
            </s:if>
            <s:if test="#request.menuType=='query'">
                <td whir-options="field:'reportEmpName', width:'6%', renderer:showReportEmp"><s:text name="workreport.fill" /></td> 
            </s:if>
            
            <s:if test="#request.reportType=='other'">
                <s:if test="#request.menuType=='underling'">
                <td whir-options="field:'', width:'20%', renderer:showUnderlingReportTitle"><s:text name="workreport.title" /></td> 
                </s:if>
                <s:else>
                <td whir-options="field:'', width:'20%', renderer:showReportTitle"><s:text name="workreport.title" /></td> 
                </s:else>
                <td whir-options="field:'', width:'7%', renderer:showReportType"><s:text name="workreport.type" /></td> 
            </s:if>
            <s:if test="#request.reportType=='other'">
                <td whir-options="field:'reportCourse', width:'15%', allowSort:true"><s:text name="workreport.reportduration" /></td> 
            </s:if>
            <s:else>
                <s:if test="#request.menuType=='underling'">
                    <td whir-options="field:'reportCourse', width:'17%', renderer:showUnderlingReportCourse, allowSort:true"><s:text name="workreport.reportduration" /></td> 
                </s:if>
                <s:else>
                    <td whir-options="field:'reportCourse', width:'17%', renderer:showReportCourse, allowSort:true"><s:text name="workreport.reportduration" /></td> 
                </s:else>
            </s:else>
                <td whir-options="field:'reportTime', width:'14%', renderer:showReportTime, allowSort:true"><s:text name="workreport.reportdate" /></td> 
                <td whir-options="field:'', renderer:showReportReader"><s:text name="workreport.subto" /></td>
                <s:if test="#request.reportType=='newReport'">
                      <td whir-options="field:'reportType',width:'6%',renderer:showReportType ">汇报类型</td>
			   </s:if>
            <s:if test="#request.menuType=='mine'">
                <td whir-options="field:'', width:'8%', renderer:myOperate"><s:text name="agent.operation" /></td> 
            </s:if>
            <s:if test="#request.menuType=='underling'">
                <td whir-options="field:'', width:'8%', renderer:leaderOperate"><s:text name="agent.operation" /></td> 
            </s:if>
            </tr>
        </thead>
        <tbody  id="itemContainer" >
        
        </tbody>
    </table>
    <!-- LIST PART END -->

    <!-- PAGER PART START -->
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="Pagebar">
        <tr>
            <td>
                <%@ include file="/public/page/pager.jsp"%>
            </td>
        </tr>
    </table>
    <!-- PAGER PART END -->
    </s:form>
</body>


<script type="text/javascript">

$(document).ready(function(){    
    //初始化列表页form表单,"queryForm"是表单id，可修改。
    initListFormToAjax({formId:"queryForm", onLoadSuccessAfter:showUserCardInfo});  
});

//自定义操作栏内容
function myOperate(po, i){
    var html =  '&nbsp;';
    /*
     * 能修改删除情况：
     * (1) 该条汇报记录是“草稿”状态
     * (2) 该条汇报记录是“已发送”状态，但所有领导未读该汇报
     */ 
    if(po.sendType == '0' || (po.sendType == '1' && po.hadRead=='0')){
        html +=  '<a href="javascript:void(0);" onclick="modiWorkReport('+po.workReportId+', \''+po.verifyCode+'\');"><img border="0" src="<%=rootPath%>/images/modi.gif" title="<s:text name="comm.supdate" />" ></a><a href="javascript:void(0)" onclick="deleteWorkReport('+po.workReportId+', \''+po.verifyCode+'\', this);"><img border="0" src="<%=rootPath%>/images/del.gif" title="<s:text name="comm.sdel" />" ></a>';
    }
    
    return html;
}

// 
function leaderOperate(po, i){
    var html =  '<a href="javascript:void(0)" onclick="deleteUnderlingWorkReport('+po.iWorkReportId+', \''+po.iWorkReportId_verifyCode+'\', this);"><img border="0" src="<%=rootPath%>/images/del.gif" title="<s:text name="comm.sdel" />" ></a>';
    return html;
}
//显示汇报类型
function showReportType(po,i){
   var html="";
   var type = po.reportType;
   if(type=='1'){
      html="周报";
   }else if(type=='3'){
      html="月报";
   }else{
     html="其他";  
   }
   return html;
}
/**自定义查看栏内容 [BGEING] */
/**自定义查看栏内容 [END] */
</script>

</html>
