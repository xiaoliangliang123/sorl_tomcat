<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/resource/common/js/header.jsp"%>
<%@ include file="/resource/common/js/sigma.jsp"%>
<%
	String webapp = request.getContextPath();
%>

<!--
 * 出勤部查询列表显示页面 
 * @version 2018-10-23
 * @author wangl
-->

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<script type="text/javascript">
		//删除操作的js方法
		function delFn07(rowNo)
		{
			var kfn07 = SigmaUtil.getCellValue('kfn07',rowNo);
			
			lconfirm("确认删除？", function (index) {
				lclose(index);
				var url = "<%=webapp%>/fn07/delete.act";
  			var params = "kfn07=" + kfn07;
			  SigmaUtil.doDelete(url,params);
		    },"提示");
		}

        //提交审批的js方法
        function submit(rowNo)
        {
            var kfn06 = SigmaUtil.getCellValue('kfn07',rowNo);

            var params = "kfn07=" + kfn06;

            var url = "<%=webapp%>/fn07/submit.act?"+params;

            var ltitle =  " 出勤簿: 提交审批";
            SigmaUtil.doUpdate(url,"850","600",ltitle);
        }

		//编辑/新增页面的js方法
		function editFn07(rowNo)
		{
			var kfn07 = SigmaUtil.getCellValue('kfn07',rowNo);
			var params = "kfn07=" + kfn07;
			var url = "<%=webapp%>/fn07/edit.act?"+params;
		    var ltitle = kfn07==null?"出勤部 : 添加":"出勤部 : 修改";
			SigmaUtil.doUpdate(url,"800","600",ltitle);
		}
        //批量退回模板下载的js方法
        function download(filename)
        {

            var url = "<%=webapp%>/fw10/download.act?filename="+filename;
            window.open(url);

        }
        //新增页面的js方法
        function addFn07()
        {

            var url = "<%=webapp%>/fn07/add.act"
            var ltitle ="出勤部 : 添加";
            SigmaUtil.doUpdate(url,"800","600",ltitle);
        }

        //列表页面显示
        function operateRenderer (value ,record,columnObj,grid,colNo,rowNo)
        {
            var str="";

            if(record.aa020h=='001'){
                str += '<a onclick="javascript:editFn07(\''+rowNo+'\');return false;"  href="javascript:void(0)" >修改</a>&nbsp;&nbsp;&nbsp;';
                str += '<a onclick="javascript:delFn07(\''+rowNo+'\');return false;"  href="javascript:void(0)" >删除</a>&nbsp;&nbsp;&nbsp;';
                str += '<a onclick="javascript:submit(\''+rowNo+'\');return false;"  href="javascript:void(0)" >提交审批</a>&nbsp;&nbsp;&nbsp;';
                //}else if(record.aa020_code=='002'){
                //	str += '<a onclick="javascript:editFn01(\''+record.kfn01+'\');return false;"  href="javascript:void(0)" >修改</a>&nbsp;&nbsp;&nbsp;';
                //	str += '<font color="gray">提交审批</font>&nbsp;&nbsp;&nbsp;';
            }else{
                str += '<font color="gray">修改</font>&nbsp;&nbsp;&nbsp;';
                str += '<font color="gray">删除</font>&nbsp;&nbsp;&nbsp;';
                str += '<font color="gray">提交审批</font>&nbsp;&nbsp;&nbsp;';
            }
            return str;
        }
</script>
<title>出勤部</title>
</head>

<body class="mainContent">
	<hx:title title="出勤部" />
	<div id="mainContent">
		<form method="post" action="<%=webapp %>/fn07/list.act">
			<hx:wrapArea id="queryzone" isDefaultWrap="false">
				<table class="searchTable">
					<tr class="odd">
						<td class="searchHeader1" nowrap>部门</td>
						<td class="searchHeader2" nowrap>
							<hx:codeselect property="eq_fk005" dataMeta="RES010" mask="select" msgName="所在部门" style="width:140px;"
										   styleClass="MySelect" emptyText="全部"  onchange="getOrgUsers(this.value)"></hx:codeselect>
						</td>
						<td class="searchHeader1" nowrap>填表日期</td>
						<td class="searchHeader2" nowrap>
							<hx:text property="gte_fn011" mask="date" />
							&nbsp;-&nbsp;
							<hx:text property="lte_fn011" mask="date" />
						</td>
						<td class="searchHeader1" nowrap>考勤月份</td>
						<td class="searchHeader2" nowrap>
							<select id="eq_fn012" name="eq_fn012" >
								<option value="">全部</option>
								<option value="1">1</option>
								<option value="2">2</option>
								<option value="3">3</option>
								<option value="4">4</option>
								<option value="5">5</option>
								<option value="6">6</option>
								<option value="7">7</option>
								<option value="8">8</option>
								<option value="9">9</option>
								<option value="10">10</option>
								<option value="11">11</option>
								<option value="12">12</option>
							</select>
						</td>
					</tr>



					<!--Begin：查询页面按钮区-->
					<tr class="even">
						<td colspan="4">
							<table class="buttonTable">
								<tr>
								    <td align="left">
								    	<hx:privilege url="/fn07/edit.act" type="button" style="disabled" value="添加" btnType="new" onclick="javascript:addFn07();" />
								    </td>
									<td align="left">
										<hx:privilege url="/fn07/edit.act" type="button" style="disabled" value="出勤部附件模板下载" btnType="new" onclick="javascript:download('chu_qin_bu_templete.xlsx');" />
									</td>
									<td align="right">
										<hx:privilege url="/fn07/list.act" type="button" style="disabled" value="查询" btnType="search" onclick="javascript:showProgressBar('操作进行中,请稍候...');SigmaUtil.doQuery(this.form);" />
										<input class="MyResetBtn" type="reset" value="重置">
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<!--End：查询页面按钮区-->
				</table>
			</hx:wrapArea>
		</form>

		<hx:wrapArea id="gridzone" title="出勤部明细" isDefaultWrap="false">
			<sgrid:table id="sigma" loadUrl="${pageContext.request.contextPath}/fn07/list.act"
				showIndexColumn="true" toolbarContent="nav | pagesize | xls | reload | state" exportFileName="出勤部列表"
				initJs="SigmaUtil.doQuery(document.forms[0]);" >
				<sgrid:column  title="ID" id="kfn07" hidden="true" />
				<sgrid:column width="11%" title="填表日期" id="fn011" align="center" cell="date" format="yyyy-MM-dd" />
				<sgrid:column width="11%" title="所在部门" id="fk005"  mappingItem="ORG"/>
				<sgrid:column width="11%" title="考勤月份" id="fn012" />
				<sgrid:column width="11%" title="操作人" id="aa011" mappingItem="SYSUSERS"/>
				<sgrid:column width="11%" title="操作时间" id="aa012" align="center" cell="date" format="yyyy-MM-dd hh:mm:ss" />
				<sgrid:column width="11%" title="工作流状态" id="aa020h"  hidden="true"/>
				<sgrid:column width="11%" title="工作流状态" id="aa020" mappingItem="AA020"/>
				<sgrid:column width="11%" title="备注" id="kd003" />
				<sgrid:extColumn  title="操作" id="opt" rendFunc="operateRenderer" align="center"/>
			</sgrid:table>
		</hx:wrapArea>
	</div>
</body>
</html>
