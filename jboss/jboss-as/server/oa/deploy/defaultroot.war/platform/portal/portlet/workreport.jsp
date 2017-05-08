<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page import="java.util.*"%>
<%@ page import="com.whir.ezoffice.portal.vo.*"%>
<%@ page import="com.whir.ezoffice.portal.bd.*"%>
<%@ page import="com.whir.ezoffice.portal.po.*"%>
<%@ page import="com.whir.ezoffice.portal.cache.*"%>
<%
response.setContentType("text/html; charset=UTF-8");
String portletSettingId = request.getParameter("portletSettingId");

ModuleVO mvo = (ModuleVO)request.getAttribute("mvo");

PortletBD pbd = new PortletBD();
ConfMap confMap = pbd.getConfMap(portletSettingId);
String limitChar = confMap.get("limitChar");
int limitCharNum = 0;
if(limitChar!=null && !"".equals(limitChar)){
	limitCharNum = Integer.parseInt(limitChar);
}
String reportType = "," + confMap.get("reportType");
String[] reportTypes = reportType.substring(1,reportType.length()).split(",");
int len = reportTypes.length;
String left="";
String right="";
%>
<script>

var jsonData = [
	{
		ulCss:"wh-portal-title-slide02-<%=portletSettingId%>",
		data:[
		 	<%if(reportType.indexOf(",1,")!=-1){
		 	left = "/defaultroot/modules/personal/personal_menu.jsp?statusType=workReport&portletSettingId=mineOther";
		 	 right="/defaultroot/WorkReportAction!workReportList.action?menuType=mine&reportType=other";
		 	 %>
		 	 
			{title:"我的汇报", url:"",onclick:'',defaultSelected:"on",liCss:"",morelink:"jumpnew('<%=left%>','<%=right%>')"},
			<%}%>
			<%if(reportType.indexOf(",2,")!=-1){
			 left="/defaultroot/modules/personal/personal_menu.jsp?statusType=workReport&portletSettingId=underlingOther";
		 	 right="/defaultroot/WorkReportAction!workReportList.action?menuType=underling&reportType=other";
			 %>
			{title:"下属汇报", url:"",onclick:'',defaultSelected:"",liCss:"",morelink:"jumpnew('<%=left%>','<%=right%>')"}
		<%}%>
		]
	}
	
];
Portlet.setPortletDataTitle('<%=portletSettingId%>',jsonData);
//Portlet.setMoreLink('<%=portletSettingId%>',{});
$('#more_portletSettingId_<%=portletSettingId%>').remove();
$('#h_portletSettingId_<%=portletSettingId%>').removeAttr("style");
</script>

<%
if(mvo!=null){
   Map itemMap = mvo.getItemMap();
%>
<style>
.workreport-type {border-bottom: 1px solid blue;
text-align: center;}
</style>
        <div class="wh-portal-info-content wh-portal-info-conlinebig">
            <div class="wh-portal-slide02-<%=portletSettingId%>">
                <ul class="clearfix">
					<%
					for(int i0=0; i0<len; i0++){
						 List list = (List)itemMap.get(reportTypes[i0].toString());
						 String mainType = "mine";
						 if("1".equals(reportTypes[i0].toString())){
							 mainType = "mine";
						 }else{
							 mainType = "underling";
						 }
							if(i0 == 0){
						%>
							<li >
						<%}else{%>
							<li class="wh-portal-hidden" >
					<%}%>
					<%
						if(list != null && list.size() > 0){
							for (int i = 0; i < list.size(); i++) {
								ItemVO ivo = (ItemVO)list.get(i);
								String title =ivo.getTitle().toString().length()>limitCharNum && limitCharNum>0 ? ivo.getTitle().toString().substring(0,limitCharNum)+"..." : ivo.getTitle().toString();
								String reporttype2 = "week";
								if("周报".equals(ivo.getIsConf())){
									reporttype2 = "week";
								}else if("月报".equals(ivo.getIsConf())){
									reporttype2 = "month";
								}else{
									reporttype2 = "other";
								}
								//左侧菜单定位
								String expendNode = "my1";
								if("mine".equals(mainType) && "week".equals(reporttype2)){
									expendNode = "my1";
								}else if("mine".equals(mainType) && "month".equals(reporttype2)){
									expendNode = "my2";
								}else if("mine".equals(mainType) && "other".equals(reporttype2)){
									expendNode = "my3";
								}else if("underling".equals(mainType) && "week".equals(reporttype2)){
									expendNode = "under1";
								}else if("underling".equals(mainType) && "month".equals(reporttype2)){
									expendNode = "under2";
								}else if("underling".equals(mainType) && "other".equals(reporttype2)){
									expendNode = "newWorkReport";
								}

					%>
					
                        <div class="wh-portal-i-item clearfix">
                            <a href="javascript:void(0)" >
							<%if("2".equals(reportTypes[i0].toString())){
								//String empLivingPhoto="/defaultroot/images/p1.jpg";
								if("0".equals(ivo.getChannelTitle())){//0未读
							%>
									<i class="fa fa-circle"></i>
								
							<% 	}else{%>
								<i class="fa fa-circle-o"></i>
							<% }
								//String _userImage = "/defaultroot/images/p1.jpg";
								//String _userphoto_f ="p1";
								//String _userphoto = ivo.getPoptitle();
								//if(_userphoto!=null&&!"".equals(_userphoto)&&!"null".equals(_userphoto)){
								//	_userphoto_f = _userphoto.substring(0, _userphoto.lastIndexOf("."));
								//	String __userphoto_ext = _userphoto.substring(_userphoto.lastIndexOf("."));
								//	_userImage = preUrl + "/upload/peopleinfo/" + _userphoto_f + "_middle" + __userphoto_ext;
								//}	
							%>
							
							<%}%>
							 <span class="wh-portal-a-cursor" onclick="gotoPortletURL(this, {lefturl:'<%=ivo.getLink()+"&portletSettingId="+portletSettingId%>&cunUserId=<%=session.getAttribute("userId")%>', righturl:'', winname:'', wintype:'1'});setTimeout(function(){$('#refresh_portletSettingId_<%=portletSettingId%>').click();}, 1000);" title="<%=ivo.getTitle()%>">
							 	<%=title%>
							 </span>
							 &nbsp;&nbsp;
							 <span class="workreport-type" style="cursor:pointer;" onclick="viewReportList('<%=com.whir.component.security.crypto.EncryptUtil.htmlcode(reporttype2)%>', '<%=com.whir.component.security.crypto.EncryptUtil.htmlcode(mainType)%>', '<%=com.whir.component.security.crypto.EncryptUtil.htmlcode(expendNode)%>')">
							 	<%=ivo.getIsConf()%>
							 </span>
                             <span class="wh-work-report-name">
                             	<%=ivo.getName()%>
                             </span>
                          </a>
                        </div>
				<%}}%>
				</li>
				<%}%>
			</ul>
		</div>
	</div>

<%}%>




<script language="JavaScript">
slideTab('slide02-<%=portletSettingId%>');
function viewReportList(reporttype, maintype, expendNode){
	var lefturl = '/defaultroot/modules/personal/personal_menu.jsp?expNodeCode=' + expendNode;
	var righturl = '"/defaultroot/WorkReportAction!workReportList.action?menuType='+maintype+'&reportType='+reporttype;
	jumpnew(lefturl, righturl);
}
</script>