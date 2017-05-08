/** 列表页 [BEGIN] */

/*自定义查看栏内容 [BGEING] */
/* 我的汇报 [BEGIN] */
// 
function showCheckBox(po, i){
    var html =  '';
    if(po.hadRead == '1'){
        html = 'disabled=true';
    }
    return html;
}

// 发送状态
function showSendType(po, i){
    var html =  '';
    if(po.sendType == '0'){
        html = '' + Personalwork.draft;
    }else if(po.sendType == '1'){
        html = '' + Personalwork.sended;
    } else {
        //html = '此条数据"发送状态"有错';
    }
    return html;
}
/* 我的汇报 [END] */

/* 下属汇报 [BEGIN] */
// 阅读情况-周报/月报/其它
function showIHadRead(po, i){
    var html =  '';
    if(po.iHadRead == '0'){
        html = '<font color="red">'+Personalwork.unread+'</font>';
    }else if(po.iHadRead == '1'){
        html = '' + Personalwork.hadread;
    }else{
        //html = '此条数据"阅读状态"有错';
    }
    return html;
}

// 汇报区间--下属汇报(其它)
function showUnderlingReportTitle(po, i){
    var html = '<a href="javascript:void(0)" onclick="viewUnderlingReport('+po.workReportId+', \''+po.workReportId_verifyCode+'\', this);';
    if(po.hadRead == '0'){
        html += 'updateReportHadReadSilence('+po.workReportId+', \''+po.workReportId_verifyCode+'\');';
    }
    if(po.iHadRead == '0'){
        html += 'updateReportIHadReadSilence('+po.iWorkReportId+', \''+po.iWorkReportId_verifyCode+'\');';
    }
    html += '">'+po.reportTitle+'</a>';
    return html;
}

// 汇报区间--下属汇报(周报/月报)
function showUnderlingReportCourse(po, i){
    var html = '<a href="javascript:void(0)" onclick="viewUnderlingReport('+po.workReportId+', \''+po.workReportId_verifyCode+'\', this);';
    
    if(po.hadRead == '0'){
        html += 'updateReportHadReadSilence('+po.workReportId+', \''+po.workReportId_verifyCode+'\');';
    }
    if(po.iHadRead == '0'){
        html += 'updateReportIHadReadSilence('+po.iWorkReportId+', \''+po.iWorkReportId_verifyCode+'\');';
    }
    
   html += 'refreshListForm(\'queryForm\');">'+po.reportCourse+'</a>';
    return html;
}
/* 下属汇报 [END] */

/* 汇报查阅 [BEGIN] */
/* 汇报查阅 [END] */

/* 我的汇报/汇报查阅 [BEGIN] */

// 汇报区间(周报/月报)
function showReportCourse(po, i){
    var html = '<a href="javascript:void(0);" onclick="viewWorkReport('+po.workReportId+', \''+po.verifyCode+'\');">'+po.reportCourse+'</a>';
    return html;
}

// 汇报标题(其它)
function showReportTitle(po, i){
    var html = '<a href="javascript:void(0);" onclick="viewWorkReport('+po.workReportId+', \''+po.verifyCode+'\');">'+po.reportTitle+'</a>';
    return html;
}
/* 我的汇报/汇报查阅 [END] */

/* 我的汇报/下属汇报/汇报查阅 [BEGIN] */
// 汇报类型-其它
function showReportType(po, i){
    var html =  '';
    switch(po.reportType){
        case '0': html = '' + Personalwork.workreport_everyday;break;
        case '1': html = '' + Personalwork.workreport_everyweek;break;
        case '2': html = '' + Personalwork.workreport_everyhalfmonth;break;
        case '3': html = '' + Personalwork.workreport_everymonth;break;
        case '4': html = '' + Personalwork.workreport_everyquarter;break;
        case '5': html = '' + Personalwork.workreport_everyhalfyear;break;
        case '6': html = '' + Personalwork.workreport_everyyear;break;
        case '7': html = '' + Personalwork.workreport_temp;break;
        default: html = '';
    }
    return html;
}

function showReportTime(po, i){
    var html = po.reportTime;
    if(html.length > 16){
        html = html.substring(0, 16);
    }
    return html;
}

