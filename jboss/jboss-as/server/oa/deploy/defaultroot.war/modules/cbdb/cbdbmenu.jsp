<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page isELIgnored ="false" %>
<%@ page import="com.whir.govezoffice.documentmanager.bd.*"%>
<%
    response.setHeader("Cache-Control","no-store");
    response.setHeader("Pragma","no-cache");
    response.setDateHeader ("Expires", 0);
    com.whir.org.manager.bd.ManagerBD mbd = new com.whir.org.manager.bd.ManagerBD();
    String portletSettingId = request.getParameter("portletSettingId");
    String expNodeCode = request.getParameter("expNodeCode");
	int menuIndex2=0;
//此处公共业务逻辑
%>
<SCRIPT type="text/javascript">
    var zNodes = [
	<%menuIndex2++;%>
        { id:"x1", pId:0, name:"督办任务",  click:"menuJump('<%=rootPath%>/cbdb!dbtasklist.action?rightNeedDiv=1')",target:'mainFrame', open:true,iconSkin:"fa fa-cog fa"},
        //动态生成节点菜单
        <c:set value="1000000000" var="menuIndex" />
        <c:if test="${menuList!= null && fn:length(menuList) > 0}">
              <c:forEach items="${menuList}" var="menuObject">
                 { id:"x${menuObject[0]}", pId:"x${menuObject[2]}", name:"${menuObject[1]}",   click:"menuJump('<%=rootPath%>/cbdb!dbtasklist.action?rightNeedDiv=1&rwlyid=${menuObject[0]}')", target:'mainFrame',iconSkin:"fa fa"},
               <c:set var="menuIndex" value="${menuIndex+1}" />
        </c:forEach>
        </c:if>

            { id:${menuIndex}, pId:"x1", name:"重要任务", click:"menuJump('<%=rootPath%>/cbdb!dbtasklist.action?rightNeedDiv=1&sfzyrw=1')", target:'mainFrame',iconSkin:"fa fa"},

        { id:2, pId:0, name:"任务审核",iconSkin:"fa fa-cog fa"},
            { id:2000000000, pId:2, name:"延期审核",  click:"menuJump('<%=rootPath%>/cbdb!taskshlist.action?rightNeedDiv=1&sfyqsh=1')" ,target:'mainFrame',iconSkin:"fa fa"},
            { id:2000000001, pId:2, name:"任务评价",  click:"menuJump('<%=rootPath%>/cbdb!taskshlist.action?rightNeedDiv=1&sfyqsh=2')", target:'mainFrame',iconSkin:"fa fa"},

        { id:3, pId:0, name:"我的任务",iconSkin:"fa fa-cog fa"},
            { id:3000000001, pId:3, name:"我负责的任务", click:"menuJump('<%=rootPath%>/cbdbMytask!mytasklist.action?rightNeedDiv=1&mytaskflag=mytask')", target:'mainFrame',iconSkin:"fa fa"},
            { id:3000000002, pId:3, name:"我参与的任务",  click:"menuJump('<%=rootPath%>/cbdbMytask!mytasklist.action?rightNeedDiv=1&mytaskflag=myparttask')", target:'mainFrame',iconSkin:"fa fa"},
            { id:3000000003, pId:3, name:"我托付的任务",  click:"menuJump('<%=rootPath%>/cbdbMytask!mytasklist.action?rightNeedDiv=1&mytaskflag=mytftask')", target:'mainFrame',iconSkin:"fa fa"},       

        { id:4, pId:0, name:"督办统计",iconSkin:"fa fa-cog fa"},
            { id:4000000001, pId:4, name:"按部门统计",  click:"menuJump('<%=rootPath%>/cbdbTj!taskTJBydep.action?rightNeedDiv=1')", target:'mainFrame',iconSkin:"fa fa"} ,
            { id:4000000002, pId:4, name:"按责任人统计", click:"menuJump('<%=rootPath%>/cbdbTj!taskTJByfzr.action?rightNeedDiv=1')", target:'mainFrame',iconSkin:"fa fa"},
   <c:if test="${sfjcszqx}">
    { id:5, pId:0, name:"基础设置",iconSkin:"fa fa-cog fa"},
            { id:5000000001, pId:5, name:"任务来源",  click:"menuJump('<%=rootPath%>/cbdbSet!cbdbSourcelist.action?rightNeedDiv=1')", target:'mainFrame',iconSkin:"fa fa"},
	
            { id:5000000002, pId:5, name:"流程设置",  click:"", target:'mainFrame',iconSkin:"fa fa"},
			 { id:5000000003, pId:5000000002, name:"任务反馈流程",  click:"menuJump('<%=rootPath%>/ezflowprocess!ezFlowList.action?moduleId=308')", target:'mainFrame',iconSkin:"fa fa"},
			 { id:5000000004, pId:5000000002, name:"审批表单",  click:"menuJump('<%=rootPath%>/EzForm!initFormList.action?wfModuleId=308')", target:'mainFrame',iconSkin:"fa fa"}
        
  </c:if>
    <%menuIndex2++;%>
         <%
            String menutype = "cbdb_menu";
         %>
        <%@ include file="/platform/custom/customize/custLeftMenuUnderOriginal.jsp"%>

 ];
function whir_initMenu(){
    $.fn.zTree.init($("#treeDemo"), setting, zNodes);
}
</SCRIPT>
<div class="wh-l-msg">
    <a href="javascript:void(0)" class="clearfix" style="cursor:default">
        <i class="fa fa-color fa-briefcase"></i>
	        <span>
	            	任务督办
	        </span>
    </a>
</div>
<div class="wh-l-con">
    <ul id="treeDemo" class="ztree"></ul>
</div>


