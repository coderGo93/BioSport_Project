<%-- 
    Document   : cabecera
    Created on : Nov 1, 2016, 12:31:55 PM
    Author     : edgaralonsolopezorduno
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/resources/css/bootstrap.min.css" var="bootstrapCSS" />
<spring:url value="/resources/css/styles.css" var="stylesCSS" />
<spring:url value="/resources/img/add.png" var="addPNG" />
<spring:url value="/resources/css/Navigation-with-Search1.css" var="navigationCSS" />
<spring:url value="/resources/css/jquery-ui.css" var="jqueryUI" />
<spring:url value="/resources/css/jquery-ui.structure.css" var="jqueryStructure" />
<spring:url value="/resources/css/jquery-ui.theme.css" var="jqueryTheme" />
<spring:url value="/resources/js/auto-complete.min.js" var="autoCompleteJS" />
<spring:url value="/resources/css/auto-complete.css" var="autoCompleteCSS" />
<spring:url value="/agenda" var="agenda" />
<spring:url value="/login" var="login" />
<!DOCTYPE html>
<html>

    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>BioSport - Agenda</title>
        <link rel="stylesheet" type="text/css" href="${bootstrapCSS}">
        <link rel="stylesheet" type="text/css" href="${stylesCSS}">
        <link rel="stylesheet" type="text/css" href="${navigationCSS}">
        <link rel="stylesheet" type="text/css" href="${jqueryUI}">
        <link rel="stylesheet" type="text/css" href="${jqueryStructure}">
        <link rel="stylesheet" type="text/css" href="${jqueryTheme}">
        <link rel="stylesheet" type="text/css" href="${autoCompleteCSS}">
        <link rel="stylesheet" type="text/css" href="${easyAutoCompleteCSS}">
        <script src="//code.jquery.com/jquery-1.11.2.min.js"></script>
        <link rel="stylesheet" type="text/css" href="${easyAutoCompleteThemeCSS}">

    </head>

    <body>
        <div>

            <nav class="navbar navbar-default navbar-fixed-top">
                <div class="container-fluid container-navbar">
                    <div class="navbar-header">
                        <a class="navbar-brand hidden-xs titleHeader" href="${agenda}">BioSport</a>
                    </div>
                    <button class="navbar-toggle collapsed pull-left" data-toggle="collapse" data-target="#navcol-1"><span class="sr-only">Toggle navigation</span><span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span></button>
                    <img alt="Brand" src="${addPNG}" class='img-plus col-md-offset-6  col-xs-offset-4'>
                </div>
            </nav>
            <div class='notification'><p class='text-center textNotification'>Hola</p></div>
            <div class='container-menu hidden-xs  col-xs-8 col-md-3'>

                <c:forEach var="usuario" items="${usuarios}" varStatus="status">

                    <div class="container-user" data-user="${usuario.id}">
                        <div class="row">
                            <div class="col-md-12"><strong class="sUser">${usuario.name} </strong></div>
                            <div class="col-md-12  col-lg-10 col-xs-offset-1 container-pestaña-${usuario.id} container-pestaña-general">
                                <p class='pDates'>Citas </p>
                            </div>
                            <div class="col-md-12 col-lg-10 col-xs-offset-1 container-pestaña-${usuario.id}  container-pestaña-general">
                                <p class='pPatients'data-user="${usuario.id}" data-usuario='${usuario.name}'>Pacientes </p>
                            </div>
                        </div>
                    </div>
                </c:forEach>
                <div class="container-editPass">
                    <div class="row">
                        <div class="col-md-12 col-lg-6 bEditPass"><strong>Administrar perfil</strong></div>
                    </div>
                </div>
                <div class="container-log">
                    <div class="row">
                        <div class="col-md-12 col-lg-5 bLogout"><strong>Cerrar sesion</strong></div>
                    </div>
                </div>
            </div>

        </div>
