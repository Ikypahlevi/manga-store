<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="/WEB-INF/views/includes/header.jsp" />

<jsp:include page="${view}" />

<jsp:include page="/WEB-INF/views/includes/chatbot.jsp" />

<jsp:include page="/WEB-INF/views/includes/footer.jsp" />
