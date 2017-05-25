<%@ include file="/public/include/xhtml1.jsp"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page import="com.whir.ezoffice.resource.bd.*"%>
<%@ page import="com.whir.org.manager.bd.*"%>
<%@ page import="com.whir.ezoffice.booksmanager.bd.*"%>
<%@ page import="com.whir.ezoffice.workflow.newBD.WorkFlowBD"%>
<%@ page import="java.util.List"%>
<%@ page import="java.lang.Long"%>
<%@ page import="com.whir.org.bd.organizationmanager.OrganizationBD "%>
<%@ page import="com.whir.ezoffice.workflow.vo.*"%>
<%@ page import="com.whir.ezoffice.customize.customermenu.bd.CustomerMenuDB"%>
<%@ page import="com.whir.ezoffice.customize.customermenu.bd.CustMenuWithOriginalBD,com.whir.ezoffice.officemanager.bd.EmployeeBD"%>
<%@ page import="com.whir.ezoffice.bpm.bd.BPMProcessBD "%>
<%
	response.setHeader("Cache-Control","no-store");
	response.setHeader("Pragma","no-cache");
	response.setDateHeader ("Expires", 0);
	
	String expNodeCode=request.getParameter("expNodeCode");
	//java中判断是否国产化客户端环境
	boolean isCOSClient = com.whir.component.util.SystemUtils.isCOS4Firefox4(request);//true-是 false-否

	int menuIndex=0;
	//此处公共业务逻辑
	ManagerBD managerBD = new ManagerBD();
	com.whir.ezoffice.workflow.newBD.ProcessBD procbd = new com.whir.ezoffice.workflow.newBD.ProcessBD();
	
	String domainId    = session.getAttribute("domainId")==null?"":session.getAttribute("domainId").toString();
	String userId      = session.getAttribute("userId").toString();
	String orgId       = session.getAttribute("orgId").toString();
	String orgIdString = session.getAttribute("orgIdString").toString();
	
	EmployeeBD empBD=new EmployeeBD();
	List singleEmpList = empBD.selectSingle(new Long(userId));
	String sidelineorgStr = "";
	if(singleEmpList!=null&&singleEmpList.size()>0){
		Object[] __empObj = (Object[])singleEmpList.get(0);
		com.whir.org.vo.usermanager.EmployeeVO __empVO = (com.whir.org.vo.usermanager.EmployeeVO)__empObj[0];
		sidelineorgStr = __empVO.getSidelineOrg()!=null?__empVO.getSidelineOrg():"";
	}

%>

<script type="text/javascript">
		var whirRootPath = "<%=rootPath%>";
		var preUrl = "<%=preUrl%>"; 
		var whir_browser = "<%=whir_browser%>"; 
	    var whir_agent = "<%=whir_agent%>"; 
	</script>

