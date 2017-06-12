<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page import="com.whir.i18n.Resource" %>
<head>
	<title><s:text name="info.modifyinfo"/></title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_detail.jsp"%>
	<!--这里可以追加导入模块内私有的js文件或css文件-->
	<style type="text/css">
	<!--
	#infoNoteDiv {
		position:absolute;
		width:93%;
		height:200px;
		z-index:1;
		overflow:auto;
		border:1px solid #829FBB;
		display:none;
		background-color:#ffffff;
		top:29px !important;
		left:0px !important;
		*left:5px !important;

	}
	.ezflow_list_package_div{
		width:100%;
	}
	-->
   </style>
</head>
<%
String userId = session.getAttribute("userId").toString();
String canIssueChannel = request.getAttribute("canIssueChannel")!=null ? request.getAttribute("canIssueChannel").toString() :"[]";
String otherChannel = request.getAttribute("otherChannel")!=null ? request.getAttribute("otherChannel").toString() :"[]";
String isYiBoChannel = request.getAttribute("isYiBoChannel")!=null ? request.getAttribute("isYiBoChannel").toString() :"0";
String publicTagsId = request.getAttribute("publicTagsId")!=null ? request.getAttribute("publicTagsId").toString() :"";
publicTagsId = com.whir.component.security.crypto.EncryptUtil.replaceHtmlcode(publicTagsId);
%>
<body class="Pupwin">
	<div class="BodyMargin_10">
		<div id="info_add_center_1">
			<table width="100%" border="0" cellpadding="0" cellspacing="0" class="inlineBottomLine">  
				<tr>  
					<td>  
						<div class="Public_tag">  
							<ul>  
								<li class="tag_aon" id="Panle0" onClick="changePanle(0);"><span class="tag_center"><s:text name="info.newinfobasic"/></span><span class="tag_right"></span></li>  
								<li id="Panle1" onClick="changePanle(1);"><span class="tag_center"><s:text name="info.newinfodetail"/></span><span class="tag_right"></span></li>  
						   </ul>  
						</div>  
					</td>  
				</tr>  
			</table>
		</div>
		<div class="docBoxNoPanel">
			<s:form name="dataForm" id="dataForm" action="Information!update.action" method="post" theme="simple" >
			<%@ include file="/public/include/form_detail.jsp"%>
			<%@ include file="information_form.jsp"%>
			<input type="hidden" name="publicTagsId" id="publicTagsId" value="<%=publicTagsId%>">
			</s:form>
		</div>
	</div>
