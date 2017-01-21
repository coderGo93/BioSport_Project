<%-- 
    Document   : login
    Created on : Nov 2, 2016, 4:50:27 PM
    Author     : edgaralonsolopezorduno
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<spring:url value="/resources/css/bootstrap.min.css" var="bootstrapCSS" />
<spring:url value="/resources/css/Login-Form-Clean.css" var="loginCleanCSS" />
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>BioSport</title>
        <link rel="stylesheet" href="${bootstrapCSS}" />
        <link rel="stylesheet" href="${loginCleanCSS}" />
    </head>
    <body>
        <div class="login-clean">
                <div class="illustration">BioSport</div>
        </div>
        </div>
    </body>
</html>
