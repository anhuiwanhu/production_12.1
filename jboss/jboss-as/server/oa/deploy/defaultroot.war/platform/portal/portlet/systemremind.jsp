<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page import="java.util.*"%>
<%@ page import="org.jdom.*"%>
<%@ page import="com.whir.ezoffice.portal.bd.*"%>
<%@ page import="com.whir.ezoffice.portal.po.*"%>
<%@ page import="com.whir.ezoffice.portal.common.util.*"%>
<%@ page import="com.whir.ezoffice.remind.bd.RemindBD"%>
<%@ page import="com.whir.i18n.Resource"%>
<%@ page import="com.whir.common.util.CommonUtils"%>
<%
//模块页面
response.setHeader("Cache-Control","no-store");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", 0);
response.setContentType("text/html; charset=UTF-8");
String _skin = PortletUtil.getSkin(request);

String local = session.getAttribute("org.apache.struts.action.LOCALE").toString();
String userId = session.getAttribute("userId").toString();
String orgId = session.getAttribute("orgId").toString();
String orgIdString = session.getAttribute("orgIdString").toString();
String portletSettingId = request.getParameter("portletSettingId");

String empIdCard = session.getAttribute("empIdCard").toString();
PortletBD pbd = new PortletBD();
String settingsXml = pbd.getSettingsXml(portletSettingId);
Document doc = null;
Element rootElement = null;
XmlUtil xmlUtil = new XmlUtil();
String scrolling = "";
String newTask = "";
String checkTask = "";
String newReport = "";
String newEvent = "";
String newPress = "";
String newFeedBack = "";
String ReceiveFileBoxCount = "";
String meetingCount = "";
String remindContract = "";
String orgAssess = "";
String empAssess = "";
String workReportReply = "";

com.whir.service.client.SystemClient systemClient = new com.whir.service.client.SystemClient();
//交换中心邮件
String transMailNum = "";
//交换中心待办
String transWaitFileNum = "";

if(settingsXml!=null&&!"".equals(settingsXml)&&!"null".equals(settingsXml)){    
    doc = xmlUtil.createDoc(settingsXml);
    rootElement = xmlUtil.getRootElement(doc);

    scrolling = xmlUtil.getChildValue(rootElement, "scrolling");
    newTask = xmlUtil.getChildValue(rootElement, "newTask");
    checkTask = xmlUtil.getChildValue(rootElement, "checkTask");
    newReport = xmlUtil.getChildValue(rootElement, "newReport");
    newEvent = xmlUtil.getChildValue(rootElement, "newEvent");
    newPress = xmlUtil.getChildValue(rootElement, "newPress");
    newFeedBack = xmlUtil.getChildValue(rootElement, "newFeedBack");
    ReceiveFileBoxCount = xmlUtil.getChildValue(rootElement, "ReceiveFileBoxCount");
    meetingCount = xmlUtil.getChildValue(rootElement, "meetingCount");
    remindContract = xmlUtil.getChildValue(rootElement, "remindContract");
    orgAssess = xmlUtil.getChildValue(rootElement, "orgAssess");
    empAssess = xmlUtil.getChildValue(rootElement, "empAssess");
    workReportReply = xmlUtil.getChildValue(rootElement, "workReportReply");
	transMailNum = xmlUtil.getChildValue(rootElement, "transMailNum");
	transWaitFileNum = xmlUtil.getChildValue(rootElement, "transWaitFileNum");
}