</body>
<script src="<%=rootPath%>/scripts/main/whir.ready.js" type="text/javascript"></script>
<script type="text/javascript">
initDataFormToAjax({"dataForm":'dataForm',"queryForm":'queryForm',"tip":'<s:text name="info.newinfosave"/>'});
Ext.onReady(function() {
	/*var modelCombo = Ext.create('Ext.form.field.ComboBox', {
		id: 'channelId',
		typeAhead: true,
		transform: 'selectChannels',
		hiddenName: 'selectChannel',
		width: 804,
		forceSelection: true,
		//emptyText: '--请选择--',
		listeners: {
			select: function(combo, record, index) {
				changeChannel(combo.getValue());
			}
		}
	});

	var modelCombo1 = Ext.create('Ext.form.field.ComboBox', {
		id: 'otherchannelId',
		typeAhead: true,
		transform: 'otherChannels',
		hiddenName: 'information.otherChannel',
		width: 435,
		forceSelection: true,
		//emptyText: '--请选择--',
		listeners: {
			select: function(combo, record, index) {
				
			}
		}
	});*/

	var tp = Ext.create('Ext.XTemplate',
		'<tpl for=".">',
			'<tpl if="first == 1">',  
				'<div style="font-size:12px;font-weight:bold;">信息管理</div>',  
			'</tpl>',
			'<tpl if="first == 2">',  
				'<div style="font-size:12px;font-weight:bold;">单位主页</div>',  
			'</tpl>',
			'<tpl if="first == 3">',  
				'<div style="font-size:12px;font-weight:bold;">自定义信息频道</div>',  
			'</tpl>',
			'<div class="x-boundlist-item">{name}</div>',
		'</tpl>'
	);

	var states = Ext.create('Ext.data.Store', {
		fields: ['id', 'name', 'first'],
		data : <%=canIssueChannel%>
	});

	Ext.create('Ext.form.ComboBox', {
		store: states,
		queryMode: 'local',
		valueField: 'id',
		displayField: 'name',
		typeAhead: true,
		id: 'channelId',
		transform: 'selectChannels',
		hiddenName: 'selectChannel',
		width:804,
		forceSelection: true,
		renderTo: Ext.getBody(),
		emptyText: '请输入栏目名称筛选或者下拉选择',
		listeners: {
			select: function(combo, record, index) {
				changeChannel(combo.getValue());
			}
		},
		tpl: tp
	});

	var states1 = Ext.create('Ext.data.Store', {
		fields: ['id', 'name', 'first'],
		data : <%=otherChannel%>
	});

	Ext.create('Ext.form.ComboBox', {
		store: states1,
		queryMode: 'local',
		valueField: 'id',
		displayField: 'name',
		typeAhead: true,
		id: 'otherchannelId',
		transform: 'otherChannels',
		hiddenName: 'information.otherChannel',
		width:435,
		forceSelection: true,
		renderTo: Ext.getBody(),
		emptyText: '<s:text name="info.searchcolumn"/>',
		tpl: tp
	});

	whirExtCombobox.setValue('channelId',$("#channel").val());
	whirExtCombobox.setValue('otherchannelId',$("#other").val().substring(1,$("#other").val().length-1));
	//初始化网站同步
	initOutSiteSynDiv();
});
var editUserId = '<s:property value="information.editUserId"/>';
var editUserName = '<s:property value="information.editUserName"/>';
var infotype_old = '<s:property value="information.informationType"/>';
$(document).ready(function(){
	if(editUserId!=null && editUserId!="" && editUserId!='<%=userId%>'){
		whir_alert("用户"+editUserName+"正在编辑该信息，您暂时不能编辑！");
		$("input[name='saveclose']").attr("disabled","disabled");
	}
	changeInfoType($("#informationType").val());
	
	$(":radio[name='information.informationValidType']").change(function(){
		if(this.value==1){
			$("#validBeginTime").val(getFormatDate(new Date(),"yyyy-MM-dd"));
			$("#validEndTime").val(getFormatDate(new Date(),"yyyy-MM-dd"));
			$("#validTime").show();
		}else{
			$("#validBeginTime").val('');
			$("#validEndTime").val('');
			$("#validTime").hide();
		}
	});
	
	var valid = $(":radio[name='information.informationValidType']:checked").val();
	if(valid==1){
		$("#validTime").show();
	}

	if(editUserId!=null && editUserId!="" && editUserId=='<%=userId%>'){
		$(window).bind("beforeunload",function(){
			$.ajax({
				type: 'POST',
				url: whirRootPath+"/Information!removeEditUser.action?informationId="+$("#informationId").val()+"&editUserId="+editUserId,
				async: false,
				cache: false
			});
		});
		$("input[name='exit']").bind("click",function(){
			$.ajax({
				type: 'POST',
				url: whirRootPath+"/Information!removeEditUser.action?informationId="+$("#informationId").val()+"&editUserId="+editUserId,
				async: false,
				cache: false
			});
		});
	}

	//初始进入易播栏目信息的修改页面，部分页面元素隐藏处理等
	var isYiBoChannel = "<%=isYiBoChannel%>";
	if(isYiBoChannel == "1"){
		$(document).attr("title","修改易播信息");//修改title
		$("#info_add_center_1").hide();
		$("#info_add_1").hide();
		$("#temp").hide();
		$("#info_add_2").hide();
		$("#selectAppend").hide();
	}
	// 弹出层
	$("#choosed_tagName").powerFloat();
	var publicTagsId = $("#publicTagsId").val();
	if(publicTagsId != ''){
		var tagsArr = publicTagsId.split(',');
		$('input:checkbox[name=publictags_checkbox]').each(function() {
			for(var i=0;i<tagsArr.length;i++){
				if ($(this).val() ==tagsArr[i]) {
					$(this).attr("checked","checked");
				}
			}
		});
	}
});



