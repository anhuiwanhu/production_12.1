<%@ include file="/public/include/xhtml1.jsp"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>  
<%@ include file="/public/include/init.jsp"%>  

<%@ page import="com.whir.org.manager.bd.ManagerBD"%>
<%@ page import="com.whir.org.bd.organizationmanager.OrganizationBD "%>
<%@ page import="com.whir.org.bd.usermanager.UserBD"%>

<%@ page import="com.whir.ezoffice.customize.customermenu.bd.CustMenuWithOriginalBD" %>
<%@ page import="com.whir.ezoffice.customize.customermenu.bd.CustomerMenuDB" %>
<%@ page import="com.whir.ezoffice.netdisk.bd.NetdiskBD"%>
<%@ page import="com.whir.ezoffice.personalwork.person.bd.PersonOwnBD" %>
<%@ page import="com.whir.ezoffice.workmanager.worklog.bd.WorkLogBD"%>
<%@ page import="com.whir.ezoffice.workmanager.taskcenter.bd.TaskBD"%>
<%@ page import="com.whir.common.util.CommonUtils"%>
<%@ page import="com.whir.ezoffice.workmanager.leader.bd.LeaderEventBD"%>
<%@ page import="com.whir.i18n.Resource" %>

<%   
response.setHeader("Cache-Control","no-store");   
response.setHeader("Pragma","no-cache");   
response.setDateHeader ("Expires", 0);   
%>