if(!CommonUtils.isEmpty(newTask) || 
    !CommonUtils.isEmpty(checkTask) || 
    !CommonUtils.isEmpty(newReport) || 
    !CommonUtils.isEmpty(newEvent) || 
    !CommonUtils.isEmpty(newPress) || 
    !CommonUtils.isEmpty(newFeedBack) || 
    !CommonUtils.isEmpty(ReceiveFileBoxCount) || 
    !CommonUtils.isEmpty(meetingCount) || 
    !CommonUtils.isEmpty(remindContract) || 
    !CommonUtils.isEmpty(orgAssess) || 
    !CommonUtils.isEmpty(empAssess) || 
    !CommonUtils.isEmpty(workReportReply)|| 
    !CommonUtils.isEmpty(transMailNum)|| 
    !CommonUtils.isEmpty(transWaitFileNum)){

String marqueeBegin = "";
String marqueeEnd = "";
if("1".equals(scrolling)){
    marqueeBegin = "<MARQUEE SCROLLAMOUNT='1' direction=up SCROLLDELAY='10' LOOP='-1' onmouseover='this.stop();' onmouseout='this.start();'>";
    marqueeEnd = "</MARQUEE>";
}

RemindBD remindBD = new RemindBD();
Map map = remindBD.getRemindModule(userId, orgId, orgIdString);
%>

<ul class="wh-system-warn clearfix">
<%=marqueeBegin%>

<%
	if(!CommonUtils.isEmpty(transMailNum)){//交换中心邮件
       transMailNum = systemClient.getTransMailNum(empIdCard);
      // if(!CommonUtils.isEmpty(transMailNum)&&!"0".equals(transMailNum)){
%>
 <li class="wh-sys-list">
 	<a title="<%=Resource.getValue(local, "common", "comm.newemailtranscenter")%>" href='javascript:void(0)' onclick="javascript:jumpnew('<%=rootPath%>/platform/system/transcenter/loginCheck.jsp?module=mail&reurl=/defaultroot/innerMail!innermailMenu.action%3FexpNodeCode=mymail%26menuName=内部邮件','<%=rootPath%>/platform/system/transcenter/loginCheck.jsp?module=mail&reurl=/defaultroot/innerMail!notreadMailList.action');">
 		<span class="wh-sys-warn-num"><%=transMailNum%></span>
 		<i class="fa fa-envelope"></i>
 		<span class="wh-sys-text">
 			&nbsp;<%=Resource.getValue(local, "common", "comm.newemailtranscenter")%>
 		</span>
 	</a>
 </li>

<%}//}%>


<%
	if(!CommonUtils.isEmpty(transWaitFileNum)){//交换中心待办
      transWaitFileNum = systemClient.getTransWaitFileNum(empIdCard);
      //if(!CommonUtils.isEmpty(transWaitFileNum)&&!"0".equals(transWaitFileNum)){
%>

 <li class="wh-sys-list">
 	<a title="<%=Resource.getValue(local, "common", "comm.newewatingdealtranscenter")%>" href='javascript:void(0)' onclick="javascript:jumpnew('<%=rootPath%>/platform/system/transcenter/loginCheck.jsp?module=workflow&reurl=/defaultroot/wfdealwith!menu.action%3FexpNodeCode=myWatingDeal%26menuName=流程','<%=rootPath%>/platform/system/transcenter/loginCheck.jsp?module=workflow&reurl=/defaultroot/wfdealwith!dealwithList.action?openType=waitingDeal&noTreatment=0');">
 	<span class="wh-sys-warn-num">
 	<%=transWaitFileNum%></span>
 	<i class="fa fa-contract-mana"></i>
 	<span class="wh-sys-text">
 	&nbsp;<%=Resource.getValue(local, "common", "comm.newewatingdealtranscenter")%>
 	</span>
 	</a>
 	</li>

<%}//}%>

<%
if(!CommonUtils.isEmpty(newTask)){//新任务
    String m_newTask = "0";
    if((String)map.get(newTask)!=null&&!"".equals((String)map.get(newTask))){
    	m_newTask = (String)map.get(newTask);
    }
   // if(!CommonUtils.isEmpty(m_newTask)&&!"0".equals(m_newTask)){
%>

<li class="wh-sys-list">
	<a title="<%=Resource.getValue(local, "common", "comm.task")%>" href='javascript:void(0)'  onclick="javascript:jumpnew('<%=rootPath%>/modules/personal/personal_menu.jsp?statusType=6&expNodeCode=newTask','<%=rootPath%>/taskCenter!selectPrincipalTask.action');">
	<span class="wh-sys-warn-num"><%=m_newTask%></span>
	<i class="fa fa-flag"></i>
	<span class="wh-sys-text">
	&nbsp;<%=Resource.getValue(local, "common", "comm.task")%>
	</span>
	</a>
	</li>

<%}//}%>

<%
if(!CommonUtils.isEmpty(checkTask)){//待考核任务
    String m_checkTask = "0";
     if((String)map.get(checkTask)!=null&&!"".equals((String)map.get(checkTask))){
    	m_checkTask = (String)map.get(checkTask);
    }
    //if(!CommonUtils.isEmpty(m_checkTask)&&!"0".equals(m_checkTask)){
%>
<li class="wh-sys-list">
<a  title="<%=Resource.getValue(local, "common", "comm.waittask")%>" href='javascript:void(0)' onclick="javascript:jumpnew('<%=rootPath%>/modules/personal/personal_menu.jsp?statusType=6&expNodeCode=newTask','<%=rootPath%>/taskCenter!selectJoinTask.action');">
<span class="wh-sys-warn-num"><%=m_checkTask%></span>
<i class="fa fa-file-o"></i>
<span class="wh-sys-text">
&nbsp;<%=Resource.getValue(local, "common", "comm.waittask")%>
</span>
</a>
</li>
<%}//}%>





<%
if(!CommonUtils.isEmpty(newReport)){//新汇报
    String m_newReport = "0";
    if((String)map.get(newReport)!=null&&!"".equals((String)map.get(newReport))){
    	m_newReport = (String)map.get(newReport);
    }
   // if(!CommonUtils.isEmpty(m_newReport)&&!"0".equals(m_newReport)){
%>

<li class="wh-sys-list">
<a title="<%=Resource.getValue(local, "common", "comm.report")%>" href='javascript:void(0)' onclick="javascript:jumpnew('<%=rootPath%>/modules/personal/personal_menu.jsp?statusType=workReport&expNodeCode=newReport','<%=rootPath%>/WorkReportAction!workReportList.action?menuType=underling&reportType=newReport');">
<span class="wh-sys-warn-num"><%=m_newReport%></span>
<i class="fa fa-files-o"></i>
<span class="wh-sys-text">
&nbsp;<%=Resource.getValue(local, "common", "comm.report")%>
</span>
</a>
</li>

<%}//}%>

<%
if(!CommonUtils.isEmpty(newEvent)){//新事件
    String m_newEvent = "0";
    if((String)map.get(newEvent)!=null&&!"".equals((String)map.get(newEvent))){
    	m_newEvent = (String)map.get(newEvent);
    }
    //if(!CommonUtils.isEmpty(m_newEvent)&&!"0".equals(m_newEvent)){
%>
<li class="wh-sys-list">
<a title="<%=Resource.getValue(local, "common", "comm.event")%>" href='javascript:void(0)' onclick="javascript:jumpnew('<%=rootPath%>/modules/personal/personal_menu.jsp?expNodeCode=newEvent','<%=rootPath%>/EventAction!eventList.action?menuType=mine');">
<span class="wh-sys-warn-num"><%=m_newEvent%></span>
<i class="fa fa-comment"></i>
<span class="wh-sys-text">
&nbsp;<%=Resource.getValue(local, "common", "comm.event")%>
</span>
</a>
</li>
<%}//}%>

<%
if(!CommonUtils.isEmpty(newPress)){//新催办
    String m_newPress = "0";
     if((String)map.get(newPress)!=null&&!"".equals((String)map.get(newPress))){
    	m_newPress = (String)map.get(newPress);
    }
    //if(!CommonUtils.isEmpty(m_newPress)&&!"0".equals(m_newPress)){
%>
<li class="wh-sys-list">
<a title="<%=Resource.getValue(local, "common", "comm.press")%>" href='javascript:void(0)' onclick="javascript:jumpnew('<%=rootPath%>/modules/personal/personal_menu.jsp?statusType=pressdeal&expNodeCode=pressdeal','<%=rootPath%>/PressManageAction!receivePressList.action');">
<span class="wh-sys-warn-num"><%=m_newPress%></span>
<i class="fa fa-clock-o"></i>
<span class="wh-sys-text">
&nbsp;<%=Resource.getValue(local, "common", "comm.press")%>
</span>
</a>
</li>
<%}//}%>

<%
if(!CommonUtils.isEmpty(newFeedBack)){//新反馈
    String m_newFeedBack = "0";
     if((String)map.get(newFeedBack)!=null&&!"".equals((String)map.get(newFeedBack))){
    	m_newFeedBack = (String)map.get(newFeedBack);
    }
    //if(!CommonUtils.isEmpty(m_newFeedBack)&&!"0".equals(m_newFeedBack)){
%>
<li class="wh-sys-list">
<a title="<%=Resource.getValue(local, "common", "comm.NewFeedback")%>" href='javascript:void(0)' onclick="javascript:jumpnew('<%=rootPath%>/modules/personal/personal_menu.jsp?statusType=pressdeal&expNodeCode=pressFeedback','<%=rootPath%>/PressManageAction!pressFeedbackList.action');">
<span class="wh-sys-warn-num"><%=m_newFeedBack%></span>
<i class="fa fa-meeting-mana"></i>
<span class="wh-sys-text">
&nbsp;<%=Resource.getValue(local, "common", "comm.NewFeedback")%>
</span>
</a>
</li>
<%}//}%>

<%
if(!CommonUtils.isEmpty(ReceiveFileBoxCount)){//新收文
    String m_ReceiveFileBoxCount = "0";
     if((String)map.get(ReceiveFileBoxCount)!=null&&!"".equals((String)map.get(ReceiveFileBoxCount))){
    	m_ReceiveFileBoxCount = (String)map.get(ReceiveFileBoxCount);
    }
    //if(!CommonUtils.isEmpty(m_ReceiveFileBoxCount)&&!"0".equals(m_ReceiveFileBoxCount)){
%>
<li class="wh-sys-list">
<a title="<%=Resource.getValue(local, "common", "comm.receivefile")%>" href='javascript:void(0)' onclick="javascript:jumpnew('<%=rootPath%>/GovDoc!menu.action?expNodeCode=notRead','<%=rootPath%>/GovRecvDocSet!notRead.action');">
<span class="wh-sys-warn-num"><%=m_ReceiveFileBoxCount%></span>
<i class="fa fa-inbox"></i>
<span class="wh-sys-text">
&nbsp;<%=Resource.getValue(local, "common", "comm.receivefile")%>
</span>
</a>
</li>
<%}//}%>

<%
if(!CommonUtils.isEmpty(meetingCount)){//会议通知
    String m_meetingCount = "0";
     if((String)map.get(meetingCount)!=null&&!"".equals((String)map.get(meetingCount))){
    	m_meetingCount = (String)map.get(meetingCount);
    }
    //if(!CommonUtils.isEmpty(m_meetingCount)&&!"0".equals(m_meetingCount)){
%>
<li class="wh-sys-list">
<a title="<%=Resource.getValue(local, "common", "comm.meeting")%>" href='javascript:void(0)' onclick="javascript:jumpnew('<%=rootPath%>/subsidiaryMenu!toSubsidiaryMenu.action?statusType=8&expNodeCode=meetingInfo','<%=rootPath%>/boardRoom!meetingInformView.action?type=day');">
<span class="wh-sys-warn-num"><%=m_meetingCount%></span>
<i class="fa fa-bell"></i>
<span class="wh-sys-text">
&nbsp;<%=Resource.getValue(local, "common", "comm.meeting")%>
</span>
</a>
</li>
<%}//}%>

<%
if(!CommonUtils.isEmpty(remindContract)){//合同提醒
    String m_remindContract = "0";
     if((String)map.get(remindContract)!=null&&!"".equals((String)map.get(remindContract))){
    	m_remindContract = (String)map.get(remindContract);
    }
    //if(!CommonUtils.isEmpty(m_remindContract)&&!"0".equals(m_remindContract)){
%>
<li class="wh-sys-list">
<a title="<%=Resource.getValue(local, "common", "comm.contractRemind")%>" href='javascript:void(0)' onclick="javascript:jumpnew('<%=rootPath%>/subsidiaryMenu!toSubsidiaryMenu.action?statusType=10&expNodeCode=contract','<%=rootPath%>/contract!reminderList.action');">
<span class="wh-sys-warn-num"><%=m_remindContract%></span>
<i class="fa fa-contract-mana"></i>
<span class="wh-sys-text">
&nbsp;<%=Resource.getValue(local, "common", "comm.contractRemind")%>
</span>
</a>
</li>
<%}//}%>



<%
if(!CommonUtils.isEmpty(workReportReply)){//新工作汇报回复
    String m_workReportReply = "0";
     if((String)map.get(workReportReply)!=null&&!"".equals((String)map.get(workReportReply))){
    	m_workReportReply = (String)map.get(workReportReply);
    }
    //if(!CommonUtils.isEmpty(m_workReportReply)&&!"0".equals(m_workReportReply)){
%>

<li class="wh-sys-list">
<a title="<%=Resource.getValue(local, "common", "comm.newreportRE")%>" href='javascript:void(0)'  onclick="javascript:jumpnew('<%=rootPath%>/modules/personal/personal_menu.jsp?statusType=workReport&expNodeCode=REworkReport','<%=rootPath%>/WorkReportAction!workReportList.action?menuType=underling&reportType=other');">
<span class="wh-sys-warn-num"><%=m_workReportReply%></span>
<i class="fa fa-book"></i>
<span class="wh-sys-text">
&nbsp;<%=Resource.getValue(local, "common", "comm.newreportRE")%>
</span>
</a>
</li>
<%}//}%>





<%=marqueeEnd%>
</ul>

<script language="JavaScript">
<!--
/*function jumpnewForRemind(myLeftUrl,myMainUrl){
	if(!_def_isDesignPage_){
		parent.parent.document.getElementById("content1").style.display='none';
		top.leftFrame.location.href=myLeftUrl;
		top.mainFrame.location.href=myMainUrl;
		parent.parent.document.getElementById("content2").style.display='';
	}
}
*/
//-->
</script>
<%}%>