function changeInfoType(val){
	var isyibo = "<%=isYiBoChannel%>";
	if(val==0){
		$("#temp").hide();
		$("#selectImg").show();
		if(isyibo == "1"){
			$("#selectAppend").hide();
		}else{
			$("#selectAppend").show();
		}
		//$("#selectAppend").show();
		$("#txt").show();
		$("#edit").hide();
		$("#url").hide();
		$("#file").hide();
		$("#word").hide();
		$("#excel").hide();
		$("#ppt").hide();
		//20160603 -by jqq 信息预览按钮
		$("#preview-button").hide();
	}else if(val==1){
		$("#temp").show();
		$("#selectImg").show();
		$("#selectAppend").show();
		$("#txt").hide();
		$("#edit").show();
		$("#url").hide();
		$("#file").hide();
		$("#word").hide();
		$("#excel").hide();
		$("#ppt").hide();
		//20160603 -by jqq 信息预览按钮
		$("#preview-button").show();
	}else if(val==2){
		$("#temp").hide();
		$("#selectImg").hide();
		$("#selectAppend").hide();
		$("#txt").hide();
		$("#edit").hide();
		$("#url").show();
		$("#file").hide();
		$("#word").hide();
		$("#excel").hide();
		$("#ppt").hide();
		$("#preview-button").hide();
	}else if(val==3){
		$("#temp").hide();
		$("#selectImg").hide();
		$("#selectAppend").hide();
		$("#txt").hide();
		$("#edit").hide();
		$("#url").hide();
		$("#file").show();
		$("#word").hide();
		$("#excel").hide();
		$("#ppt").hide();
		//处理ie10点击选择文件没反应问题-----20130929
		//whir_uploader_reset("uploadFile");
		$("#preview-button").hide();
	}else if(val==4){
		$("#temp").hide();
		$("#selectImg").show();
		$("#selectAppend").show();
		$("#txt").hide();
		$("#edit").hide();
		$("#url").hide();
		$("#file").hide();
		$("#word").show();
		$("#excel").hide();
		$("#ppt").hide();
		$("#preview-button").hide();
	}else if(val==5){
		$("#temp").hide();
		$("#selectImg").show();
		$("#selectAppend").show();
		$("#txt").hide();
		$("#edit").hide();
		$("#url").hide();
		$("#file").hide();
		$("#word").hide();
		$("#excel").show();
		$("#ppt").hide();
		$("#preview-button").hide();
	}else if(val==6){
		$("#temp").hide();
		$("#selectImg").show();
		$("#selectAppend").show();
		$("#txt").hide();
		$("#edit").hide();
		$("#url").hide();
		$("#file").hide();
		$("#word").hide();
		$("#excel").hide();
		$("#ppt").show();
		$("#preview-button").hide();
	}
}
//20160711 -by jqq 切换详细页签关联页面数据消失改造
var relaFlag = 0;
function changePanle(flag){
    if(flag==0){
		$("#docinfo1").hide();
		$("#Panle1").removeClass();
		$("#docinfo0").show();
		$("#Panle0").addClass("tag_aon");
	}else{
		digitCheck();
		$("#docinfo0").hide();
		$("#Panle0").removeClass();
		$("#docinfo1").show();
		$("#Panle1").addClass("tag_aon");
		//处理新建信息页面经常加载不出相关对象
		if(relaFlag == 0){
			relaFlag = 1;
			var url="<%=rootPath%>/relation!relationIncludeList.action?moduleType=information&infoId=<s:property value='information.informationId'/>&showAdd=0&tagName=relationObjectDIV&iframeName=relationIFrame&relationadd=1";
			$("#relationIFrame").attr("src", url);
		}
	}
	//20160612 -by jqq 预览按钮在html编辑方式下显示
	var infotype = $('#informationType').val(); 
	if(infotype=='1' || infotype==1){
		$("#preview-button").show();
		$("#preview-button2").show();
	}else{
		$("#preview-button").hide();
		$("#preview-button2").hide();
	}
}

