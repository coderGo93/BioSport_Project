<%-- 
    Document   : paciente
    Created on : Nov 1, 2016, 3:43:52 PM
    Author     : edgaralonsolopezorduno
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="form-date.jsp"/>
<div class=container>
    <div class="row">
        <div class="col-sm-12 col-lg-12 col-md-12">

            <c:choose>
                <c:when test="${not empty paciente}">

                    <p class='text-center'>${paciente[0][3].id}  -  ${paciente[0][3].nombre}</p><br>
                    <div class="col-sm-12 col-lg-4 col-lg-offset-4 col-md-12 fondos-tipos">
                        <div class="fondo-terapista">Datos de terapia física</div>
                        <div class="fondo-medicina">Datos de medicina</div>
                    </div><br><br>
                    <table class='info-table-session'>
                        <tr>
                            <td><strong>Cantidad de sesiones</strong></td>
                            <c:set var="sesiones"  value="${fn:length(paciente)}"/>
                            <td class='td-number-session'>
                                <select class="select-bSessions">
                                    <c:forEach var="patient" items="${paciente}" varStatus="status">
                                        <c:choose>
                                            <c:when test="${status.count == sesiones}">
                                                <option value="${patient[0].id}" selected>${status.count}</option>
                                            </c:when>
                                            <c:otherwise>
                                                <option value="${patient[0].id}">${status.count}</option>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                </select>

                            </td>
                        </tr>

                        <tr>
                            <td><strong>Fecha del cita más reciente</strong></td>
                            <td class='td-info-date'><span class='info-date'></span></td>
                        </tr>
                        <tr>
                            <td><strong>Tratamiento más reciente</strong></td>

                            <td class='td-info-treatment'>
                                <span class='info-treatment'>${paciente[sesiones-1][2].tratamiento}</span></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td class='td-info-bHTreatment'><button class='info-bHTreatment'>Historial de tratamiento</button><button class='info-bAccept'>Accept</button></td>
                        </tr>
                    </table>
                </c:when>
                <c:otherwise>
                    <p class='text-center'>${param.idPaciente} - ${nombre}</p><br>
                    <div class="col-sm-12 col-lg-4 col-lg-offset-4 col-md-12 fondos-tipos">
                        <div class="fondo-terapista">Datos de terapia física</div>
                        <div class="fondo-medicina">Datos de medicina</div>
                    </div><br><br>
                    <table class='info-table-session'>
                        <tr>
                            <td><strong>Cantidad de sesiones</strong></td>
                            <td class='td-number-session'>
                                <select class="select-bSessions" disabled>

                                    <option value="">0</option>

                                </select>

                            </td>
                        </tr>
                    </table>
                </c:otherwise>
            </c:choose>

        </div>
    </div>
</div>
<script type="text/javascript">
    var paciente = ${param.idPaciente};
    var tipo2 = ${sessionScope.tipo};
    if (tipo2 == 1) {
        $(".fondo-terapista").css("border-style", "solid");
        $(".fondo-medicina").css("border-style", "none");
    }
    if (tipo2 == 2) {
        $(".fondo-terapista").css("border-style", "none");
        $(".fondo-medicina").css("border-style", "solid");
    }
    $(".form-add-date").hide();
    $('#simpliest-usage').multiDatesPicker({
        maxPicks: 1
    });
    <c:if test="${not empty paciente}">
    $(document).on('click ', '.info-bHTreatment', function () {
        $('.td-info-treatment').html("<select class='select-treatment'></select>");

        <c:forEach var="patient" items="${paciente}" varStatus="status">
            <c:choose>
                <c:when test="${status.count == sesiones}">
        $(".select-treatment").append('<option selected>${patient[2].tratamiento}</option>');
                </c:when>
                <c:otherwise>
        $(".select-treatment").append('<option>${patient[2].tratamiento}</option>');
                </c:otherwise>
            </c:choose>
        </c:forEach>
        $(".select-treatment").change(function () {
            selected = $(".select-treatment option:selected").text();
            $('.td-info-treatment').html("<span class='info-treatment'>" + selected + "</span>");

        });

    });
    $(".select-bSessions").change(function () {

        selected = $(".select-bSessions option:selected").val();
        sesionPaciente(selected)

    });
    $(".info-date").text("${paciente[sesiones-1][1].day} de " + months[${paciente[sesiones-1][1].month} - 1] + " del ${paciente[sesiones-1][1].year}");
    </c:if>

</script>