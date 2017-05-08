<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="com.whir.ezoffice.personnelmanager.bd.*"%>
<%@ page import="com.whir.common.page.*"%>
<%@ page import="com.whir.org.manager.bd.*"%>
<%@ page import="com.whir.ezoffice.customdb.common.util.*"%>
<%@ page import="com.whir.ezoffice.portal.bd.*"%>
<%@ page import="com.whir.ezoffice.portal.vo.*"%>
<%@ page import="com.whir.ezoffice.portal.po.*"%>
<%@ page import="com.whir.ezoffice.portal.cache.*"%>
<%
//模块页面

response.setContentType("text/html; charset=UTF-8");

String portletSettingId = request.getParameter("portletSettingId");
PortletBD pbd = new PortletBD();
ConfMap confMap = pbd.getConfMap(portletSettingId);
String tipTitle="新人入司";
if(confMap.get("tipTitle")!=null&&!"".equals(confMap.get("tipTitle"))){
  tipTitle = confMap.get("tipTitle");
}
String tipWelcome="欢迎每一位新成员加入！";
if(confMap.get("tipWelcome")!=null&&!"".equals(confMap.get("tipWelcome"))){
  tipWelcome = confMap.get("tipWelcome");
}
String birthTitle="员工生日";
if(confMap.get("birthTitle")!=null&&!"".equals(confMap.get("birthTitle"))){
  birthTitle = confMap.get("birthTitle");
}
String birthWelcome="祝每一位员工生日快乐！";
if(confMap.get("birthWelcome")!=null&&!"".equals(confMap.get("birthWelcome"))){
  birthWelcome = confMap.get("birthWelcome");
}


//String remindType = request.getParameter("remindType");
String remindType = "," + confMap.get("remindType");
String limitNum = confMap.get("limitNum");

String domainId = session.getAttribute("domainId") == null ? "0" : session.getAttribute("domainId").toString();
String databaseType = com.whir.common.config.SystemCommon.getDatabaseType();

String skin = session.getAttribute("skin")!=null?session.getAttribute("skin").toString():"blue";
Map m = new HashMap();
m.put("green","#1E6C00");
m.put("black","#3F3F3F");
m.put("blue","#0F6CBB");
m.put("orange","#E55600");
m.put("blue2","#1D5BC8");
m.put("07_blue","#1D5BC8");
m.put("09_blue","#0F6CBB");
m.put("gray","#2B5672");

int pageSize = 15;
int currentPage = 1;
SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
if(limitNum!=null&&!"".equals(limitNum)&&!"null".equals(limitNum)){
    pageSize = Integer.parseInt(limitNum);
}
%>


