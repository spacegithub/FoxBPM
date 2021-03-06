<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="../common/head.jsp" flush="true" />
<script type="text/javascript">
	$(function() {
		$("a[name=flowGraph]")
				.click(
						function() {
							var pdk = $(this).attr("pdk");
							var pii = $(this).attr("pii");
							window
									.open("foxbpm/showTaskDetailInfor.html?processDefinitionKey="
											+ pdk + "&processInstanceId=" + pii);
						});
		var status = '${result.status}';
		if (status != '')
			$("#status").val(status);

		$("#selectUser").click(function() {
			var obj = {
				type : "user"
			};
			var data = FoxbpmSelect(obj);
			if (data && data.length > 0) {
				$("#initor").val(data[0].userId);
				$("#initorName").val(data[0].userName);
			}
		});

		$("#processType_" + $("#processType").val()).css("background-color",
				"#ffffff");
	});
	function clearInfo() {
		$("#title").val("");
		$("#processDefinitionKey").val("");
		$("#processDefinitionName").val("");
		$("#bizKey").val("");
		$("#initor").val("");
		$("#initorName").val("");
		$("#startTimeS").val("");
		$("#startTimeE").val("");
		$("#status").val("");
	}
</script>
</head>
<body>
	<div class="main-panel">
		<jsp:include page="top.jsp" flush="true" />
		<div class="center-panel">
			<form id="subForm" method="post" action="queryProcessInst.action">
				<!-- 左 -->
				<div class="left">
					<div class="left-nav-box">
						<div class="left-nav" id="processType_">
							<a id="getAllProcess" name="getAllProcess" target="_self"
								href="javascript:void(0)"
								onclick="$('#processType').val('');$('#subForm').submit();"
								style="display: block;">全部流程</a>
						</div>
						<div class="left-nav-orange-line">&nbsp;</div>
						<div class="left-nav" id="processType_initor">
							<a id="getInitorTask" name="getInitorTask" target="_self"
								href="javascript:void(0)"
								onclick="$('#processType').val('initor');$('#subForm').submit();"
								style="display: block;">我发起的流程</a>
						</div>
						<div class="left-nav-orange-line">&nbsp;</div>
						<div class="left-nav" id="processType_participants">
							<a id="getInitorTask" name="getParticipantsTask" target="_self"
								href="javascript:void(0)"
								onclick="$('#processType').val('participants');$('#subForm').submit();"
								style="display: block;">我参与的流程</a>
						</div>
						<div class="left-nav-orange-line">&nbsp;</div>
					</div>
				</div>
				<!-- 右-->
				<div class="right">
					<!-- 查 -->
					<div id="search" class="search">
						<input type="hidden" id="processType" name="processType"
							value="${result.processType}" />
						<table>
							<tr>
								<td class="title-r">${applicationScope.appInfo["task.subject"]}：</td>
								<td><input type="text" id="title" name="title"
									class="fix-input" value="${result.title}" /></td>
								<td class="title-r">${applicationScope.appInfo["task.processDefinitionName"]}：</td>
								<td><input type="text" id="processDefinitionName"
									name="processDefinitionName" class="fix-input"
									value="${result.processDefinitionName}" /></td>
								<td class="title-r">${applicationScope.appInfo["task.bizKey"]}：</td>
								<td><input type="text" id="bizKey" name="bizKey"
									class="fix-input" value="${result.bizKey}" /></td>
								<td>
									<table style="margin: 0">
										<tr>
											<td>
												<div class="btn-normal">
													<a href="javascript:void(0)" target="_self"
														onclick="$('#subForm').submit();">${applicationScope.appInfo["common.search"]}</a>
												</div>
											</td>
											<td>
												<div class="btn-normal">
													<a href="javascript:void(0)" onclick="clearInfo();">${applicationScope.appInfo["common.clear"]}</a>
												</div>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td class="title-r">${applicationScope.appInfo["task.initor"]}：</td>
								<td>
									<table style="margin: 0">
										<tr>
											<td><input type="hidden" id="initor" name="initor"
												class="fix-input" value="${result.initor}" /> <input
												type="text" id="initorName" readonly="true"
												name="initorName" class="fix-input" style="width: 94px;"
												value="${result.initorName}" /></td>
											<td>
												<div class="btn-normal">
													<a href="javascript:void(0)" onclick="" id="selectUser">${applicationScope.appInfo["common.select"]}<em
														class="arrow-small"></em></a>
												</div>
											</td>
										</tr>
									</table>
								</td>
								<td class="title-r">${applicationScope.appInfo["task.startTime"]}：</td>
								<td><input type="text" id="startTimeS" name="startTimeS"
									class="fix-input" style="width: 69px;"
									value="${result.startTimeS}" onClick="WdatePicker()" /> - <input
									type="text" id="startTimeE" name="startTimeE" class="fix-input"
									style="width: 69px;" value="${result.startTimeE}"
									onClick="WdatePicker()" /></td>
								<td class="title-r">${applicationScope.appInfo["task.status"]}：</td>
								<td><select id="status" name="status" class="fix-input"
									style="width: 172px;">
										<option value="">请选择</option>
										<option value="SUSPEND">暂停</option>
										<option value="RUNNING">运行中</option>
										<option value="COMPLETE">完成</option>
										<option value="TERMINATION">终止</option>
								</select></td>
								<td></td>
							</tr>
						</table>
					</div>
					<div class="content">
						<!-- 表 -->
						<table width="100%" class="fix-table">
							<thead>
								<th width="30px">${applicationScope.appInfo["common.no"]}</th>
								<th>${applicationScope.appInfo["task.processDefinitionName"]}</th>
								<th>${applicationScope.appInfo["task.subject"]}</th>
								<c:if test="${result.processType != 'initor'}">
									<th>${applicationScope.appInfo["task.initor"]}</th>
								</c:if>

								<th width="130">${applicationScope.appInfo["task.startTime"]}</th>
								<th width="130">${applicationScope.appInfo["task.endTime"]}</th>
								<th>${applicationScope.appInfo["task.nodeName"]}</th>
								<th>${applicationScope.appInfo["task.status"]}</th>
								<th>${applicationScope.appInfo["common.operation"]}</th>
							</thead>
							<tbody>
								<c:forEach items="${result.dataList}" var="dataList"
									varStatus="index">
									<tr>
										<td style="text-align: center;">${(index.index+1)+pageInfor.pageSize*(pageInfor.pageIndex-1)}</td>
										<td>${dataList.processDefinitionName}</td>
										<td>${dataList.subject}</td>
										<c:if test="${result.processType != 'initor'}">
											<td>${dataList.initiatorName}</td>
										</c:if>
										<td><fmt:formatDate value="${dataList.startTime}"
												type="both" /></td>
										<td><fmt:formatDate value="${dataList.endTime}"
												type="both" /></td>
										<td>${dataList.nowNodeInfo}</td>
										<td><c:if test="${dataList.instanceStatus == 'suspend'}"
												var="runStatue">暂停</c:if> <c:if
												test="${dataList.instanceStatus == 'running'}"
												var="runStatue">运行中</c:if> <c:if
												test="${dataList.instanceStatus == 'complete'}"
												var="runStatue">完成</c:if> <c:if
												test="${dataList.instanceStatus == 'termination'}"
												var="runStatue">终止</c:if></td>
										<td><a name="flowGraph" href="javascript:void(0)"
											pii="${dataList.id}" pdk="${dataList.processDefinitionKey}">查看</a></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						<!-- 分页 -->
						<div id="page">
							<jsp:include page="../common/page.jsp" flush="true" />
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
	<!-- 隐藏参数部分 -->
	<input type="hidden" name="userId"
		value="<c:out value="${result.userId}"/>">
	<input type="hidden" name="type"
		value="<c:out value="${result.action}"/>">
</body>
</html>