// 提交至
function showReportReader(po, i){
    var ids = po.reportReaderId;
    ids = ids.substring(1, ids.length-1);
    var names = po.reportReader;
    names = names.substring(0, names.length-1);
    
    var id = ids.split("$$");
    //alert(names);
    var name = names.split(",");
    var html = '';
    if(id.length == name.length){
        for(var i=0; i<id.length; i++){
            // 人员浮动卡片
            var data = whirRootPath + '/public/desktop/getUserCardInfo.jsp?id=' + id[i] + '&hasMsg=true'; 
            html += '<a class="trigger1" rel=' + data + ' href="javascript:void(0);" onclick="viewUserInfo('+id[i]+')">' + name[i] + '</a>,';
        }
    }
    return html;
}

// 填写人
function showReportEmp(po, i){
    // 人员浮动卡片
    var data = whirRootPath + '/public/desktop/getUserCardInfo.jsp?id=' + po.empId + '&hasMsg=true'; 
    var html = '<a class="trigger1" rel=' + data + ' href="javascript:void(0);" onclick="viewUserInfo('+po.empId+')">' + po.reportEmpName + '</a>';
    return html;
}

// 人员浮动卡片 - 加载页面成功后的回调函数
function showInfo(){   
    $(".trigger1").powerFloat({   
        targetMode: "ajax" ,
        width: "300px"
    });   
}

// 查看人员信息
function viewUserInfo(id){
    var vUrl = whirRootPath + '/employee!user_view.action?empId=' + id;
    openWin({url:vUrl, width:820, height:600, winName:'viewUserInfo'});
}
/* 我的汇报/下属汇报/汇报查阅 [END] */
/*自定义查看栏内容 [END] */

function updateReportHadReadSilence(workReportId, verifyCode){
    var vUrl = whirRootPath + '/WorkReportUnderlingAction!updateReportHadRead.action';
    vUrl += '?workReportId=' + workReportId;
    vUrl += '&verifyCode=' + verifyCode;
    ajaxOperateSilence({urlWithData:vUrl, callbackfunction:null});
}

function updateReportIHadReadSilence(iWorkReportId, verifyCode){
    var vUrl = whirRootPath + '/WorkReportUnderlingAction!updateReportIHadRead.action';
    vUrl += '?iWorkReportId=' + iWorkReportId;
    vUrl += '&verifyCode=' + verifyCode;
    ajaxOperateSilence({urlWithData:vUrl, callbackfunction:null});
}

function refreshListForm_workReport(){
	refreshListForm('queryForm');
}

function ajaxOperateSilence(opeJson){
    jQuery.ajax({
        type : "POST",
        url  : opeJson.url || opeJson.urlWithData,
        data : opeJson.data || '',
        success: function(msg){
            var msg_json = eval("("+msg+")");
            if(msg_json.result == "success"){
                if(opeJson.callbackfunction!=null){
                    opeJson.callbackfunction.call(opeJson.callbackfunction, opeJson, msg_json);
                }
            }else{
                $.dialog.alert(msg_json.result,function(){}); 
            } 
        },
        error: function(XMLHttpRequest, textStatus, errorThrown){
            $.dialog.alert(opeJson.tip+comm.whir_failure,function(){}); 
        }
    });
}

function performanceSummary(summaryType){
    var summaryYear = whirCombobox.getValue('queryReportYear');
    //alert('summaryYear=[' + summaryYear + ']');
    if(summaryYear == undefined || summaryYear == ''){
        whir_alert(Personalwork.workreport_selectyear, null, null);
    } else {
        var vUrl = whirRootPath + '/WorkReportAction!performanceSummary.action';
        vUrl += '?summaryType=' + summaryType;
        vUrl += '&summaryYear=' + summaryYear;
        //alert('vUrl=[' + vUrl + ']');
        //return ;
        if($("#exportIframe").length==0){
            var exportIframe = '<div style="display:none"><iframe id="exportIframe" name="exportIframe" width="0" height="0"></iframe></div>';
            $("body").append(exportIframe);
        }
        var $form = createDynamicForm({id:'exportForm', target:"exportIframe", action:vUrl, params:'', method:'post'});
        if($form) {
            $form.submit();
        }
    }
}
/** 列表页 [END] */