<%
//if("1".equals(remindType)){//生日提醒
if(remindType.indexOf(",1,")!=-1){
  String searchWorkPackStartDate = format.format(new Date());
    String nowYear_ = (new Date().getYear() + 1900) + "-";
    String nowYear_2 = (new Date().getYear() + 1900 + 1) + "-";

    NewEmployeeBD nbd = new NewEmployeeBD();
    //取得生日到期提醒天数
    String days = nbd.getMaturityAlertSettingsValue("maturity_alert_settings", "10002", domainId);
    if (days == null || days.equals("")) {
        days = "7";
    }

    String searchWorkPackEndDate = getNextDay(searchWorkPackStartDate, days);
    //searchWorkPackStartDate = searchWorkPackStartDate.substring(5, 10);
    //searchWorkPackEndDate = searchWorkPackEndDate.substring(5, 10);
    String where = "";
    /*if (databaseType.indexOf("oracle") >= 0) {
        where += " and to_char(po.empBirth,'mm-dd')>='" + searchWorkPackStartDate + "' and " + "to_char(po.empBirth,'mm-dd')<='" + searchWorkPackEndDate + "'";
    } else if (databaseType.indexOf("mysql") >= 0) {
        where += " and substr(concat(po.empBirth),6,5)>='" + searchWorkPackStartDate + "' and " + "substr(concat(po.empBirth),6,5)<='" + searchWorkPackEndDate + "'";
    } else {
        where += " and substring(convert(varchar,po.empBirth,110),1,5)>='" + searchWorkPackStartDate + "' and " + "substring(convert(varchar,po.empBirth,110),1,5)<='" + searchWorkPackEndDate + "'";
    }*/
    if (databaseType.indexOf("oracle") >= 0) {
        where += " and (('"+nowYear_+"' || to_char(po.empBirth,'mm-dd')>='" + searchWorkPackStartDate + "' and " + "'"+nowYear_+"' || to_char(po.empBirth,'mm-dd')<='" + searchWorkPackEndDate + "')";
                    where += " or ('"+nowYear_2+"' || to_char(po.empBirth,'mm-dd')>='" + searchWorkPackStartDate + "' and " + "'"+nowYear_2+"' || to_char(po.empBirth,'mm-dd')<='" + searchWorkPackEndDate + "'))";
    } else if (databaseType.indexOf("mysql") >= 0) {
        where += " and ((concat('"+nowYear_+"',substr(concat(po.empBirth),6,5))>='" + searchWorkPackStartDate + "' and " + "concat('"+nowYear_+"',substr(concat(po.empBirth),6,5))<='" + searchWorkPackEndDate + "')";
                    where += " or (concat('"+nowYear_2+"',substr(concat(po.empBirth),6,5))>='" + searchWorkPackStartDate + "' and " + "concat('"+nowYear_2+"',substr(concat(po.empBirth),6,5))<='" + searchWorkPackEndDate + "'))";
    } else {
        where += " and (('"+nowYear_+"' + substring(convert(varchar,po.empBirth,110),1,5)>='" + searchWorkPackStartDate + "' and " + "'"+nowYear_+"' + substring(convert(varchar,po.empBirth,110),1,5)<='" + searchWorkPackEndDate + "')";
                    where += " or ('"+nowYear_2+"' + substring(convert(varchar,po.empBirth,110),1,5)>='" + searchWorkPackStartDate + "' and " + "'"+nowYear_2+"' + substring(convert(varchar,po.empBirth,110),1,5)<='" + searchWorkPackEndDate + "'))";
    }
    where += " and po.empBirth is not null ";

    //where = "where po.userIsDeleted=0 and po.userIsActive=1 " + where + " and po.domainId=" + domainId + " order by orgpo.orgIdString,po.empDutyLevel,po.userOrderCode,po.empName, po.empBirth";
    where = "where po.userIsDeleted=0 and po.userIsActive=1 " + where + " and po.domainId=" + domainId ;
	if (databaseType.indexOf("oracle") >= 0) {
		where += "  order by EXTRACT(MONTH FROM po.empBirth),EXTRACT(DAY FROM po.empBirth) " ;
	}else if (databaseType.indexOf("mysql") >= 0) {
		where += "  order by MONTH(po.empBirth),DAY(po.empBirth) " ;
	}else{
		where += "  order by MONTH(po.empBirth),DAY(po.empBirth) " ;
	}


    Page _page = new Page("po.empId,po.empName,po.empEnglishName,po.empSex,po.empBirth,po.empDuty,po.empNativePlace," + "po.userAccounts,orgpo.orgNameString,orgpo.orgName,po.userIsActive,po.empLeaderName,orgpo.id,po.workPackEndDate", "com.whir.org.vo.usermanager.EmployeeVO po join po.organizations orgpo ", where);
    _page.setPageSize(pageSize);
    _page.setcurrentPage(currentPage);
    List list = _page.getResultList();
	
	
%>

    <div class="wh-human-remind">
        <div class="wh-human-remind-title">
            <span> <%=birthTitle%></span>
            <%=birthWelcome%>
        </div>
        <table cellpadding="0" cellspacing="0" class="wh-human-remind-tab">
            <tr class="wh-human-remind-tab-tit">
                <td>姓名</td>
                <td>部门</td>
                <td>生日</td>
            </tr>
			<%
			if(list != null && list.size() > 0){
			java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("MM-dd");
			for(int i=0; i<list.size(); i++){
			Object[] obj = (Object[])list.get(i);
			%>
            <tr>
                <td><%=obj[1]%></td>
                <td><%=obj[9]%></td>
                <td><%=sdf.format((Date)obj[4])%></td>
            </tr>
			<%}}%>
        </table>
   </div>
<%}%>

