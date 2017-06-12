<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.whir.ezoffice.portal.bd.*"%>
<%@ page import="com.whir.ezoffice.portal.po.*"%>
<%@ page import="com.whir.ezoffice.portal.vo.*"%>
<%@ page import="com.whir.ezoffice.portal.cache.*"%>
<%@ page import="com.whir.ezoffice.portal.common.util.*"%>
<%
ConfMap confMap = (ConfMap)request.getAttribute("confMap");

String limitNum = confMap.get("limitNum");
String limitChar = confMap.get("limitChar");
String meetingType =  confMap.get("meetingType");

//初始化默认值
if(limitNum==null||"".equals(limitNum)||"null".equals(limitNum)){
    limitNum = "5";//默认记录数
}
//初始化默认值
if(limitChar==null||"".equals(limitChar)||"null".equals(limitChar) || "undefined".equals(limitChar)){
	limitChar = "25";//默认字数
}
%>
<script>

function checkType(typevalue) {
	　　if (typevalue == "1") {
	　　　　gel("u142_input").checked = "checked";
	　　} else {
	　　　　gel("u144_input").checked = "checked";
	　　}
	}
function gel(id) {
　　return document.getElementById(id);
}
</script>

<tr>
    <th><em>显示项：</em></th>
    <td colspan="3">
        <div class="wh-choose-check">
        	<input id="u142_input"  type="radio" value="1"  name="meetingtype" onclick="checkType(1)"
	        	<%if("1".equals(confMap.get("meetingType")) || confMap.get("meetingType")==null || "".equals(confMap.get("meetingType")) || "null".equals(confMap.get("meetingType")) || "undefined".equals(confMap.get("meetingType"))){%>
	    			checked="checked"
	    		<%}%>
        	/>列表显示
        	<input id="u144_input" type="radio" value="2" name="meetingtype" onclick="checkType(2)"
        	<%if("2".equals(confMap.get("meetingType"))){%>
    			checked="checked"
    		<%}%>
    		/>纵向视图
        </div>
    </td>
</tr>
<tr>
    <th><em>列表字数限制：</em></th>
    <td>
        <div class="wh-choose-input">
            <input type="text" name="limitChar" id = "limitChar" maxlength = "2" data-maxval = "25" data-minval = "1" class="wh-choose-input-wid" value="<%=limitChar %>"/>
        </div>
    </td>
    <th><em>信息条数：</em></th>
    <td>
        <div class="wh-choose-input-w-box">
            <i class="fa fa-plus wh-pic-num-plus" onclick="setAmount.add('.wh-backstage-pic-num')"></i>
            <input type="text" name="limitNum"  id = "limitNum" maxlength = "2" data-maxval = "20" data-minval = "1" class="wh-choose-input-num wh-backstage-pic-num" value="<%=limitNum %>"/>
            <i class="fa fa-minus wh-pic-num-minus" onclick="setAmount.reduce('.wh-backstage-pic-num')"></i>
        </div>
    </td>
</tr>