function changeChannel(val){
	var channelId = val.substring(0,val.indexOf(","));
	$.ajax({
		type: 'POST',
		url: whirRootPath+"/Information!changeChannel.action?channelId="+channelId,
        async: true,
		dataType: 'json',
		success: function(data){
			if(data!=null && data!=""){
				//是否易播栏目
				var isYiBoChannel = data.isYiBoChannel != null && data.isYiBoChannel != "" && data.isYiBoChannel != '' ? data.isYiBoChannel : "0";
				if(isYiBoChannel == "1"){
					$(document).attr("title","修改易播信息");//修改title
					$("#info_add_center_1").hide();
					$("#info_add_1").hide();
					$("#temp").hide();
					$("#info_add_2").hide();
					$("#selectAppend").hide();
				}else{
					$(document).attr("title",'<s:text name="info.modifyinfo"/>');
					$("#info_add_center_1").show();
					$("#info_add_1").show();
					$("#temp").show();
					$("#info_add_2").show();
					if(infotype_old == '2' || infotype_old == '3'){
						$("#selectAppend").hide();
					}else{
						$("#selectAppend").show();
					}
				}

				if(data.processId=="0"){
					$("#informationReaderId").val(data.canReader);
					$("#informationReaderId_").val(data.canReader);
					$("#informationReaderName").val(data.canReaderName);
					$("#informationPrinterId").val(data.printer);
					$("#informationPrinterId_").val(data.printer);
					$("#informationPrinterName").val(data.printerName);
					$("#printNum").val(data.printNum);
					$("#informationDownLoaderId").val(data.downloader);
					$("#informationDownLoaderId_").val(data.downloader);
					$("#informationDownLoaderName").val(data.downloaderName);
					$("#downLoadNum").val(data.downloadNum);
					//信息推送提醒方式继承栏目设置的提醒方式
					var remindType = data.remindType;
					if(remindType!=null && remindType!=""){
						if(remindType.indexOf("|")>-1){
							var array = remindType.split("|");
							for(var i=0;i<array.length;i++){
								var remind = array[i];
								if($("#remind_"+remind)[0]){
									$("#remind_"+remind).attr("checked", "checked");
								}
							}
						}else{
							if($("#remind_"+remindType)[0]){
								$("#remind_"+remindType).attr("checked", "checked");
							}
						}
					}else{
						if($("#remind_im")[0]){
							$("#remind_im").attr("checked", false);
						}
						if($("#remind_sms")[0]){
							$("#remind_sms").attr("checked", false);
						}
						if($("#remind_mail")[0]){
							$("#remind_mail").attr("checked", false);
						}
					}
				}else{
					if(data.processId=="-1"){
						whir_alert('<s:text name="info.noprocess"/>');
						whirExtCombobox.setValue('channelId','');
					}else{
						$(".btnButton4font").attr("disabled","disabled");
						location_href('Information!restart.action?p_wf_recordId='+$("#informationId").val()+'&p_wf_moduleId=4&p_wf_openType=reStart&p_wf_pool_processId='+data.processId+'&channelId='+channelId+'&modifyToProcess=1');
					}
				}
			}
			initOutSiteSynDiv();
		}
	});
}