<%
//if("5".equals(remindType)){//入职提醒
if(remindType.indexOf(",5,")!=-1){
    String viewSQL = "po.empName,po.intoCompanyDate,orgpo.orgName";
    String fromSQL = "com.whir.org.vo.usermanager.EmployeeVO po join po.organizations orgpo ";
    String whereSQL = " where 1=1 and ";

    NewEmployeeBD nbd = new NewEmployeeBD();
    //取得入职提醒天数
    String days = nbd.getMaturityAlertSettingsValue("maturity_alert_settings", "10005", domainId);
    if (days == null || days.equals("")) {
        days = "30";
    }

    if (databaseType.indexOf("oracle") > -1) {
        whereSQL += " po.intoCompanyDate is not null and (sysdate - po.intoCompanyDate )<="+days;
    } else if (databaseType.indexOf("mysql") > -1) {
        whereSQL += " po.intoCompanyDate is not null and (now() - po.intoCompanyDate )<="+days;
    } else {
        whereSQL += " po.intoCompanyDate is not null and (getdate() - po.intoCompanyDate )<="+days;
    }

    whereSQL += " order by po.intoCompanyDate desc  ";

    Page _page = new Page(viewSQL, fromSQL, whereSQL);
    _page.setPageSize(pageSize);
    _page.setcurrentPage(currentPage);
    List list = _page.getResultList();
%>
	<div class="wh-human-remind">
        <div class="wh-human-remind-title">
            <span><%=tipTitle%></span>
           <%=tipWelcome%>
        </div>
        <table cellpadding="0" cellspacing="0" class="wh-human-remind-tab">
            <tr class="wh-human-remind-tab-tit">
                <td>姓名</td>
                <td>部门</td>
                <td>入职时间</td>
            </tr>
			<%
				if(list != null && list.size() > 0){
					java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
					for(int i=0; i<list.size(); i++){
						Object[] obj = (Object[])list.get(i);
			%>
            <tr>
                <td><%=obj[0]%></td>
                <td><%=obj[2]%></td>
                <td><%=sdf.format((Date)obj[1])%></td>
            </tr>
			<%}}%>
		</table>
	</div>
<%}%>		


<%
//if("6".equals(remindType)){//离职提醒
if(remindType.indexOf(",6,")!=-1){
    String viewSQL = " po.empName,po.lizhiDate,orgpo.orgName ";
    String fromSQL = "com.whir.org.vo.usermanager.EmployeeVO po join po.organizations orgpo ";
    String whereSQL = " where 1=1 and ";

    NewEmployeeBD nbd = new NewEmployeeBD();
    //取得入职提醒天数
    String days = nbd.getMaturityAlertSettingsValue("maturity_alert_settings", "10006", domainId);
    if (days == null || days.equals("")) {
        days = "30";
    }

    if (databaseType.indexOf("oracle") > -1) {
        whereSQL += " po.lizhiDate is not null and (sysdate - po.lizhiDate )<="+days;
    } else if (databaseType.indexOf("mysql") > -1) {
        whereSQL += " po.lizhiDate is not null and (now() - po.lizhiDate )<="+days;
    } else {
        whereSQL += " po.lizhiDate is not null and (getdate() - po.lizhiDate )<="+days;
    }

    whereSQL += " order by po.lizhiDate desc  ";

    Page _page = new Page(viewSQL, fromSQL, whereSQL);
    _page.setPageSize(pageSize);
    _page.setcurrentPage(currentPage);
    List list = _page.getResultList();
%>

<div class="wh-human-remind">
        <div class="wh-human-remind-title">
            <span>员工离职</span>
            感谢您为公司所做的贡献，未来一路走好！
        </div>
        <table cellpadding="0" cellspacing="0" class="wh-human-remind-tab">
            <tr class="wh-human-remind-tab-tit">
                <td>姓名</td>
                <td>部门</td>
                <td>离职时间</td>
            </tr>
			<%
				if(list != null && list.size() > 0){
					java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
					for(int i=0; i<list.size(); i++){
						Object[] obj = (Object[])list.get(i);
			%>
            <tr>
                <td><%=obj[0]%></td>
                <td><%=obj[2]%></td>
                <td><%=sdf.format((Date)obj[1])%></td>
            </tr>
			<%}}%>
		</table>
	</div>
<%}%>

