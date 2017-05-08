<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <s:if test="#request.workReport.reportType==1">
        <title><s:text name="personalwork.view" /><s:text name="workreport.subreport" /><s:text name="personalwork.weekreport" /></title>
    </s:if>
    <s:else>
        <s:if test="#request.workReport.reportType==3">
            <title><s:text name="personalwork.view" /><s:text name="workreport.subreport" /><s:text name="personalwork.monthreport" /></title>
        </s:if>
        <s:else>
            <title><s:text name="personalwork.view" /><s:text name="workreport.subreport" /><s:text name="personalwork.otherreport" /></title>
        </s:else>
    </s:else>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
    <%@ include file="/public/include/meta_base.jsp"%>
    <%@ include file="/public/include/meta_detail.jsp"%>
    <!--这里可以追加导入模块内私有的js文件或css文件-->
    <script src="<%=rootPath%>/modules/personal/workreport/workreport_check_js.js" type="text/javascript"></script>
    <script src="<%=rootPath%>/modules/personal/workreport/workreport_common_view_js.js" type="text/javascript"></script>
    <script src="<%=rootPath%>/scripts/i18n/<%=whir_locale%>/PersonalworkResource.js" type="text/javascript"></script>
</head>

<body class="Pupwin">
    <div class="BodyMargin_10">  
        <div class="docBoxNoPanel">
            <s:form name="dataForm" id="dataForm" action="${ctx}/WorkReportUnderlingAction!saveUnderlingReport.action" method="post" theme="simple" >
            <!-- 注：如果没有如下这个 include 的文件，则点击该页面保存时，结果显示 printResult 的结果 -->
                <%@ include file="/public/include/form_detail.jsp"%>
                
            <table width="100%" border="0" cellpadding="2" cellspacing="0" class="Table_bottomline">
                <s:hidden name="workReportId" id="workReportId" />
                <s:hidden id="verifyCode" value="%{#request.verifyCode}" />
                <s:hidden id="isFromDesktop" value="%{#request.isFromDesktop}" />
                <s:hidden id="reportType" value="%{#request.workReport.reportType}" />
                <!-- Main Part Start -->
                <tr>
                    <!-- 周报/月报 标题 -->
                    <td colspan="4" nowrap align="center" style="font-size:18px; font-weight:bold;">
                    <s:if test="#request.workReport.reportType==1">
                        <s:text name="workreport.staffweek" />
                    </s:if>
                    <s:if test="#request.workReport.reportType==3">
                        <s:text name="workreport.staffmonth" />
                    </s:if>
                    </td>
                </tr>
                <tr>
                    <!-- 被考核人 -->
                    <td width="5%" class="td_lefttitle"><s:text name="workreport.undercheck"/>：</td>
                    <td width="45%">
                        <s:textfield name="workReport.reportEmpName" id="reportEmpName" cssClass="inputText" cssStyle="width:95%" readonly="true" disabled="true" />
                    </td>
                    <!-- 职务 -->
                    <td width="5%" class="td_lefttitle"><s:text name="workreport.duty"/>：</td>
                    <td width="45%">
                        <s:textfield name="workReport.reportJob" id="reportJob" cssClass="inputText" cssStyle="width:95%" readonly="true" disabled="true" />
                    </td>
                </tr>
                <tr>
                    <!-- 部门 -->
                    <td class="td_lefttitle"><s:text name="workreport.department"/>：</td>
                    <td>
                        <s:textfield name="workReport.reportDepart" id="reportDepart" cssClass="inputText" cssStyle="width:95%" readonly="true" disabled="true" />
                    </td>
                    <!-- 汇报区间 -->
                    <td class="td_lefttitle"><s:text name="workreport.reportduration"/>：</td>
                    <td>
                        <s:textfield name="workReport.reportCourse" id="reportCourse" cssClass="inputText" cssStyle="width:95%" readonly="true" disabled="true" />  
                    </td>
                </tr>
                <s:if test="workReportId!=null && #request.workReport.reportType!=1 && #request.workReport.reportType!=3">
                <tr>
                    <!-- 汇报标题 -->
                    <td class="td_lefttitle"><s:text name="workreport.title"/><span class="MustFillColor">*</span>：</td>
                    <td colspan="3" >
                        <s:textfield name="workReport.reportTitle" id="reportTitle" cssClass="inputText" cssStyle="width:98%" disabled="true" /> 
                    </td>
                </tr>
                </s:if>
                <tr>
                    <!-- 提交至 -->
                    <td class="td_lefttitle">
                        <s:text name="workreport.subto"/>：
                    </td>
                    <td colspan="3">
                        <s:textarea name="workReport.reportReader" id="reportReader" cssClass="inputTextarea" readonly="true" cssStyle="width:98%" disabled="true" ></s:textarea>
                    </td>
                </tr>
                <tr>
                    <!-- 附件 -->
                    <td class="td_lefttitle">
                        <s:text name="workreport.attachment"/>：
                    </td>
                    <td colspan="3">
                    <s:if test="#request.formAttachRealName==''">
                        <!-- <s:text name="workreport.nonattachment" /> -->
                    </s:if>
                    <s:else>
                        <s:hidden name="formAttachRealName" id="formAttachRealName" />
                        <s:hidden name="formAttachSaveName" id="formAttachSaveName" />
                        <jsp:include page="/public/upload/uploadify/upload_include.jsp" flush="true"> 
                           <jsp:param name="dir" value="workreport" />
                           <jsp:param name="uniqueId" value="uniqueId" />
                           <jsp:param name="realFileNameInputId" value="formAttachRealName" />
                           <jsp:param name="saveFileNameInputId" value="formAttachSaveName" />
                           <jsp:param name="canModify" value="no" />
                        </jsp:include>
                    </s:else>
                    </td>
                </tr>
                <tr>
                    <!-- 汇报内容 -->
                    <td class="td_lefttitle">
                        <s:text name="workreport.reportcontent"/>：
                    </td>
                    <td colspan="3">
                        <div id="reportContent" style="width:98%;border-style:solid;border-width:1px;border-color:gray;">
                        <%
                            String showPreviousReport = request.getAttribute("showPreviousReport")==null?"":request.getAttribute("showPreviousReport").toString();
                        %>
                            <%=showPreviousReport%>
                        </div>
                    </td>
                </tr>
                
                <!-- 考核记录部分 [BEGIN] -->
                <tr>
                    <td colspan="4"><strong><s:text name="workreport.chargeevaluation"/>：</strong></td>
                </tr>
                <tr>
                    <td colspan="4">
                        <table width="99%" border="0" cellspacing="2" cellpadding="0" class="docBoxNoPanel">
                        
                        <s:if test="#request.mineReportPostilList.size==0 && #request.reportPostilList.size==0">
                            <tr>
                            <s:if test="#request.workReport.reportType==1 || #request.workReport.reportType==3">
                                <td width="49%" height="20" align="center" valign="top" class="outRightLine" bgcolor="#dddddd">
                                    <s:text name="workreport.noevaluation"/>
                                </td>
                                <td width="49%" height="20" align="center" valign="top" class="outRightLine" bgcolor="#dddddd">
                                    <s:text name="workreport.nonworkprompt"/>
                                </td>
                            </s:if>
                            <s:else>
                                <td width="98%" height="20" align="center" valign="top" class="outRightLine" bgcolor="#dddddd">
                                    <s:text name="workreport.noevaluation"/>
                                </td>
                            </s:else>
                            </tr>
                        </s:if>
                        <s:else>
                            <s:if test="#request.mineReportPostilList.size!=0">
                            <!-- 我的批注 [BEGIN] -->
                                <tr>
                                <s:if test="#request.workReport.reportType==1 || #request.workReport.reportType==3">
                                    <td width="49%" height="20" align="center" valign="top" class="outRightLine" bgcolor="#dddddd">
                                        <s:text name="workreport.yourvaluator"/>
                                    <td width="49%" height="20" align="center" valign="top" class="outRightLine" bgcolor="#dddddd">
                                        <s:text name="workreport.youropinion"/>
                                    </td>
                                </s:if>
                                <s:else>
                                    <td width="98%" height="20" align="center" valign="top" class="outRightLine" bgcolor="#dddddd">
                                        <s:text name="workreport.yourvaluator"/>
                                    </td>
                                </s:else>
                                </tr>
                                <s:iterator var="obj" value="#request.mineReportPostilList" >
                                    <tr bgcolor="#FFFFFF">
                                        <td>
                                            <div name="postilContent" style="word-break: break-all; word-wrap:break-word;"><s:property value="#obj[3]" /></div>
                                            <div align="right">
                                                <s:property value="#obj[1]" />
                                                <s:if test="#request.workReport.reportType!=1 && #request.workReport.reportType!=3">
                                                <!-- Other Report -->
                                                &nbsp;&nbsp;<s:property value="#obj[2]" />
                                                </s:if>
                                            </div>
                                        </td>
                                        <s:if test="#request.workReport.reportType==1 || #request.workReport.reportType==3">
                                        <td>
                                            <div name="nextWorkClew" style="word-break: break-all; word-wrap:break-word;"><s:property value="#obj[4]" /></div>
                                            <div align="right"><s:property value="#obj[1]" /></div>
                                        </td>
                                        </s:if>
                                    </tr>
                                </s:iterator>
                                <s:if test="#request.workReport.reportType==3">
                                <tr>
                                    <td colspan="2">
                                        <s:text name="workreport.checklevel"/>：<s:property value="#obj[5]" />
                                    </td>
                                </tr>
                                </s:if>
                            <!-- 我的批注 [END] -->
                            </s:if>
                            
                            <s:if test="#request.reportPostilList.size!=0">
                            <!-- 其他领导批注 [BEGIN] -->
                                <tr>
                                <s:if test="#request.workReport.reportType==1 || #request.workReport.reportType==3">
                                    <td width="49%" height="20" align="center" valign="top" class="outRightLine" bgcolor="#dddddd">
                                    <s:if test="#request.workReport.reportType==1">
                                        <s:text name="workreport.thisweekopinion"/>
                                    </s:if>
                                    <s:else>
                                        <s:text name="workreport.thismonthopinion"/>
                                    </s:else>
                                    </td>
                                    <td width="49%" height="20" align="center" valign="top" class="outRightLine" bgcolor="#dddddd">
                                    <s:if test="#request.workReport.reportType==1">
                                        <s:text name="workreport.nextweekworkprompt"/>
                                    </s:if>
                                    <s:else>
                                        <s:text name="workreport.nextmonthworkprompt"/>
                                    </s:else>
                                    </td>
                                </s:if>
                                <s:else>
                                    <td width="98%" height="20" align="center" valign="top" class="outRightLine" bgcolor="#dddddd">
                                        <s:text name="workreport.commnet"/>
                                    </td>
                                </s:else>
                                </tr>
                                <s:iterator var="obj" value="#request.reportPostilList" >
                                    <tr bgcolor="#FFFFFF">
                                        <td>
                                            <div name="postilContent" style="word-break: break-all; word-wrap:break-word;"><s:property value="#obj[3]" /></div>
                                            <div align="right">
                                                <s:property value="#obj[1]" />
                                                <s:if test="#request.workReport.reportType!=1 && #request.workReport.reportType!=3">
                                                <!-- Other Report -->
                                                &nbsp;&nbsp;<s:property value="#obj[2]" />
                                                </s:if>
                                            </div>
                                        </td>
                                        <s:if test="#request.workReport.reportType==1 || #request.workReport.reportType==3">
                                        <td>
                                            <div name="nextWorkClew" style="word-break: break-all; word-wrap:break-word;"><s:property value="#obj[4]" /></div>
                                            <div align="right"><s:property value="#obj[1]" /></div>
                                        </td>
                                        </s:if>
                                    </tr>
                                </s:iterator>
                                <s:if test="#request.workReport.reportType==3">
                                <tr>
                                    <td colspan="2">
                                        <s:text name="workreport.checklevel"/>：<s:property value="#obj[5]" />
                                    </td>
                                </tr>
                                </s:if>
                            <!-- 其他领导批注 [END] -->
                            </s:if>
                        </s:else>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td colspan="4">&nbsp;</td>
                </tr>
                <!-- 考核记录部分 [END] -->
                
                <!-- 新建考核部分 [BEGIN] -->
                <!--s:property value="#request.isReportReader" /-->
                <s:if test="#request.isReportReader==1">
                <tr>
                    <td colspan="4">
                        <table width="99%" border="0" cellspacing="2" cellpadding="0" class="docBoxNoPanel">
                            <tr>
                            <s:if test="#request.workReport.reportType==1">
                                <td width="49%" height="20" align="center" valign="top" class="outRightLine" bgcolor="#dddddd">
                                    <s:text name="workreport.thisweekopinion"/>
                                </td>
                                <td width="49%" height="20" align="center" valign="top" class="outRightLine" bgcolor="#dddddd">
                                    <s:text name="workreport.nextweekworkprompt"/>
                                </td>
                            </s:if>
                            <s:else>
                                <s:if test="#request.workReport.reportType==3">
                                    <s:if test="#request.mineReportPostilList.size==0">
                                        <td width="49%" height="20" align="center" valign="top" class="outRightLine" bgcolor="#dddddd">
                                            <s:text name="workreport.thismonthopinion"/>
                                        </td>
                                        <td width="49%" height="20" align="center" valign="top" class="outRightLine" bgcolor="#dddddd">
                                            <s:text name="workreport.nextmonthworkprompt"/>
                                        </td>
                                    </s:if>
                                </s:if>
                                <s:else>
                                    <td width="98%" height="20" align="center" valign="top" class="outRightLine" bgcolor="#dddddd">
                                        <s:text name="workreport.commnet"/>
                                    </td>
                                </s:else>
                            </s:else>
                            </tr>
                            <tr>
                            <s:if test="#request.workReport.reportType==1">
                                <td>
                                    <s:textarea name="reportPostil.postilContent" id="postilContent" cssClass="inputTextarea" cssStyle="width:99%" ></s:textarea>
                                </td>
                                <td>
                                    <s:textarea name="reportPostil.nextWorkClew" id="nextWorkClew" cssClass="inputTextarea" cssStyle="width:99%" ></s:textarea>
                                </td>
                            </s:if>
                            <s:else>
                                <s:if test="#request.workReport.reportType==3">
                                    <s:if test="#request.mineReportPostilList.size==0">
                                        <td>
                                            <s:textarea name="reportPostil.postilContent" id="postilContent" cssClass="inputTextarea" cssStyle="width:99%" ></s:textarea>
                                        </td>
                                        <td>
                                            <s:textarea name="reportPostil.nextWorkClew" id="nextWorkClew" cssClass="inputTextarea" cssStyle="width:99%" ></s:textarea>
                                        </td>
                                    </s:if>
                                </s:if>
                                <s:else>
                                    <td>
                                        <s:textarea name="reportPostil.postilContent" id="postilContent" cssClass="inputTextarea" cssStyle="width:99%" ></s:textarea>
                                    </td>
                                </s:else>
                            </s:else>
                            </tr>
                            <s:if test="#request.workReport.reportType==3 && #request.mineReportPostilList.size==0">
                            <!-- 月报 -->
                                <tr>
                                    <td colspan="2">
                                        <s:text name="workreport.checklevel"/>：
                                        <select name="reportPostil.grade" id="grade" class="easyui-combobox" style="width:60px;" data-options="panelHeight:'auto', selectOnFocus:true, editable:false">
                                            <option value="无">无</option>
                                            <option value="A+">A+</option>
                                            <option value="A">A</option>
                                            <option value="A-">A-</option>
                                            <option value="B+" selected="selected">B+</option>
                                            <option value="B">B</option>
                                            <option value="B-">B-</option>
                                            <option value="C+">C+</option>
                                            <option value="C">C</option>
                                            <option value="C-">C-</option>
                                        </select>
                                    </td>
                                </tr>
                            </s:if>
                        </table>
                    </td>
                </tr>
                </s:if>
                <!-- 新建考核部分 [END] -->
                
                <!-- 新建申述部分 [END] -->
                <s:if test="#request.workReport.reportType==3">
                    <!-- 月报 -->
                    <s:if test="#request.reportAppealList!=null">
                        <s:if test="#request.reportAppealList.size==0">
                        <!-- 新建申述 -->
                        <tr>
                            <td colspan="4">
                                <table width="99%" border="0" cellspacing="2" cellpadding="0" class="docBoxNoPanel">
                                    <tr>
                                        <td width="99%" height="20" align="center" valign="top" class="outRightLine" bgcolor="#dddddd">
                                            <s:text name="workreport.appealresult"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <s:textarea name="reportPostil.postilResult" id="postilResult" cssClass="inputTextarea" cssStyle="width:99%" ></s:textarea>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <s:text name="workreport.Appeallevel"/>：
                                            <select name="reportPostil.postilGrade" id="postilGrade" class="easyui-combobox" style="width:60px;" data-options="panelHeight:'auto', selectOnFocus:true, editable:false">
                                                <option value="无">无</option>
                                                <option value="A+">A+</option>
                                                <option value="A">A</option>
                                                <option value="A-">A-</option>
                                                <option value="B+" selected="selected">B+</option>
                                                <option value="B">B</option>
                                                <option value="B-">B-</option>
                                                <option value="C+">C+</option>
                                                <option value="C">C</option>
                                                <option value="C-">C-</option>
                                            </select>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        </s:if>
                        <s:else>
                        <!-- 申述记录 -->
                        <tr>
                            <td colspan="4">
                                <table width="99%" border="0" cellspacing="2" cellpadding="0" class="docBoxNoPanel">
                                    <tr>
                                        <td width="99%" height="20" align="center" valign="top" class="outRightLine" bgcolor="#dddddd">
                                            <s:text name="workreport.appealresult"/>
                                        </td>
                                    </tr>
                                    <s:iterator var="obj" value="#request.reportAppealList" >
                                        <tr bgcolor="#FFFFFF">
                                            <td>
                                                <div name="postilContent" style="word-break: break-all; word-wrap:break-word;"><s:property value="#obj[1]" /></div>
                                                <div align="right">
                                                    <s:property value="#obj[0]" />
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <s:text name="workreport.Appeallevel"/>：<s:property value="#obj[2]" />
                                            </td>
                                        </tr>
                                    </s:iterator>
                                </table>
                            </td>
                        </tr>
                        </s:else>
                    </s:if>
                </s:if>
                <!-- 新建申述部分 [END] -->
                
                <tr>
                    <td colspan="4">
                        <s:if test="#request.workReport.empId != #session.userId">
                        <input type="button" class="btnButton4font" onClick="displayTransPart(1);" id="button_openTrans" value='<s:text name="workreport.showtransfer"/>' />
                        </s:if>
                        <input type="button" class="btnButton4font" onClick="displayTransPart(0);" id="button_closeTrans" value='<s:text name="workreport.hidetransfer"/>' style="display:none;" />
                        <input type="button" class="btnButton4font" onClick="displayTransHistoryPart(1);" id="button_openTransHistory" value='<s:text name="workreport.transferrecord"/>' />
                        <input type="button" class="btnButton4font" onClick="displayTransHistoryPart(0);" id="button_closeTransHistory" value='<s:text name="workreport.hiderecord" />' style="display:none;" />
                    </td>
                </tr>
                
                <!-- 新建转发部分 [END] -->
                <tr id="tr_transReason" style="display:none;">
                    <td class="td_lefttitle">
                        <s:text name="workreport.transferreason"/>：
                    </td>
                    <td colspan="3">
                        <s:textarea name="reportTransmit.transReason" id="transReason" cssClass="inputTextarea" maxlength="1800"></s:textarea>
                    </td>
                </tr>
                <tr id="tr_transTo" style="display:none;">
                    <td class="td_lefttitle">
                        <s:text name="workreport.transferto"/>：
                    </td>
                    <td colspan="3">
                        <s:hidden name="reportTransmit.transToEMP" id="transToEMP" />
                        <s:textarea name="reportTransmit.transToEMPName" id="transToEMPName" cssClass="inputTextarea" readonly="true" ></s:textarea><a href="javascript:void(0)" class="selectIco textareaIco" onclick="openSelect({allowId:'transToEMP', allowName:'transToEMPName', select:'user', single:'no', show:'usergroup', range:'*0*'});"></a>
                    </td>
                </tr>
                <!-- 新建转发部分 [END] -->
                
                <!-- 转发记录部分 [BEGIN] -->
                <tr id="tr_transHistory" style="display:none;">
                    <td colspan="4">
                        <table width="99%" border="0" cellspacing="0" cellpadding="0" class="docBoxNoPanel">
                            <tr>
                                <td width="10%" height="20" align="center" valign="top" class="outRightLine" bgcolor="#dddddd">
                                    <s:text name="workreport.transferperson"/>
                                </td>
                                <td width="35%" height="20" align="center" valign="top" class="outRightLine" bgcolor="#dddddd">
                                    <s:text name="workreport.transferto"/>
                                </td>
                                <td width="35%" height="20" align="center" valign="top" class="outRightLine" bgcolor="#dddddd">
                                    <s:text name="workreport.transferreason"/>
                                </td>
                                <td width="20%" height="20" align="center" valign="top" class="outRightLine" bgcolor="#dddddd">
                                    <s:text name="workreport.trans"/>
                                </td>
                            </tr>
                            <s:iterator var="obj" value="#request.reportTransmitList" >
                                <tr>
                                    <td>
                                        <s:property value="%{#obj[0]}" />
                                    </td>
                                    <td>
                                        <s:property value="%{#obj[1]}" />
                                    </td>
                                    <td>
                                        <s:property value="%{#obj[2]}" />
                                    </td>
                                    <td>
                                        <s:property value="%{#obj[3]}" />
                                    </td>
                                </tr>
                            </s:iterator>
                        </table>
                    </td>
                </tr>
                <!-- 转发记录部分 [END] -->
                <!-- Main Part End   -->
                <tr class="Table_nobttomline"> 
                    <td>&nbsp;</td> 
                    <td colspan="2" nowrap>
                        <input type="button" class="btnButton4font" onClick="if(checkForm()){ok(0,this)};" value='<s:text name="comm.saveclose"/>' />
                        <input type="button" class="btnButton4font" onClick="resetDataForm(this);" value='<s:text name="comm.reset"/>' /> 
                        <s:if test="#request.mineReportPostilList.size==0 && #request.reportPostilList.size==0">
                            <input type="button" class="btnButton4font" onClick="returnBackReport();" value='<s:text name="workreport.back"/>' /> 
                        </s:if>
                        <input type="button" class="btnButton4font" onClick="closeWindow(null);" value='<s:text name="comm.exit" />' />
                    </td>  
                </tr>  
            </table>  
            </s:form>
        </div>
    </div>
</body>

<script type="text/javascript">
$(document).ready(function(){
    if(initViewForm()){
        //设置表单为异步提交
        initDataFormToAjax({"dataForm":'dataForm', "queryForm":'queryForm', "tip":'<s:text name="personalwork.save" />'});
        //alert($('#reportJob').val());
    }   
});
</script>

</html>