function changeTemplate(val){
	if(val != 0){
		$.ajax({
			type: 'POST',
			url: whirRootPath+"/Template!getTemplateContent.action?id="+val,
			async: true,
			dataType: 'text',
			success: function(data){
				if(data!=null && data!=""){
					document.getElementById("newedit").contentWindow.setHTML(data);
				}
			}
		});
    }else{
	    try{
			document.getElementById("newedit").contentWindow.setHTML("");
		}catch(e){}
    }
}

function save(flag,obj){
	if(editUserId!=null && editUserId!="" && editUserId!='<%=userId%>'){
		return false;
	}
	var infotitle = $("#informationTitle").val();
	if(infotitle == null || infotitle == ""){
		whir_alert("标题不能为空");
		return;
	}
	var informationType = $("#informationType").val();
	if(informationType == 1){
		var o_Editor = document.getElementById("newedit").contentWindow;
		$("#informationContent").val(o_Editor.getHTML());
	}else if(informationType == 0){
		$("#informationContent").val($("#textContent").val());
	}else if(informationType == 2){
		var url = $("#URLContent").val();
		if(url==""){
			whir_alert('<s:text name="info.Addressnotempty"/>');
			return;
		}else{
			url = $.trim(url);
			if(url.substring(0,7)!="http://"){
				whir_alert('<s:text name="info.Addresserrors"/>');
				return;
			}else{
				$("#informationContent").val(url);
			}
		}
	}else if(informationType == 3){
		if($("#fileLinkContent").val()==""){
			whir_alert('<s:text name="info.notselectedfiles"/>');
			return;
		}else{
			$("#informationContent").val($("#fileLinkContent").val()+":"+$("#fileLinkContentHidd").val());
		}
	}else if(informationType == 4){
		if($("#content").val()==""){
			whir_alert('<s:text name="info.noeditext"/>');
			return;
		}else{
			$("#informationContent").val($("#content").val());
		}
	}else if(informationType == 5){
		if($("#content").val()==""){
			whir_alert('<s:text name="info.noeditext"/>');
			return;
		}else{
			$("#informationContent").val($("#content").val());
		}
	}else if(informationType == 6){
		if($("#content").val()==""){
			whir_alert('<s:text name="info.noeditext"/>');
			return;
		}else{
			$("#informationContent").val($("#content").val());
		}
	}
	var selectChannel = whirExtCombobox.getValue("channelId");
	if(selectChannel==null||selectChannel==""||selectChannel=="0"){
		whir_alert('<s:text name="info.haveNotselectedColumn"/>');
		return;
	}
	if($(":radio[name='information.informationValidType']:checked").val()==1){
		if($("#validEndTime").val()!='' && $("#validBeginTime").val()==''){
			whir_alert('<s:text name="info.selectValidityStartTime"/>');
			return;
		}else if($("#validEndTime").val()=='' && $("#validBeginTime").val()!=''){
			whir_alert('<s:text name="info.selectValidityEndTime"/>');
			return;
		}else if($("#validEndTime").val()!='' && $("#validBeginTime").val()!=''){
			if($("#validBeginTime").val() > $("#validEndTime").val()){
				whir_alert('<s:text name="info.timejudge"/>');
				return;
			}
		}
	}
	ok(flag,obj);
}

function wordEdit(editType){
	var content = $("#content").val();
	var userName = '<%=session.getAttribute("userName")%>';
	openWin({url:'public/iWebOfficeSign/DocumentEdit.jsp?RecordID='+content+'&EditType='+editType+'&UserName='+userName+'&ShowSign=0&CanSave='+editType+'&moduleType=information&saveHtmlImage=0&saveDocFile='+editType+'&FileType=.doc&showSignButton=1&showEditButton='+editType+'&saveHtml=0&showTempSign=-1&showTempHead=-1&moditype=info',isFull:true,winName:'editContent'});
}

