<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page import="java.util.*"%>
<%@ page import="com.whir.ezoffice.portal.vo.*"%>
<%@ page import="com.whir.ezoffice.portal.bd.PortletBD"%>
<%@ page import="com.whir.ezoffice.portal.cache.ConfMap"%>
<%
//原来是列表显示，现在多加入纵向试图

response.setContentType("text/html; charset=UTF-8");
//1,列表展示，2纵向试图
String portletSettingId = request.getParameter("portletSettingId");
PortletBD pbd = new PortletBD();
ConfMap confMap = pbd.getConfMap(portletSettingId);
String meetingType =  confMap.get("meetingType");
ModuleVO mvo = null;
String timeTD  = "";
String currentDate = "";
String mondayList = "";
String tuesdayList = "";
String wednesdayList = "";
String thursdayList = "";
String fridayList = "";
String saturdayList = "";
String sundayList = "";
if(meetingType==null || "1".equals(meetingType) || "".equals(meetingType) || "null".equals(meetingType) || "undefined".equals(meetingType)){
	 mvo = (ModuleVO)request.getAttribute("mvo");
}else if("2".equals(meetingType)){
	timeTD = (String)request.getAttribute("timeTD");
	currentDate = (String)request.getAttribute("currentDate");
	if(request.getAttribute("mondayListTitle") !=null){
		mondayList = (String)request.getAttribute("mondayListTitle");
	    }
    if(request.getAttribute("tuesdayListTitle") !=null){
	    tuesdayList = (String)request.getAttribute("tuesdayListTitle");
    }
    if(request.getAttribute("wednesdayListTitle") !=null){
	    wednesdayList = (String)request.getAttribute("wednesdayListTitle");
    }
    if(request.getAttribute("thursdayListTitle") !=null){
	    thursdayList = (String)request.getAttribute("thursdayListTitle");
    }
    if(request.getAttribute("fridayListTitle") !=null){
	    fridayList = (String)request.getAttribute("fridayListTitle");
    }
    if(request.getAttribute("saturdayListTitle") !=null){
	    saturdayList = (String)request.getAttribute("saturdayListTitle");
    }
    if(request.getAttribute("sundayListTitle") !=null){
	    sundayList = (String)request.getAttribute("sundayListTitle");
    }
}

if(mvo!=null){
    List list = mvo.getItemList();
%>

<!--会议通知 列表展示-->
    <div class="wh-portal-info-content" style ="display:none" id = "huiyilb">
        <div class="wh-portal-slide03 wh-portal-slide-mt2row">
            <ul class="clearfix">
                <li>
	                <%
					if(list != null && list.size() > 0){
					    for (int i = 0; i < list.size(); i++) {
					        ItemVO ivo = (ItemVO)list.get(i);
					%>
                    <div class="wh-portal-i-item ">
                        <%=ivo.getContent()%>
                        <a href="javascript:void(0)" title = '<%=ivo.getName() %>' class="clearfix" >
                        <%=ivo.getTitle()%>
                        </a>
                    </div>
                    <%}}%>
                </li>
            </ul>
        </div>
    </div>

<%}%>



<!--会议通知 纵向试图展示-->
      <div class="wh-meeting-tab" style ="display:none" id = "huiyiview">
         <div class="wh-schedule-time-box">
                    <ul class="wh-schedule-time-slide clearfix">
                        <li><%=currentDate %></li>
                    </ul>
          </div>
          <table class="wh-meeting-detail" cellpadding="0" cellspacing="0">
              <%=timeTD %>
              <tr class="wh-meeting-tab-tr">
                  <%=mondayList%>
                  <%=tuesdayList%>
                  <%=wednesdayList%>
                  <%=thursdayList%>
                  <%=fridayList%>
                  <%=saturdayList%>
                  <%=sundayList%>
              </tr>
          </table>
      </div>


<script  language="JavaScript">
var meetingType = '<%=meetingType%>';
$(document).ready(function(){
	if(meetingType==null || meetingType == '1' || meetingType == '' || meetingType=='null' || meetingType=='undefined'){
		$('#huiyilb').show();
		$('#huiyiview').hide();
	}
	else if(meetingType == '2'){
		$('#huiyilb').hide();
		$('#huiyiview').show();
	}
  $(".wh-meeting-address").hover(function () {
         $(this).find(".wh-meeting-hid-box").show();
     }, function () {
         $(this).find(".wh-meeting-hid-box").hide();
     })
   $(".wh-schedule-time-box").flexslider({
        selector:".wh-schedule-time-slide > li",
        animation: "slide",
        animationLoop: false,
        itemMargin: 7,
        directionNav: true,
        controlNav:false,
    });
  var portletSettingId = '<%=portletSettingId%>';
  var currentDate = '<%=currentDate %>';
  //绑定的点击事件，需要传入时间 和上周，下周。
  $(".wh-schedule-time-box .flex-next").click(function(){
	  	meetingnotice.refresh($('#content_portletSettingId_'+portletSettingId), {portletSettingId:portletSettingId, type:'meetingnotice', isNext:true, currentDate : currentDate});
	});
  
  $(".wh-schedule-time-box .flex-prev ").click(function(){
	  meetingnotice.refresh($('#content_portletSettingId_'+portletSettingId), {portletSettingId:portletSettingId, type:'meetingnotice', isPrev:true ,currentDate : currentDate});
	  });
 })
</script>