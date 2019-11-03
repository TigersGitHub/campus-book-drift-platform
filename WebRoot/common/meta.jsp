<%@ page isELIgnored="false"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="localctx" value="${localpath}"/>
<c:set var="ctxfullpath" value="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/"/>

<c:if test="${ctx eq '/'}">
	<c:set var="ctxfullpath" value="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}"/>
</c:if>
<c:if test="${ctx eq '/'}">
	<c:set var="ctx" value=""/>
</c:if>
<c:if test="${localctx eq null}">
	<c:set var="localctx" value="${pageContext.request.contextPath}"/>
</c:if>

<meta charset="utf-8" />
<meta name="author" content="ShenHongtai" />
<meta name="department" content="JR1302, University of Jinan" />

<meta http-equiv="Cache-Control" content="no-store" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta name="renderer" content="webkit|ie-stand|ie-comp" />