function excelEdit(editType){
	var content = $("#content").val();
	var userName = '<%=session.getAttribute("userName")%>';
	openWin({url:'public/iWebOfficeSign/DocumentEdit.jsp?RecordID='+content+'&EditType='+editType+'&UserName='+userName+'&ShowSign=0&CanSave='+editType+'&moduleType=information&saveHtmlImage=0&saveDocFile='+editType+'&FileType=.xls&showSignButton=1&showEditButton='+editType+'&saveHtml=0&showTempSign=-1&showTempHead=-1&moditype=info',isFull:true,winName:'editContent'});
}

function pptEdit(editType){
	var content = $("#content").val();
	var userName = '<%=session.getAttribute("userName")%>';
	openWin({url:'public/iWebOfficeSign/DocumentEdit.jsp?RecordID='+content+'&EditType='+editType+'&UserName='+userName+'&ShowSign=0&CanSave='+editType+'&moduleType=information&saveHtmlImage=0&saveDocFile='+editType+'&FileType=.ppt&showSignButton=1&showEditButton='+editType+'&saveHtml=0&showTempSign=-1&showTempHead=-1&moditype=info',isFull:true,winName:'editContent'});
}

function fileLink(json){
	$("#fileLinkContent").val(json.file.name);
}

function uploadSuccess(json){
	$("#fileLinkContentHidd").val(json.save_name+json.file_type);
}

function selectReader(){
	var channelReader_ = $("#informationReaderId_").val();
	if(channelReader_!=""){
		openSelect({allowId:'informationReaderId', allowName:'informationReaderName', select:'userorggroup', single:'no', show:'orgusergroup', range:channelReader_,showShortcut:'0'});
	}else{
		openSelect({allowId:'informationReaderId', allowName:'informationReaderName', select:'userorggroup', single:'no', show:'orgusergroup', range:'*0*'});
	}
}

function selectPrinter(){
	var channelPrinter_ = $("#informationPrinterId_").val();
	if(channelPrinter_!=""){
		openSelect({allowId:'informationPrinterId', allowName:'informationPrinterName', select:'userorggroup', single:'no', show:'orgusergroup', range:channelPrinter_,showShortcut:'0'});
	}else{
		openSelect({allowId:'informationPrinterId', allowName:'informationPrinterName', select:'userorggroup', single:'no', show:'orgusergroup', range:'*0*'});
	}
}

function selectDownLoader(){
	var channelDownLoader_ = $("#informationDownLoaderId_").val();
	if(channelDownLoader_!=""){
		openSelect({allowId:'informationDownLoaderId', allowName:'informationDownLoaderName', select:'userorggroup', single:'no', show:'orgusergroup', range:channelDownLoader_,showShortcut:'0'});
	}else{
		openSelect({allowId:'informationDownLoaderId', allowName:'informationDownLoaderName', select:'userorggroup', single:'no', show:'orgusergroup', range:'*0*'});
	}
}