<script> 

 var zNodes =[

		//新版会议管理
		<%menuIndex++;%>
		 { id:"menuTitleBox", pId:0, name:"会议管理", open:true, target:'mainFrame',iconSkin:"fa fa"}
		 ,{ id:8100000001, pId:"menuTitleBox", name:"会议通知", expNodeCode:"newmeeting", target:'mainFrame',url:"<%=rootPath%>/newBoardRoom!bdroomMeetingNotice.action",iconSkin:"fa fa"}
		 ,{ id:8100000002, pId:"menuTitleBox", name:"普通会议室管理",target:'mainFrame',url:"",iconSkin:"fa fa"}
			,{ id:810000000201, pId:8100000002, name:"会议室预订",  target:'mainFrame',url:"<%=rootPath%>/newBoardRoom!boardRoomApplyView.action?init=0&type=dayView",iconSkin:"fa fa"}
			,{ id:810000000202, pId:8100000002, name:"使用记录",  target:'mainFrame',url:"<%=rootPath%>/newBoardRoom!boardroomUseRecordList.action",iconSkin:"fa fa"}
			 <%if(managerBD.hasRightTypeName(userId, "会议管理","维护") && isForbiddenPad){%>
			,{ id:810000000203, pId:8100000002, name:"会议室信息",  target:'mainFrame',url:"<%=rootPath%>/newBoardRoom!newBoardRoomView.action",iconSkin:"fa fa"}
			 <%}%>
		 ,{ id:8100000003, pId:"menuTitleBox", name:"视频会议室管理",target:'mainFrame',url:"",iconSkin:"fa fa"}
			,{ id:810000000301, pId:8100000003, name:"会议室预订",  target:'mainFrame',url:"<%=rootPath%>/newBoardRoom!videoBoardRoomApplyView.action?init=0&type=dayView",iconSkin:"fa fa"}
			,{ id:810000000302, pId:8100000003, name:"使用记录",  target:'mainFrame',url:"<%=rootPath%>/newBoardRoom!videoBoardroomUseRecordList.action",iconSkin:"fa fa"}
			 <%if(managerBD.hasRightTypeName(userId, "会议管理","维护") && isForbiddenPad){%>
			,{ id:810000000303, pId:8100000003, name:"会议室信息",  target:'mainFrame',url:"<%=rootPath%>/newBoardRoom!newVideoBoardRoomView.action",iconSkin:"fa fa"}
			 
		 ,{ id:8100000004, pId:"menuTitleBox", name:"会议统计",target:'mainFrame',url:"<%=rootPath%>/newBoardRoom!meetingNoticeUseRecordList.action?searchType=type",iconSkin:"fa fa"}
		 ,{ id:8100000005, pId:"menuTitleBox", name:"设置",iconSkin:"fa fa"}
			,{ id:810000000501, pId:8100000005, name:"会议类型",  target:'mainFrame',url:"<%=rootPath%>/newBoardRoom!newBoardRoomApplyTypeList.action",iconSkin:"fa fa"}
			,{ id:810000000502, pId:8100000005, name:"会议标签",  target:'mainFrame',url:"<%=rootPath%>/newBoardRoom!conferenceTagList.action",iconSkin:"fa fa"}
			,{ id:810000000503, pId:8100000005, name:"视频会议室分类",  target:'mainFrame',url:"<%=rootPath%>/newBoardRoom!videoBoardroomClassifyList.action",iconSkin:"fa fa"}
			,{ id:810000000504, pId:8100000005, name:"表单定义",iconSkin:"fa fa"}
			,{ id:81000000050401, pId:810000000504, name:"普通会议室表单",  target:'mainFrame',url:"<%=rootPath%>/EzForm!initFormList.action?wfModuleId=15",iconSkin:"fa fa"}
			,{ id:81000000050402, pId:810000000504, name:"会议通知表单",  target:'mainFrame',url:"<%=rootPath%>/EzForm!initFormList.action?wfModuleId=555",iconSkin:"fa fa"}
			,{ id:810000000505, pId:8100000005, name:"流程设置",iconSkin:"fa fa"}
				,{ id:81000000050501, pId:810000000505, name:"普通会议室申请流程",  target:'mainFrame',url:"<%=rootPath%>/ezflowprocess!ezFlowList.action?moduleId=15",iconSkin:"fa fa"}
				,{ id:81000000050502, pId:810000000505, name:"视频会议室申请流程",  target:'mainFrame',url:"<%=rootPath%>/ezflowprocess!ezFlowList.action?moduleId=888",iconSkin:"fa fa"}
				,{ id:81000000050503, pId:810000000505, name:"会议通知申请流程",  target:'mainFrame',url:"<%=rootPath%>/ezflowprocess!ezFlowList.action?moduleId=555",iconSkin:"fa fa"}
				,{ id:81000000050503, pId:810000000505, name:"会议签收申请流程",  target:'mainFrame',url:"<%=rootPath%>/ezflowprocess!ezFlowList.action?moduleId=17",iconSkin:"fa fa"}
			,{ id:810000000506, pId:8100000005, name:"通知模板定义",  click:"openWin({url:'<%=rootPath%>/public/iWebOfficeSign/Template/TemplateList.jsp?haveRight=yes&moduleType=meetingnotice',isResizable: 'true',width:800,height:600,isFull: true,winName:'_blank'});",iconSkin:"fa fa"}
			<%}%>

			<%menuIndex++;%>
			<%
				String menutype = "newMeetingManagement";
			%>
			<%@ include file="/platform/custom/customize/custLeftMenuUnderOriginal.jsp"%>
		   ];
		

	function whir_initMenu(){
		$.fn.zTree.init($("#treeDemo"), setting, zNodes);
			
		if('<%=expNodeCode%>'=="newmeeting"){
			OpenSubMenu('newmeeting');
		}
	}
</script>
<div class="wh-l-msg">
	<a class="clearfix"> <i class="fa fa-desktop fa-color"></i> <span>
			会议管理 </span> </a>
</div>
<div class="wh-l-con">
	<ul id="treeDemo" class="ztree"></ul>
</div>