<%
//if("2".equals(remindType)){//合同提醒 
if(remindType.indexOf(",2,")!=-1){   
    //2010-03-19
    String c_where = "select  a.emp_id,a.enddate as md,b.change_date ,a.id";
    c_where += " from org_employee_contract a left join org_employee_contract_change b ";
    c_where += " on a.id=b.contract_id and b.change_date is not null, org_employee c ";
    c_where += " where a.emp_id=c.emp_id and c.userisdeleted=0 and c.userisactive=1  ";
    //c_where += " group by a.emp_id order by md desc ";
    DbOpt dbopt = new DbOpt();
    String[][] contractArr = null;
    try {
        contractArr = dbopt.executeQueryToStrArr2(c_where, 4);
        dbopt.close();
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            dbopt.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //=======================20080721修改【start】============================
    //12.	“合同变更”中的“变更时间”是指合同期限的“终止日期”，合同到期提醒的设置时间应该根据最后一次“变更时间”来设置。【中进汽贸需求】
    String nowDate = format.format(new Date());
    List clist = null;
    if(contractArr!=null&&contractArr.length>0){
        clist = new ArrayList(0);
        for(int i0=0; i0<contractArr.length; i0++){
            String tmp_emp_id = contractArr[i0][0];
            String tmp_enddate = contractArr[i0][1];
            String tmp_change_date = contractArr[i0][2];
			String tmp_id = contractArr[i0][3];
            Object[] oo = new Object[3];
            oo[0] = tmp_emp_id;
			oo[2] =tmp_id;
			if(tmp_enddate!=null && !tmp_enddate.equals("")){
				Date d1 = new Date(tmp_enddate.substring(0,10).replaceAll("-","/"));
				if(tmp_change_date!=null&&tmp_change_date.trim().length()>0){
					try{
						//Date d2 = new Date(tmp_change_date.trim().replaceAll("-","/"));
						//if(d1.compareTo(d2)<0){
						//	oo[1] = d2;
						//}
					}catch(Exception e){}
				}
				if(oo[1]==null)oo[1] = d1;
				clist.add(oo);
			}
        }
    }

    NewEmployeeBD nbd = new NewEmployeeBD();
    //取得合同到期提醒天数
    String days = nbd.getMaturityAlertSettingsValue("maturity_alert_settings", "10001", domainId);
    if (days == null || days.equals("")) {
        days = "30";
    }

    nowDate = getNextDay(nowDate, days);
    String empIds = "-1";
	String contractId="-1";
    if (clist != null && clist.size() > 0) {
        for (int i = 0; i < clist.size(); i++) {
            Object[] obj = (Object[]) clist.get(i);
            Date endDate = (Date) obj[1];
            String e = format.format(endDate);
            if (nowDate.compareTo(e) >= 0) {
                contractId += "," + obj[2].toString();
            }
        }
    }
	
    String where = "";
    where += " and (cpo.id in (" + contractId + ")) ";
    //=======================20080721修改【end】==============================    
    where = "where po.userIsDeleted=0 and po.userIsActive=1 " + where + " and po.domainId=" + domainId + " order by orgpo.orgIdString,po.empDutyLevel,po.userOrderCode,po.empName, po.workPackEndDate";
    Page _page = new Page("po.empId,po.empName,po.empEnglishName,po.empSex,po.empBirth,po.empDuty,po.empNativePlace," + "po.userAccounts,orgpo.orgNameString,orgpo.orgName,po.userIsActive,po.empLeaderName,orgpo.id,po.workPackEndDate,spo.name", "com.whir.org.vo.usermanager.ContractVO cpo left join cpo.contractStyle spo join cpo.employeeVO po join po.organizations orgpo", where);
    _page.setPageSize(1000);
    _page.setcurrentPage(currentPage);
    List list = _page.getResultList();
%>
<%!
	public List  quickSort(List list){
       int i, j;
	   Object[] temp = null;
       for (i = 0; i < list.size() - 1; i++) {
           for (j = 0; j < list.size() - i - 1; j++) {
			   Object[] arr = (Object[])list.get(j);
			   Object[] arr_ = (Object[])list.get(j+1);
			   
               if (((Date)arr[1]).after(((Date)arr_[1])) ) {
                   temp = arr;
                   list.set(j,arr_) ;
                   list.set(j + 1,temp) ;
               }
           }
        }
        return list;
   }	

%>

<div class="wh-human-remind">
        <div class="wh-human-remind-title">
            <span>合同到期</span>
            您的合同即将到期，请抓紧时间与人事部联系补签！
        </div>
        <table cellpadding="0" cellspacing="0" class="wh-human-remind-tab" style="table-layout: fixed;">
            <tr class="wh-human-remind-tab-tit">
                <td>姓名</td>
                <td>部门</td>
				<td>合同类型</td>
                <td>到期时间</td>
            </tr>
			
<%
	List htList = new ArrayList();
	if(list != null && list.size() > 0){
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");		
		for(int i=0; i<list.size(); i++){
			Object[] obj = (Object[])list.get(i);		
			for(int i0=0; i0<clist.size(); i0++){
				Object[] cc = (Object[])clist.get(i0);				
				if(obj[0].toString().equals(cc[0].toString())){
					Object[] htArr = new Object[4];
					htArr[0] = obj[1];
					htArr[1] = cc[1];
					htArr[2] = obj[9];//部门---xhd 2015-08-28添加-					
					//当未选合同时显示为空不能为null
					Object contractName=obj[14];
					System.out.println("contractName=========="+contractName);
					if(contractName==null){
						htArr[3]="";						
					}else{
						htArr[3] = obj[14];
					}
					htList.add(htArr);
					break;
				}
			}

		}
	}
	htList = quickSort(htList);
	if(list != null && list.size() > 0){
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
		int size = htList.size();
		if(size>pageSize){
			size = pageSize;
		}
		for(int i=0; i<size; i++){
			Object[] obj = (Object[])htList.get(i);		
			String endDate = sdf.format((Date)obj[1]);
			
%>
            <tr>
                <td><%=obj[0]%></td>
				<!--部门-xhd 2015-08-28添加-->
                <td><%=obj[2]%></td>
				<td><%=obj[3]%></td>
                <td><%=endDate.length()>=10?endDate.substring(0,10):endDate%></td>
            </tr>
			<%}}%>
		</table>
	</div>
<%}%>

<%
//if("3".equals(remindType)){//居住证提醒
if(remindType.indexOf(",3,")!=-1){   
    String viewSQL = "po.id,po.beginDate,po.continueDate,po.yearLimit,po.memos,ppo.empName ,orgpo.orgName ";
    String fromSQL = "com.whir.ezoffice.personnelmanager.po.EmpInhabitancyPO po join po.emp ppo join ppo.organizations orgpo ";
    String whereSQL = " where 1=1 ";

    String nowDate = format.format(new Date());

    NewEmployeeBD nbd = new NewEmployeeBD();
    //取得居住证到期提醒天数
    String days = nbd.getMaturityAlertSettingsValue("maturity_alert_settings", "10003", domainId);
    if (days == null || days.equals("")) {
        days = "7";
    }

    String endDate = getNextDay(nowDate, days);

    if (databaseType.indexOf("oracle") > -1) {
        whereSQL += " and to_char(po.continueDate, 'yyyy-MM-dd')<= '" + endDate + "'";
    } else if (databaseType.indexOf("mysql") > -1) {
        whereSQL += " and substr(concat(po.continueDate),1,10)<= '" + endDate + "'";
    } else {
        whereSQL += " and convert(char(10),po.continueDate,20) <= '" + endDate + "'";
    }
    //whereSQL += " order by po.beginDate desc ";
    whereSQL += " order by po.continueDate  ";

    Page _page = new Page(viewSQL, fromSQL, whereSQL);
    _page.setPageSize(pageSize);
    _page.setcurrentPage(currentPage);
    List list = _page.getResultList();
%>
<div class="wh-human-remind">
        <div class="wh-human-remind-title">
            <span>居住证到期</span>
            您的居住证即将到期，请抓紧时间与人事部联系补签！
        </div>
        <table cellpadding="0" cellspacing="0" class="wh-human-remind-tab">
            <tr class="wh-human-remind-tab-tit">
                <td>姓名</td>
                <td>部门</td>
                <td>到期时间</td>
            </tr>
<%
	if(list != null && list.size() > 0){
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
		for(int i=0; i<list.size(); i++){
			Object[] obj = (Object[])list.get(i);
%>
			<tr>
                <td><%=obj[5]%></td>
				<!--部门 -xhd 2015-08-31添加-->
                <td><%=obj[6]%></td>
                <td><%=sdf.format((Date)obj[2])%></td>
            </tr>
	<%}}%>
	</table>
 </div>
<%}%>	
	
<%
//if("4".equals(remindType)){//试用期提醒
if(remindType.indexOf(",4,")!=-1){   
    String c_where = "where 1=1 and aaa.employeeVO.userIsDeleted=0 and aaa.employeeVO.userIsActive=1 ";
    //取得有试用期限的并第一次签合同的员工
    c_where += " and (aaa.trailPeriod = '1' or  aaa.trailPeriod = '2' or aaa.trailPeriod = '3' or aaa.trailPeriod = '4' or aaa.trailPeriod = '5' or aaa.trailPeriod = '6') ";// and aaa.signedNumber = '1' ";
    c_where += " group by aaa.employeeVO.empId order by max(aaa.trailDate) ";

    //=======================20081028修改【start】============================
    Page cpage = new Page("distinct aaa.employeeVO.empId, max(aaa.trailDate)", "com.whir.org.vo.usermanager.ContractVO aaa", c_where);
    cpage.setPageSize(999999);
    cpage.setcurrentPage(1);

    List clist = cpage.getResultList();
    String nowDate = format.format(new Date());

    NewEmployeeBD nbd = new NewEmployeeBD();
    //取得试用期到期提醒天数
    String days = nbd.getMaturityAlertSettingsValue("maturity_alert_settings", "10004", domainId);
    if (days == null || days.equals("")) {
        days = "7";
    }

    nowDate = getNextDay(nowDate, days);
    String empIds = "-1";
    if (clist != null && clist.size() > 0) {
        for (int i = 0; i < clist.size(); i++) {
            Object[] obj = (Object[]) clist.get(i);
            Date trailDate = (Date) obj[1];
			if(trailDate!=null){
				String e = format.format(trailDate);
				//String trialPeriod = getNextDay(e, Integer.parseInt(obj[3] != null ? obj[3].toString() : "0") * 30 + "");
				if (nowDate.compareTo(e) >= 0) {
					empIds += "," + obj[0].toString();
				}
			}
        }
    }
    String where = "";
    where += " and (po.empId in (" + empIds + ")) ";
    //=======================20081028修改【end】==============================

    where = "where po.userIsDeleted=0 and po.userIsActive=1 " + where + " and po.domainId=" + domainId + " and po.jobStatus='试用' " + " order by orgpo.orgIdString,po.empDutyLevel,po.userOrderCode,po.empName";
    Page _page = new Page(" po.empId,po.empName,orgpo.orgNameString,orgpo.orgName,po.empDuty,po.empLeaderName", "com.whir.org.vo.usermanager.EmployeeVO po join po.organizations orgpo", where);
    _page.setPageSize(pageSize);
    _page.setcurrentPage(currentPage);
    List list = _page.getResultList();
%>
<div class="wh-human-remind">
        <div class="wh-human-remind-title">
            <span>试用期到期</span>
            您的试用期即将到期，请抓紧时间与本部门领导联系！
        </div>
        <table cellpadding="0" cellspacing="0" class="wh-human-remind-tab">
            <tr class="wh-human-remind-tab-tit">
                <td>姓名</td>
                <td>部门</td>
                <td>到期时间</td>
            </tr>
	<%
	List htList = new ArrayList();
	if(list != null && list.size() > 0){
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");		
		for(int i=0; i<list.size(); i++){
			Object[] obj = (Object[])list.get(i);			
			for(int i0=0; i0<clist.size(); i0++){
				Object[] cc = (Object[])clist.get(i0);				
				if(obj[0].toString().equals(cc[0].toString())){
					Object[] htArr = new Object[3];
					htArr[0] = obj[1];
					htArr[1] = cc[1];
					htArr[2] = obj[3];
					htList.add(htArr);
					break;
				}
			}

		}
	}
	htList = quickSort(htList);
	if(list != null && list.size() > 0){
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
		int size = htList.size();
		if(size>pageSize){
			size = pageSize;
		}
		for(int i=0; i<size; i++){
			Object[] obj = (Object[])htList.get(i);		
			String endDate = sdf.format((Date)obj[1]);
			
	%>

	<tr>
           <td><%=obj[0]%></td>
			<!--部门xhd 2015-08-31-->
            <td><%=obj[2]%></td>
            <td><%=endDate.length()>=10?endDate.substring(0,10):endDate%></td>
     </tr>
   
		<%}}%>

	</table>
</div>
<%}%>	



<%!
/**
 * 得到一个时间延后或前移几天的时间,nowdate为时间,delay为前移或后延的天数
 */
public static String getNextDay(String nowdate, String delay) {
    try {
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        String mdate = "";
        Date d = strToDate(nowdate);
        long myTime = (d.getTime() / 1000) +
                      Integer.parseInt(delay) * 24 * 60 * 60;
        d.setTime(myTime * 1000);
        mdate = format.format(d);
        return mdate;
    } catch (Exception e) {
        return "";
    }
}
/**
 * 将短时间格式字符串转换为时间 yyyy-MM-dd
 *
 * @param strDate
 * @return
 */
public static Date strToDate(String strDate) {
    SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
    ParsePosition pos = new ParsePosition(0);
    Date strtodate = formatter.parse(strDate, pos);
    return strtodate;
}
%>