//加载网站同步信息
function initOutSiteSynDiv(){
    var _channel = whirExtCombobox.getValue("channelId");
	var _channelId="";
	if(_channel!=""&&_channel!="0"&&_channel!=null){
	    _channelId=_channel.substring(0,_channel.indexOf(","));
	}
	if(_channelId==""){
	    return ;
	}
	var url="<%=rootPath%>/modules/kms/information_manager/informationmanager_info_synsite_div.jsp?channelId="+_channelId+"&informationId="+$("#informationId").val();
	var html = $.ajax({url: url,async: false}).responseText;
	$("#outSiteSynDiv").html(html);
}
//选中的分类事件
function setPublicTagsInfo(){
	var _publicTag1="";
	var _publicTagName1="";
	$('input:checkbox[name="publictags_checkbox"]:checked').each(function(){					 
		if($(this).attr("checked")=="checked"){
			_publicTag1+=$(this).val()+",";
			_publicTagName1+=$(this).attr("displaytext")+",";
		}			 
	}); 
	if(_publicTag1!==""&&_publicTag1.substring(_publicTag1.length-1)==","){
		_publicTagName1=_publicTagName1.substring(0,_publicTagName1.length-1);
		_publicTag1=_publicTag1.substring(0,_publicTag1.length-1);
	} 
	//$("#processPackageDisName").html(_processPackageName1);
	$("#publicTagsId").val(_publicTag1);
	$("#choosed_tagName").val(_publicTagName1);		
}
//信息预览（html编辑模式）
function infoPreView(){
	//var informationId = "<s:property value='information.informationId'/>";
	var informationTitle = $('#informationTitle').val();
	var informationSubTitle = $('#informationSubTitle').val();
	var userDefine = '<s:property value="userDefine"/>';
	var userChannelName = '<s:property value="userChannelName"/>';
	var informationType = $('#informationType').val();
	var informationIssueTime = $('#informationIssueTime').val();
	var displayTitle = $(':checkbox[name="information.displayTitle"]:checked').val();
	var titleColor = $(':checkbox[name="information.titleColor"]:checked').val();
	if(typeof(displayTitle) == "undefined" || displayTitle==null || displayTitle==''){
		displayTitle = "1";
	}else{
		displayTitle = "0";
	}
	if(typeof(titleColor) == "undefined" || titleColor==null || titleColor==''){
		titleColor = "0";
	}else{
		titleColor = "1";
	}
	if(informationTitle==null || informationTitle==''){
		whir_alert("请输入信息标题。");
		return false;
	}
	if(userDefine==null || userDefine==''){
		userDefine = 0;
	}
	if(userChannelName==null || userChannelName==''){
		userChannelName = '';
	}
	if(informationType==null || informationType==''){
		whir_alert("请选择信息编辑方式。");
		return false;
	}
	if(informationIssueTime==null || informationIssueTime==''){
		informationIssueTime = '';
	}
	var o_Editor = document.getElementById("newedit").contentWindow;
	var content = o_Editor.getHTML();
	//替换双引号
	content = content.replace(/\"/g,"&quot;");
	//弹窗新页面
	var oW;
	var features = "top=0, left=0, toolbar=no, scrollbars=yes, menubar=no, locations=0,location=no, status=no, status=0";
	var winName = "infoPreview";
	var mainUrl = "Information!infoPreview.action";
	var htmlcontent = "";
	htmlcontent += '<input type="hidden" name="informationTitle" value="'+informationTitle+'">';
	htmlcontent += '<input type="hidden" name="informationSubTitle" value="'+informationSubTitle+'">';
	htmlcontent += '<input type="hidden" name="informationIssueTime" value="'+informationIssueTime+'">';
	htmlcontent += '<input type="hidden" name="displayTitle" value="'+displayTitle+'">';
	htmlcontent += '<input type="hidden" name="titleColor" value="'+titleColor+'">';
	htmlcontent += '<input type="hidden" name="content" value="'+content+'">';
	//弹窗最大化处理
	if (window.screen) {  
		var ah = screen.availHeight;
		var aw = screen.availWidth;
		features += ",height=" + ah;
		//features += ",innerHeight=" + ah;
		features += ",width=" + aw;
		//features += ",innerWidth=" + aw;
		features += ",resizable=yes";
	 } else {
		features += ",resizable=yes"; // 对于不支持screen属性的浏览器，可以手工进行最大化
	 } 
	oW = window.open('', winName, features);
    oW.document.open();
    oW.document.write('<form name="postform" id="postform" action="'+mainUrl+'" method="post" accept-charset="utf-8">'+htmlcontent+'<\/form><script type="text\/javascript">document.getElementById("postform").submit();<\/script>');
    oW.document.close();
    //$("#postform", oW.document).submit();
    oW.moveTo(0, 0);
    //oW.resizeTo(670, 620);
}
</script>
</html>