<%
String portletSettingId = request.getParameter("portletSettingId");
String fouce = request.getParameter("fouce");
String expNodeCode=request.getParameter("expNodeCode");
String domainId = session.getAttribute("domainId")==null?"":session.getAttribute("domainId").toString();
String userId   = session.getAttribute("userId")==null?"":session.getAttribute("userId").toString();
String orgId   = session.getAttribute("orgId")==null?"":session.getAttribute("orgId").toString();
String userAccount   = session.getAttribute("userAccount")==null?"":session.getAttribute("userAccount").toString();
if(!"".equals(userId)){
    int menuIndex = 0;  
    
    // 点击主菜单上的"个人办公"，默认选中"任务中心"菜单项
    int openMenuIndex = 6;
    
    String choosenSubMenuId = "";
    String statusType = request.getParameter("statusType")==null?"":request.getParameter("statusType").toString();
    if("ezLucene".equals(statusType)){
        // 全文检索
        openMenuIndex = 0;
    } else if("personalInfo".equals(statusType)){
        // 个人信息
        openMenuIndex = 10;
        choosenSubMenuId = "3";
    } else if("personalPwd".equals(statusType)){
        // 修改密码
        openMenuIndex = 10;
        choosenSubMenuId = "1";
    } else if("workReport".equals(statusType)){
        // 工作汇报
        openMenuIndex = 5;
    } else if("calendar".equals(statusType)){
        // 日程
        openMenuIndex = 3;
        choosenSubMenuId = "1";
    } else if("task".equals(statusType)){
        // 任务
        openMenuIndex = 6;
    } else if("note".equals(statusType)){
        // 便签
        openMenuIndex = 7;
        choosenSubMenuId = "1";
    } else if("commonadd".equals(statusType)){
        // 常用网址
         openMenuIndex = 7;
        choosenSubMenuId = "4";
    } else if("pressdeal".equals(statusType)){
        // 催办督办
        openMenuIndex = 8;
        choosenSubMenuId = "1";
    }
    
    ManagerBD mBD = new ManagerBD();
    
    CustomerMenuDB cmBD = new CustomerMenuDB();
    String codes = ",workmanager_setup,workmanager_setup_password,workmanager_setup_personalinfo,workmanager_setup_commonprocess,"+
                   "workmanager_setup_option,workmanager_setup_workproxy,workmanager_setup_skin,"+
                   "workmanager_setup_workstatus,workmanager_setup_orgwrap,workmanager_setup_rmlogin,"+
                   "workmanager_linkman,workmanager_linkman_inner,workmanager_linkman_public,workmanager_linkman_private,"+
                   "workmanager_calendar,workmanager_worklog,workmanager_workreport,workmanager_task,workmanager_personaltools,"+
                   "workmanager_netdisk,workmanager_filedealwith,workmanager_netdisk,workmanager_pressdeal,Persononduty,workmanager_leaderevent,";
    String canShowMenus = cmBD.getShowMenu(codes, domainId);
    boolean flag=CommonUtils.isADCheckByUserAccount(userAccount);
    boolean authFlag0=cmBD.hasMenuAuth("workmanager_task",userId,orgId);
    //System.out.println("=====@personal_menu.jsp--[canShowMenus]=[" + canShowMenus + "]");
    
    /* Added by Qian Min for ezOFFICE 11.0.0.7 [BEGIN] */
    //if(canShowMenus.indexOf("workmanager_task") < 0 && authFlag0==true){
	if(!(canShowMenus.indexOf("workmanager_task")>=0 && cmBD.hasMenuAuth("workmanager_task",userId,orgId))||
		(canShowMenus.indexOf("workmanager_task") < 0 && authFlag0==true)){
        // "任务中心"模块被隐藏时，默认选中"全文检索"菜单项
        openMenuIndex = 0;
    }
    /* Added by Qian Min for ezOFFICE 11.0.0.7 [END] */
    
    /* 公共/个人联系人 [BEGIN] */
    PersonOwnBD obd = new PersonOwnBD();
    long userIdm = Long.parseLong(String.valueOf(session.getAttribute("userId")));
    Vector vec = obd.see(userIdm + "", "1", domainId);
    List tList = (List)vec.get(1);
    Vector vec2 = obd.see(userIdm + "", "0", domainId);
    List pList = (List)vec2.get(1);
    /* 公共/个人联系人 [END] */
    
    WorkLogBD worklogBD = new WorkLogBD();
    boolean newRight1 = worklogBD.hasRight(Long.valueOf(userId), "工作日志-项目分类", "维护"); // 判断项目分类是否有维护权限
    boolean newRight2 = newRight1;
    boolean newRight3 = worklogBD.hasRight(Long.valueOf(userId), "工作日志-项目设置", "维护"); // 判断项目设置是否有维护权限
    boolean newRight4 = newRight3;
    
    boolean newRight5 = worklogBD.hasRight(Long.valueOf(userId), "工作日志-日志查阅", "查看"); // 判断项目设置是否有添加权限
    
    TaskBD taskBD = new TaskBD();
    boolean newRight7 = taskBD.hasRight(Long.valueOf(userId), "任务中心-任务分类", "维护"); // 判断任务中心任务分类是否有维护权限
    boolean newRight8 = newRight7;
    
    boolean newRight9 = taskBD.hasRight(Long.valueOf(userId), "工作汇报-模板设置", "维护"); // 判断任务中心任务分类是否有维护权限
    boolean newRight10 = newRight9;
%>

   
    <script src="<%=rootPath%>/scripts/plugins/lhgdialog/lhgdialog.js?skin=idialog" type="text/javascript"></script>
	
	
<script>

//<!---日程script代码开始--->
		var eventSelfSearch = "<%=rootPath%>/EventAction!eventList.action?menuType=mine";//我的日程默认url
        //读取上次cookie访问值
                       if(readCookie("eventSelfSearch")!=null&&readCookie("eventSelfSearch")!="null"&&readCookie("eventSelfSearch")!=""&&readCookie("eventSelfSearch")!=" "){
                            eventSelfSearch = readCookie("eventSelfSearch");
                    
                       }
   
                        //读取cookie值
                        function readCookie(name){
                                var nameEQ = name + "=";
                                var ca = document.cookie.split(';');
                                for(var i=0;i < ca.length;i++){
                                    var c = ca[i];
                                    while (c.charAt(0)==' ') c = c.substring(1,c.length);
                                    if (c.indexOf(nameEQ) == 0)  return c.substring(nameEQ.length,c.length);
                                }
                             
                                return null;
                        }
						
                        
		//<!---日程script代码结束--->
			
		//<!---工作日志script代码开始--->	
		var workLogSelfSearchURL = "<%=rootPath%>/WorkLogAction!workLogList.action?menuType=mine";//我的日志默认url
                        var workLogUnderlingSearchURL = "<%=rootPath%>/WorkLogAction!workLogList.action?menuType=underling";//我的下属日志默认url
                        var workLogSearchURL = "<%=rootPath%>/WorkLogAction!workLogList.action?menuType=query";//日志查询默认url
                     //读取上次cookie访问值
                        if(readCookie("workLogSelfSearch")!=null&&readCookie("workLogSelfSearch")!="null"&&readCookie("workLogSelfSearch")!=""&&readCookie("workLogSelfSearch")!=" "){
                            workLogSelfSearchURL = readCookie("workLogSelfSearch");
                    
                       }
                        if(readCookie("workLogUnderlingSearch")!=null&&readCookie("workLogUnderlingSearch")!="null"&&readCookie("workLogUnderlingSearch")!=""&&readCookie("workLogUnderlingSearch")!=" "){
                            workLogUnderlingSearchURL = readCookie("workLogUnderlingSearch");
                       
                        }
                        if(readCookie("workLogSearch")!=null&&readCookie("workLogSearch")!="null"&&readCookie("workLogSearch")!=""&&readCookie("workLogSearch")!=" "){
                            workLogSearchURL = readCookie("workLogSearch");
                        
                        }
               
               
			
		//<!---工作日志script代码结束--->		
						
	  var zNodes =[
	  // <!-- 全文检索 [BEGIN] -->
		   {id:1010929365, pId:-1 ,expNodeCode:"search",iconSkin:"fa fa-search fa" ,name:"<%=Resource.getValue(whir_locale, "bbs", "bbs.lucene")%>", target:'mainFrame',url:"<%=rootPath%>/InfoList!retrievalList.action?channelType=0&userChannelName=信息管理&userDefine=0&type=all');"}
		   
	   //<!-- 我的文档 [BEGIN] -->
        <%  
            boolean authFlag=cmBD.hasMenuAuth("workmanager_netdisk",userId,orgId);
            if(canShowMenus.indexOf("workmanager_netdisk") !=-1 && authFlag==true ){
                UserBD ubd = new UserBD();
                if(ubd.getNetDiskSize(userId)!=0){
                    NetdiskBD netdiskBD = new NetdiskBD();
                    Map folderMap = netdiskBD.getFolderMapByUserId(userId);
        %>       
		    <%menuIndex++;%>
			 ,{id:"menuTitleBox<%=menuIndex%>", pId:-1, name:"<%=Resource.getValue(whir_locale, "personalwork", "webdisk.MyDocuments")%>", target:'mainFrame',iconSkin:"fa fa-cog fa"}
			 ,{id:'A1',iconSkin:"fa fa-cog fa", pId:"menuTitleBox<%=menuIndex%>", name:"<%=Resource.getValue(whir_locale, "personalwork", "webdisk.MyDocuments")%>", url:"<%=rootPath%>/netdisk!list.action", target:"mainFrame" }
             ,{id:'A2',iconSkin:"fa fa",  pId:"menuTitleBox<%=menuIndex%>", name:"<%=Resource.getValue(whir_locale, "personalwork", "webdisk.SharedDocuments")%>", url:"<%=rootPath%>/netdisk!sharedlist.action", target:"mainFrame" }
             ,{id:'A3', iconSkin:"fa fa", pId:"menuTitleBox<%=menuIndex%>", name:"<%=Resource.getValue(whir_locale, "personalwork", "webdisk.recyclebin")%>", url:"<%=rootPath%>/netdisk!listdelete.action", target:"mainFrame" }
			<%
                                if(folderMap!=null && folderMap.size()>0){
                                    Set _s = folderMap.keySet();
                                    Iterator _itor = _s.iterator();
                                    while(_itor.hasNext()){
                                        String _key = (String)_itor.next();
                                        Map _value = (Map)folderMap.get(_key);
                                        String sNodeId   = _key.substring(0,_key.indexOf("-"));
                                        String sNodeName = _key.substring(_key.indexOf("-")+1);
                                        String sNodeUrl  = rootPath+"/netdisk!list.action?currentid=" + sNodeId;
               %>
			   ,{id:"<%=sNodeId%>", pId:'A1', name:HtmlEncode("<%=sNodeName%>"), url:"<%=sNodeUrl%>", target:"mainFrame",iconSkin:"fa fa" }
			 
			  <%
                                    }
                                }
                            %>
				 <%
                }
            }
        %>			
			
		//<!-- 日程 [BEGIN] -->
        <%  
            boolean authFlag6=cmBD.hasMenuAuth("workmanager_calendar",userId,orgId);
            if(canShowMenus.indexOf("workmanager_calendar")!=-1 && authFlag6==true){
        %>
                <%menuIndex++;%>
			 ,{id:"menuTitleBox<%=menuIndex%>", pId:-1,iconSkin:"fa fa-cog fa", name:"<%=Resource.getValue(whir_locale, "personalwork", "schedule.schedule")%>", target:'mainFrame'}
			  
                         
                       //<!--
                            ,{id:10000011,expNodeCode:"newEvent", pId:"menuTitleBox<%=menuIndex%>", name:"<%=Resource.getValue(whir_locale, "personalwork", "schedule.mySchedule")%>", url:eventSelfSearch, target:"mainFrame",iconSkin:"fa fa"}
                            ,{id:10000012, pId:"menuTitleBox<%=menuIndex%>", name:"<%=Resource.getValue(whir_locale, "personalwork", "schedule.subordinateSchedule")%>", url:"<%=rootPath%>/EventAction!eventList.action?menuType=underling", target:"mainFrame",iconSkin:"fa fa"}
                        <%
                            //具有 领导日程-新增 权限或 领导日程-维护权限 可看到此菜单
                            if(mBD.hasRight(userId, "ldrc*01*01") || mBD.hasRight(userId, "ldrc*01*02")){
                        %>
                        <%
                            }
                        %>
                            ,{id:10000013, pId:"menuTitleBox<%=menuIndex%>", name:"<%=Resource.getValue(whir_locale, "personalwork", "schedule.leaderSchedule")%>", url:"<%=rootPath%>/EventLeaderAction!leaderEventDisplay.action?displayType=workweek", target:"mainFrame",iconSkin:"fa fa"}
                        <%
                            if(isForbiddenPad){
                                // "日程共享"栏目在IPAD上不显示
                                // Added by Qian Min for ezOFFICE 11.0.0.11 at 2013-10-12 
                        %>
                                ,{id:10000014, pId:"menuTitleBox<%=menuIndex%>", name:"<%=Resource.getValue(whir_locale, "personalwork", "schedule.share")%>", url:"<%=rootPath%>/EventShareAction!eventShareList.action", target:"mainFrame",iconSkin:"fa fa"}
                        <%
                            }
                        %>
                            ,{id:10000015, pId:"menuTitleBox<%=menuIndex%>", name:"<%=Resource.getValue(whir_locale, "personalwork", "schedule.search")%>", url:"<%=rootPath%>/EventAction!eventList.action?menuType=query", target:"mainFrame",iconSkin:"fa fa"}
                        //-->  
                      
				   <%
				}
			%>
			//<!-- 日程 [END] -->
		   //<!-- 领导日程 [BEGIN] -->
           <%	
			  LeaderEventBD leaderEventBD = new LeaderEventBD();
			  boolean isOperateLeader=leaderEventBD.isOperateLeader(Long.valueOf(userId));//当前用户是否是领导日程维护人
			  boolean isSetedLeader=leaderEventBD.isSetedLeader(Long.valueOf(userId));//当前用户是否是领导日程设置中设置的相关领导
            boolean authFlag33=cmBD.hasMenuAuth("workmanager_leaderevent",userId,orgId);	
            if(canShowMenus.indexOf("workmanager_leaderevent")!=-1 && authFlag33==true){			  
          %>
                <%menuIndex++;%>
			 ,{id:"menuTitleBox<%=menuIndex%>", pId:-1,iconSkin:"fa fa-cog fa", name:"日程管理", target:'mainFrame'}
               <%if(mBD.hasRight(userId,"leader*01*01")||isOperateLeader||mBD.hasRight(userId,"leader*01*02")){ %>
			   ,{id:10000011112,expNodeCode:"leader", pId:"menuTitleBox<%=menuIndex%>", name:"领导日程", url:"<%=rootPath%>/LeaderAction!displayByWeek.action?menuType=leader", target:"mainFrame",iconSkin:"fa fa"}                     
			   <%}%>	
               ,{id:10000011111,expNodeCode:"my", pId:"menuTitleBox<%=menuIndex%>", name:"我的日程", url:"<%=rootPath%>/LeaderAction!displayByWeek.action?menuType=mine", target:"mainFrame",iconSkin:"fa fa"}			  
               <% if(mBD.hasRight(userId,"leader*01*02")){%>			    
			  ,{id:10000011113, pId:"menuTitleBox<%=menuIndex%>", name:"领导日程设置", url:"<%=rootPath%>/LeaderActionSet!leaderSetList.action", target:"mainFrame",iconSkin:"fa fa"}                                           
		     <%}%>
              ,{id:10000011114, pId:"menuTitleBox<%=menuIndex%>", name:"权限设置", url:"<%=rootPath%>/custormerbiz!goRightMenu.action?menuId=173121", target:"mainFrame",iconSkin:"fa fa"}
			//<!-- 领导日程 [END] -->
			<%}%>
			//<!-- 工作日志 [BEGIN] -->
			
			<%  
				boolean authFlag7=cmBD.hasMenuAuth("workmanager_worklog",userId,orgId);
				if(canShowMenus.indexOf("workmanager_worklog")!=-1 && authFlag7==true){
			%>
                <%menuIndex++;%> 
			  ,{id:"menuTitleBox<%=menuIndex%>", pId:-1,iconSkin:"fa fa-cog fa", name:"<%=Resource.getValue(whir_locale, "personalwork", "personalwork.worklog")%>", target:"mainFrame"}
			  	,{id:10000016, pId:"menuTitleBox<%=menuIndex%>", name:"<%=Resource.getValue(whir_locale, "personalwork", "personalwork.myworklog")%>", url:workLogSelfSearchURL, target:"mainFrame",iconSkin:"fa fa"}
                ,{id:10000017, pId:"menuTitleBox<%=menuIndex%>", name:"<%=Resource.getValue(whir_locale, "personalwork", "personalwork.subworklog")%>", url:workLogUnderlingSearchURL, target:"mainFrame",iconSkin:"fa fa"}
                        <%
                            if (newRight5){
                        %>
                                ,{id:10000017, pId:"menuTitleBox<%=menuIndex%>", name:"<%=Resource.getValue(whir_locale, "personalwork", "personalwork.logview")%>", url:workLogSearchURL, target:"mainFrame",iconSkin:"fa fa"}
                        <%
                            }
                        %>
					  <%
				}
			%>
      //  <!-- 工作日志 [END] -->
			 
		// <!-- 工作汇报 [BEGIN] -->
        <%  
            boolean authFlag8=cmBD.hasMenuAuth("workmanager_workreport",userId,orgId);
            if(canShowMenus.indexOf("workmanager_workreport")!=-1 && authFlag8==true){
        %>
                <%menuIndex++;%>
			 ,{id:"menuTitleBox<%=menuIndex%>", expNodeCode:"REworkReport",pId:-1,iconSkin:"fa fa-cog fa", name:"<%=Resource.getValue(whir_locale, "personalwork", "personalwork.workreport")%>", target:"mainFrame"}
			  ,{id:'A111', iconSkin:"fa fa-cog fa",pId:"menuTitleBox<%=menuIndex%>", name:"<%=Resource.getValue(whir_locale, "personalwork", "personalwork.myreport")%>", url:"", target:"mainFrame"}
                                ,{id:'B1',expNodeCode:"my1", pId:'A111', name:"<%=Resource.getValue(whir_locale, "personalwork", "personalwork.weekreport")%>", url:"<%=rootPath%>/WorkReportAction!workReportList.action?menuType=mine&reportType=week", target:"mainFrame",iconSkin:"fa fa"}
                                ,{id:'B2',expNodeCode:"my2", pId:'A111', name:"<%=Resource.getValue(whir_locale, "personalwork", "personalwork.monthreport")%>", url:"<%=rootPath%>/WorkReportAction!workReportList.action?menuType=mine&reportType=month", target:"mainFrame",iconSkin:"fa fa"}
                                ,{id:'B3',expNodeCode:"my3", pId:'A111', name:"<%=Resource.getValue(whir_locale, "personalwork", "personalwork.otherreport")%>", url:"<%=rootPath%>/WorkReportAction!workReportList.action?menuType=mine&reportType=other", target:"mainFrame",iconSkin:"fa fa"}
                            ,{id:'A2',iconSkin:"fa fa-cog fa", pId:"menuTitleBox<%=menuIndex%>", name:"<%=Resource.getValue(whir_locale, "personalwork", "personalwork.subreport")%>", url:"", target:"mainFrame",iconSkin:"fa fa"}
                                ,{id:'B7', expNodeCode:"newReport", pId:'A2', name:"新汇报", url:"<%=rootPath%>/WorkReportAction!workReportList.action?menuType=underling&reportType=newReport", target:"mainFrame",iconSkin:"fa fa"}
								,{id:'B4', expNodeCode:"under1", pId:'A2', name:"<%=Resource.getValue(whir_locale, "personalwork", "personalwork.weekreport")%>", url:"<%=rootPath%>/WorkReportAction!workReportList.action?menuType=underling&reportType=week", target:"mainFrame",iconSkin:"fa fa"}
                                ,{id:'B5', expNodeCode:"under2", pId:'A2', name:"<%=Resource.getValue(whir_locale, "personalwork", "personalwork.monthreport")%>", url:"<%=rootPath%>/WorkReportAction!workReportList.action?menuType=underling&reportType=month", target:"mainFrame",iconSkin:"fa fa"}
                                ,{id:'B6',expNodeCode:"newWorkReport", pId:'A2', name:"<%=Resource.getValue(whir_locale, "personalwork", "personalwork.otherreport")%>", url:"<%=rootPath%>/WorkReportAction!workReportList.action?menuType=underling&reportType=other", target:"mainFrame",iconSkin:"fa fa"}
                            <%
                                //具有 领导日程-新增 权限或 领导日程-维护权限 可看到此菜单
                                if(mBD.hasRight(userId, "04*02*01")){
                            %>
                                    ,{id:'A3',iconSkin:"fa fa-cog fa", pId:"menuTitleBox<%=menuIndex%>", name:"<%=Resource.getValue(whir_locale, "personalwork", "personalwork.reportview")%>", url:"", target:"mainFrame"}
                                        ,{id:'B7', pId:'A3', name:"<%=Resource.getValue(whir_locale, "personalwork", "personalwork.weekreport")%>", url:"<%=rootPath%>/WorkReportAction!workReportList.action?menuType=query&reportType=week", target:"mainFrame",iconSkin:"fa fa"}
                                        ,{id:'B8', pId:'A3', name:"<%=Resource.getValue(whir_locale, "personalwork", "personalwork.monthreport")%>", url:"<%=rootPath%>/WorkReportAction!workReportList.action?menuType=query&reportType=month", target:"mainFrame",iconSkin:"fa fa"}
                                        ,{id:'B9', pId:'A3', name:"<%=Resource.getValue(whir_locale, "personalwork", "personalwork.otherreport")%>", url:"<%=rootPath%>/WorkReportAction!workReportList.action?menuType=query&reportType=other", target:"mainFrame",iconSkin:"fa fa"}
                            <%
                                }
                            %>
                            <% 
                                if(isForbiddenPad && (mBD.hasRightTypeName(userId, "工作汇报-模板设置", "新增")
                                    || mBD.hasRightTypeName(userId, "工作汇报-模板设置", "维护"))){
                                    // "模板设置"栏目在IPAD上不显示
                                    // Added by Qian Min for ezOFFICE 11.0.0.11 at 2013-10-12 
                            %>
                                    ,{id:'A4', pId:"menuTitleBox<%=menuIndex%>", name:"<%=Resource.getValue(whir_locale, "personalwork", "personalwork.templateset")%>", url:"<%=rootPath%>/WorkReportTemplateAction!workReportTemplateList.action", target:"mainFrame",iconSkin:"fa fa"}
                            <%
                                }
                            %>
                                ,{id:'A5',iconSkin:"fa fa-cog fa", pId:"menuTitleBox<%=menuIndex%>", name:"<%=Resource.getValue(whir_locale, "personalwork", "personalwork.projectreport")%>", url:"", target:"mainFrame",iconSkin:"fa fa"}
                                ,{id:'B10', pId:'A5', name:"<%=Resource.getValue(whir_locale, "personalwork", "personalwork.sendreport")%>", url:"<%=rootPath%>/WorkReportAction!listProj.action?menuType=mine", target:"mainFrame",iconSkin:"fa fa"}
                                ,{id:'B11', pId:'A5', name:"<%=Resource.getValue(whir_locale, "personalwork", "personalwork.receivereport")%>", url:"<%=rootPath%>/WorkReportAction!listProj.action?menuType=underling", target:"mainFrame",iconSkin:"fa fa"}
				 <%
            }
        %>
       // <!-- 工作汇报 [END] -->
		
		// <!-- 任务中心 [BEGIN] -->
        <%  
            if(canShowMenus.indexOf("workmanager_task")!=-1 && cmBD.hasMenuAuth("workmanager_task",userId,orgId)){
        %>
                <%menuIndex++;%>
               ,{id:"menuTitleBox<%=menuIndex%>", pId:-1, iconSkin:"fa fa-cog fa",name:"<%=Resource.getValue(whir_locale, "personalwork", "personalwork.taskcenter")%>", target:"mainFrame"} 
			     ,{id:10000019,expNodeCode:"newTask", pId:"menuTitleBox<%=menuIndex%>", name:"<%=Resource.getValue(whir_locale, "personalwork", "personalwork.mytask")%>", url:"<%=rootPath%>/taskCenter!selectPrincipalTask.action", target:"mainFrame",iconSkin:"fa fa"}
                            <%
                              if(mBD.hasRightTypeName( userId,"任务中心-任务安排", "新增")){
                            %>
                            ,{id:100000110, pId:"menuTitleBox<%=menuIndex%>", name:"<%=Resource.getValue(whir_locale, "personalwork", "personalwork.taskarrange")%>", url:"<%=rootPath%>/taskCenter!selectSettleTask.action", target:"mainFrame",iconSkin:"fa fa"}
                            ,{id:100000111, pId:"menuTitleBox<%=menuIndex%>", name:"<%=Resource.getValue(whir_locale, "personalwork", "personalwork.regulartask")%>", url:"<%=rootPath%>/taskCenter!selectPeriodicityTask.action", target:"mainFrame",iconSkin:"fa fa"}
                            <%}%>
                            ,{id:100000112,expNodeCode:"watingcheckTask", pId:"menuTitleBox<%=menuIndex%>", name:"<%=Resource.getValue(whir_locale, "personalwork", "taskcenter.evaluation")%>", url:"<%=rootPath%>/taskCenter!taskCheckList.action", target:"mainFrame",iconSkin:"fa fa"}
                            <%
                              if(mBD.hasRightTypeName( userId,"任务中心-任务查询", "查询")){
                            %>
                            ,{id:100000113, pId:"menuTitleBox<%=menuIndex%>", name:"<%=Resource.getValue(whir_locale, "personalwork", "personalwork.tasksearch")%>", url:"", target:"mainFrame",iconSkin:"fa fa"}
                            ,{id:51, pId:100000113, name:"<%=Resource.getValue(whir_locale, "personalwork", "personalwork.distask")%>", url:"<%=rootPath%>/taskCenter!selectSearchTask.action", target:"mainFrame",iconSkin:"fa fa"}
                            ,{id:52, pId:100000113, name:"<%=Resource.getValue(whir_locale, "personalwork", "personalwork.receivetask")%>", url:"<%=rootPath%>/taskCenter!selectSearchTask.action?receive=receive", target:"mainFrame",iconSkin:"fa fa"}
                            <%}
                              if ((newRight7)||(newRight8)){
                            %>
                            ,{id:100000114, pId:"menuTitleBox<%=menuIndex%>", name:"<%=Resource.getValue(whir_locale, "personalwork", "personalwork.taskcategory")%>", url:"<%=rootPath%>/taskCenter!selectAllTaskClass.action", target:"mainFrame",iconSkin:"fa fa"}
                            <%}%>
				<%
            }
        %>         	
		 //<!-- 任务中心 [END] -->
		 		
		// <!-- 个人工具 [BEGIN] -->
        <%  
            boolean authFlag10=cmBD.hasMenuAuth("workmanager_personaltools",userId,orgId);
            if(canShowMenus.indexOf("workmanager_personaltools")!=-1 && authFlag10==true){
        %>
                <%menuIndex++;%>		
			,{id:"menuTitleBox<%=menuIndex%>", pId:-1,iconSkin:"fa fa-cog fa", name:"<%=Resource.getValue(whir_locale, "personalwork", "personalwork.personaltool")%>", target:"mainFrame"}
			 ,{id:100000115, pId:"menuTitleBox<%=menuIndex%>", name:"<%=Resource.getValue(whir_locale, "personalwork", "personalwork.note")%>", url:"<%=rootPath%>/NotePaperAction!notePaperList.action", target:"mainFrame",iconSkin:"fa fa"}
                            ,{id:100000116, pId:"menuTitleBox<%=menuIndex%>", name:"<%=Resource.getValue(whir_locale, "personalwork", "personalwork.notebook")%>", url:"<%=rootPath%>/NoteBookAction!noteBookList.action", target:"mainFrame",iconSkin:"fa fa"}
                           // ,{id:100000117,  pId:"menuTitleBox<%=menuIndex%>", name:"<%=Resource.getValue(whir_locale, "personalwork", "personalwork.diary")%>", url:"<%=rootPath%>/DiaryAction!diaryList.action", target:"mainFrame",iconSkin:"fa fa"}
                           // ,{id:100000118, pId:"menuTitleBox<%=menuIndex%>", name:"<%=Resource.getValue(whir_locale, "personalwork", "personalwork.commonadd")%>", url:"<%=rootPath%>/AddressAction!addressList.action", target:"mainFrame",iconSkin:"fa fa"}
                           // ,{id:100000119, pId:"menuTitleBox<%=menuIndex%>", name:"<%=Resource.getValue(whir_locale, "personalwork", "personalwork.forcalendar")%>", url:"<%=rootPath%>/modules/personal/calendar/personalUtil_calendar.jsp", target:"mainFrame",iconSkin:"fa fa"}
			 <%
            }
        %>
        //<!-- 个人工具 [END] -->
		
		
		// <!-- 催办管理 [BEGIN] -->
        <%  
            boolean authFlag11=cmBD.hasMenuAuth("workmanager_pressdeal",userId,orgId);
            if(canShowMenus.indexOf("workmanager_pressdeal")!=-1 && authFlag11==true){
        %>
                <%menuIndex++;%>	
			,{id:"menuTitleBox<%=menuIndex%>", pId:-1,iconSkin:"fa fa-cog fa", name:"<%=Resource.getValue(whir_locale, "personalwork", "pressmanage")%>", target:"mainFrame"}	
			 ,{id:1000001110,expNodeCode:"pressdeal", pId:"menuTitleBox<%=menuIndex%>", name:"<%=Resource.getValue(whir_locale, "personalwork", "pressmanage.receive")%>", url:"<%=rootPath%>/PressManageAction!receivePressList.action", target:"mainFrame",iconSkin:"fa fa"}
                            ,{id:1000001111, pId:"menuTitleBox<%=menuIndex%>", name:"<%=Resource.getValue(whir_locale, "personalwork", "pressmanage.send")%>", url:"<%=rootPath%>/PressManageAction!sendPressList.action", target:"mainFrame",iconSkin:"fa fa"}
                            ,{id:1000001112,expNodeCode:"pressFeedback", pId:"menuTitleBox<%=menuIndex%>", name:"<%=Resource.getValue(whir_locale, "personalwork", "pressmanage.feedback")%>", url:"<%=rootPath%>/PressManageAction!pressFeedbackList.action", target:"mainFrame",iconSkin:"fa fa"}
			 <%
            }
        %>
        //<!-- 催办管理 [END] -->
        
       // <!-- 人员去向 [BEGIN] -->
        <%
            if(canShowMenus.indexOf("Persononduty")!=-1 && cmBD.hasMenuAuth("Persononduty",userId,orgId)){
        %>
                <%menuIndex++;%>	
			//,{id:"menuTitleBox<%=menuIndex%>", pId:-1,iconSkin:"fa fa-cog fa", name:"<%=Resource.getValue(whir_locale, "personalwork", "persononduty")%>", target:"mainFrame"}
			// ,{id:1000001113, pId:"menuTitleBox<%=menuIndex%>", name:"<%=Resource.getValue(whir_locale, "personalwork", "persononduty.selfdep")%>", url:"<%=rootPath%>/PersonondutyAction!ondutyList.action", target:"mainFrame",iconSkin:"fa fa"}
                        <%
                            if(mBD.hasRight(userId, "04*10*01")){
                        %>
                               // ,{id:1000001114, pId:"menuTitleBox<%=menuIndex%>", name:"<%=Resource.getValue(whir_locale, "personalwork", "persononduty.search")%>", url:"<%=rootPath%>/PersonondutyAction!ondutySearchList.action", target:"mainFrame",iconSkin:"fa fa"}
                               // ,{id:1000001115, pId:"menuTitleBox<%=menuIndex%>", name:"<%=Resource.getValue(whir_locale, "personalwork", "persononduty.destinationStat")%>", url:"<%=rootPath%>/PersonondutyAction!ondutyStatisticList.action", target:"mainFrame",iconSkin:"fa fa"}
                        <%
                            }
                        %>
                        <%
                            if(isForbiddenPad && mBD.hasRight(userId, "04*11*01")){
                                // "去向设置"栏目在IPAD上不显示
                                // Added by Qian Min for ezOFFICE 11.0.0.11 at 2013-10-12 
                        %>
                               // ,{id:1000001116, pId:"menuTitleBox<%=menuIndex%>", name:"<%=Resource.getValue(whir_locale, "personalwork", "persononduty.destinationSetup")%>", url:"<%=rootPath%>/PersonondutySetAction!userStateSetList.action", target:"mainFrame",iconSkin:"fa fa"}
                        <%
                            }
                        %>
			<%
            }
        %>
       // <!-- 人员去向 [END] -->	
		
		//<!-- 个人设置 [BEGIN] -->
        <%  
            boolean authFlag12=cmBD.hasMenuAuth("workmanager_setup",userId,orgId);
            if(canShowMenus.indexOf("workmanager_setup")!=-1 && authFlag12==true){
        %>
                <%menuIndex++;%>	
			,{id:"menuTitleBox<%=menuIndex%>", pId:-1, iconSkin:"fa fa-cog fa",name:"<%=Resource.getValue(whir_locale, "personalwork", "personalwork.personalsetup")%>", target:"mainFrame"}	
			<%  
                            boolean authFlag13=cmBD.hasMenuAuth("workmanager_setup_password",userId,orgId);
                            if(canShowMenus.indexOf("workmanager_setup_password")>=0 && flag==false && authFlag13==true){
                        %>
                                ,{id:1000001117,expNodeCode:"personalPwd", pId:"menuTitleBox<%=menuIndex%>", name:"<%=Resource.getValue(whir_locale, "personalwork", "personalset.passwordmodi")%>", url:"<%=rootPath%>/MyInfoAction!modiMyPassword.action", target:"mainFrame",iconSkin:"fa fa"}
                        <%
                            }
                        %>
                        <%  
                            boolean authFlag14=cmBD.hasMenuAuth("workmanager_setup_commonprocess",userId,orgId);
                            if(canShowMenus.indexOf("workmanager_setup_commonprocess")>=0 && authFlag14==true){
                        %>
                                ,{id:1000001118, pId:"menuTitleBox<%=menuIndex%>", name:"<%=Resource.getValue(whir_locale, "personalwork", "personalwork.commonprocess")%>", url:"/defaultroot/bpmscope!canStart.action?myCommon=1&moduleId=1", target:"mainFrame",iconSkin:"fa fa"}
                        <%
                            }
                        %>
                        <%  
                            boolean authFlag15=cmBD.hasMenuAuth("workmanager_setup_personalinfo",userId,orgId);
                            if(canShowMenus.indexOf("workmanager_setup_personalinfo")>=0 && authFlag15==true){
                        %>
                                ,{id:1000001119, expNodeCode:"myInfo",pId:"menuTitleBox<%=menuIndex%>", name:"<%=Resource.getValue(whir_locale, "personalwork", "personalwork.personalinfo")%>", url:"<%=rootPath%>/MyInfoAction!modiMyInfo.action", target:"mainFrame",iconSkin:"fa fa"}
                        <%
                            }
                        %>
                        <%
                            if(isForbiddenPad){
                                // "个人首页"栏目在IPAD上不显示
                                // Added by Qian Min for ezOFFICE 11.0.0.11 at 2013-10-12 
                        %>
                                ,{id:1000001120,expNodeCode:"selfLayout", pId:"menuTitleBox<%=menuIndex%>", name:"<%=Resource.getValue(whir_locale, "personalwork", "personalwork.personalHomepage")%>", url:"<%=rootPath%>/PortalLayout!homePage.action?type=personal", target:"mainFrame",iconSkin:"fa fa"}
                        <%
                            }
                        %>
                        <%  
                             boolean authFlag16=cmBD.hasMenuAuth("workmanager_setup_option",userId,orgId);
                            if(canShowMenus.indexOf("workmanager_setup_option")>=0 && authFlag16==true){
                        %>
                                ,{id:1000001121, pId:"menuTitleBox<%=menuIndex%>", name:"<%=Resource.getValue(whir_locale, "personalwork", "personalwork.commonuse")%>", url:"<%=rootPath%>/OfficalDictionAction!OfficalDictionList.action", target:"mainFrame",iconSkin:"fa fa"}
                        <%
                            }
                        %>
						,{id:10000011211, pId:"menuTitleBox<%=menuIndex%>", name:"我的标签", url:"<%=rootPath%>/InfoTagAction!personalTagPage.action", target:"mainFrame",iconSkin:"fa fa"}
                        <%  
                            boolean authFlag17=cmBD.hasMenuAuth("workmanager_setup_workproxy",userId,orgId);
                            if(canShowMenus.indexOf("workmanager_setup_workproxy")>=0 && authFlag17==true){
                        %>
                                ,{id:1000001122, pId:"menuTitleBox<%=menuIndex%>", name:"<%=Resource.getValue(whir_locale, "personalwork", "personalwork.workagent")%>", url:"<%=rootPath%>/bpmproxy!fileList.action?from=my", target:"mainFrame",iconSkin:"fa fa"}
                        <%
                            }
                        %>
                           
							
                        <%  
                             boolean authFlag18=cmBD.hasMenuAuth("workmanager_setup_orgwrap",userId,orgId);
                            if(canShowMenus.indexOf("workmanager_setup_orgwrap")>=0 && authFlag18==true){
                        %>
                                ,{id:1000001125, pId:"menuTitleBox<%=menuIndex%>", name:"<%=Resource.getValue(whir_locale, "personalwork", "personalwork.Depshow")%>", url:"<%=rootPath%>/OrgWrapAction!modiOrgWrap.action", target:"mainFrame",iconSkin:"fa fa"}
                        <%
                            }
                        %>
                        <%  
                            boolean authFlag19=cmBD.hasMenuAuth("workmanager_setup_skin",userId,orgId);
                            if(canShowMenus.indexOf("workmanager_setup_skin")>=0 && authFlag19==true){
                        %>
                                ,{id:1000001126, pId:"menuTitleBox<%=menuIndex%>", name:"<%=Resource.getValue(whir_locale, "personalwork", "personalwork.skinmodify")%>", url:"", target:"", click:"modiMySkinSC();",iconSkin:"fa fa"}
                        <%
                            }
                        %>
                        <%  
                            boolean authFlag20=cmBD.hasMenuAuth("workmanager_setup_workstatus",userId,orgId);
                            if(canShowMenus.indexOf("workmanager_setup_workstatus")>=0 && authFlag20==true){
                        %>
                                ,{id:1000001127, pId:"menuTitleBox<%=menuIndex%>", name:"<%=Resource.getValue(whir_locale, "personalwork", "personalwork.workstatus")%>", url:"<%=rootPath%>/StatusAction!statusList.action", target:"mainFrame",iconSkin:"fa fa"} 
                            <%
                                if(mBD.hasRight(userId, "grzt*01*01")){
                            %>
                                    ,{id:1000001128, pId:"menuTitleBox<%=menuIndex%>", name:"<%=Resource.getValue(whir_locale, "personalwork", "status.setupSearch")%>", url:"<%=rootPath%>/StatusAction!statusSearchList.action", target:"mainFrame",iconSkin:"fa fa"} 
                            <%
                                }
                            %>
                        <%
                            }
                        %>
                            ,{id:1000001129, pId:"menuTitleBox<%=menuIndex%>", name:"<%=Resource.getValue(whir_locale, "personalwork", "Unifiedlogin.AccountManagement")%>", url:"<%=rootPath%>/Ldap!initLdap.action", target:"mainFrame",iconSkin:"fa fa"} 
                        <%  
                             boolean authFlag21=cmBD.hasMenuAuth("workmanager_setup_rmlogin",userId,orgId);
                            if(canShowMenus.indexOf("workmanager_setup_rmlogin")>=0 && authFlag21==true){
                        %>
                                ,{id:1000001130, pId:"menuTitleBox<%=menuIndex%>", name:"<%=Resource.getValue(whir_locale, "personalwork", "personal.setting.otherSetup")%>", url:"<%=rootPath%>/MyInfoAction!modiMyOtherSetup.action", target:"mainFrame",iconSkin:"fa fa"} 
                        <%
                            }
                        %>	
				
				 <%
            }
        %>
        //<!-- 个人设置 [END] -->
        
        <%menuIndex++;%>
        <%
              String menutype = "workmanager";
        %>
        <%@ include file="/platform/custom/customize/custLeftMenuUnderOriginal.jsp"%>
				
				
				
				
				
					 
		   ];
		     /* $(document).ready(function(){
            $.fn.zTree.init($("#treeDemo"), setting, zNodes);
        });*/
         function whir_initMenu(){
				 $.fn.zTree.init($("#treeDemo"), setting, zNodes);
				 $(function(){
					if('<%=portletSettingId%>'=="sso"){
						OpenCloseSubMenu(1000001129);
					}else if('<%=portletSettingId%>'=="commonwebaddr"){
						OpenCloseSubMenu(100000118);//常用网址 
					} else if('<%=portletSettingId%>'=="mycanlendar"){
						OpenCloseSubMenu(10000011);//我的日程
					}else if('<%=portletSettingId%>'=="mynotes"){
						OpenCloseSubMenu(100000115);//我的便签
					}else if('<%=portletSettingId%>'=="press"){
						OpenCloseSubMenu(1000001110);//催办流程
					}else if('<%=portletSettingId%>'=="scheduledtask"){
						OpenCloseSubMenu(100000110);//安排的任务
					}else if('<%=portletSettingId%>'=="workingtask"){
						OpenCloseSubMenu(10000019);//我的任务
					}
					else if('<%=portletSettingId%>'=="expertView"){
						OpenCloseSubMenu(1010929365);//全文检索
					}
					else if('<%=expNodeCode%>'=="pressdeal"){
						OpenSubMenu('pressdeal');
					}
					else if('<%=expNodeCode%>'=="search"){
						OpenSubMenu('search');
					}
					else if('<%=expNodeCode%>'=="myInfo"){
						OpenSubMenu('myInfo');
					}
					else if('<%=expNodeCode%>'=="newTask"){
						OpenSubMenu('newTask');
					}
					else if('<%=expNodeCode%>'=="newEvent"){
						OpenSubMenu('newEvent');
					}
					else if('<%=expNodeCode%>'=="watingcheckTask"){
						OpenSubMenu('watingcheckTask');
					}
					else if('<%=expNodeCode%>'=="newWorkReport"){
						OpenSubMenu('newWorkReport');
					}
					else if('<%=expNodeCode%>'=="pressFeedback"){
						OpenSubMenu('pressFeedback');
					}
					else if('<%=expNodeCode%>'=="REworkReport"){
						OpenSubMenu('REworkReport');
					}
					else if('<%=portletSettingId%>'=="mineOther"){
						OpenCloseSubMenu('B3');//我的汇报
					}
					else if('<%=portletSettingId%>'=="underlingOther"){
						OpenCloseSubMenu('B6');//下属汇报
					}
					else if('<%=expNodeCode%>'=="innerPersonList"){
						OpenSubMenu('innerPersonList');//内部邮件
					}
					else if('<%=portletSettingId%>'=="userinfo"){
						OpenCloseSubMenu(1000001120);//个人门户
					}
					else if('<%=expNodeCode%>'=="selfLayout"){
						OpenSubMenu('selfLayout');//个人门户
					}
					else if('<%=expNodeCode%>'=="personalPwd"){
						OpenSubMenu('personalPwd');//个人门户
					}
					else if('<%=expNodeCode%>'=="my"){
						OpenSubMenu('my');//领导日程-我的日程
					}
					else if('<%=expNodeCode%>'=="leader"){
						OpenSubMenu('leader');//领导日程-领导日程
					}else if('<%=expNodeCode%>'=="my1"){
						OpenSubMenu('my1');
					}else if('<%=expNodeCode%>'=="my2"){
						OpenSubMenu('my2');
					}else if('<%=expNodeCode%>'=="my3"){
						OpenSubMenu('my3');
					}else if('<%=expNodeCode%>'=="under1"){
						OpenSubMenu('under1');
					}else if('<%=expNodeCode%>'=="under2"){
						OpenSubMenu('under2');
					}else if('<%=expNodeCode%>'=="newReport"){
						OpenSubMenu('newReport');
					}
				});
		 }
	</script>
	 <div class="wh-l-msg">
                                    <a  class="clearfix">
                                        <i class="fa fa-laptop fa-color"></i>
                                        <span>
                                            <%=Resource.getValue(whir_locale, "common", "comm.workmanager")%>
                                           
                                        </span>
                                    </a>
                                </div>
                                <div class="wh-l-con">
                                    <ul id="treeDemo" class="ztree"></ul>
                                </div>
   
 


	
<%}%>
<script type="text/javascript">

</script>

