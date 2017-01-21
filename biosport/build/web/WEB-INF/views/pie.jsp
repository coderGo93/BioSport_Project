<%-- 
    Document   : pie
    Created on : Nov 1, 2016, 12:31:50 PM
    Author     : edgaralonsolopezorduno
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/resources/js/biosport.js" var="biosportJS" />
<spring:url value="/resources/js/biosport.js" var="jqueryJS" />
<spring:url value="/resources/js/bootstrap.min.js" var="bootstrapJS" />
<spring:url value="/resources/js/jquery-ui.multidatespicker.js" var="multidateJS" />
<spring:url value="/resources/js/jquery-ui-1.11.1.js" var="jqueryUIJS" />
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script type="text/javascript" src="${biosportJS}"></script>
<script type="text/javascript" src="${bootstrapJS}"></script>    
<script type="text/javascript" src="${multidateJS}"></script>  
<script type="text/javascript" src="${jqueryUIJS}"></script>
<script type="text/javascript">
    var activocMultiple = 0;
    var dates;
    var nuevoPaciente = 1;
    var paciente;
    var hora;
    var print;
    var colorCircle;
    var cont = 1;
    var tipo = 1;
    var idPaciente = 0;
    $(document).ready(function () {
        getAppointmentsByDate(day, month, year);
    });
    $('#simpliest-usage').multiDatesPicker({
        dateFormat: "d/m/y",
        maxPicks: 1
    });

    $(document).on('click ', '.cMultiple', function () {
        if (activocMultiple == 0) {
            $('#sMultiple-date').prop('checked', true);
        } else {
            $('#sMultiple-date').prop('checked', false);
        }

        $('#simpliest-usage').multiDatesPicker('destroy');
        if ($('#sMultiple-date').is(':checked')) {
            $('#simpliest-usage').multiDatesPicker({
                dateFormat: "d/m/y"
            });
            activocMultiple = 1;
        } else {
            $('#simpliest-usage').multiDatesPicker('resetDates');
            $('#simpliest-usage').multiDatesPicker({
                dateFormat: "d/m/y",
                maxPicks: 1
            });
            activocMultiple = 0;
        }
    });
    $(document).on('click', '#bAddDate', function () {
        dates = $('#simpliest-usage').multiDatesPicker('getDates');
        paciente = $("#search-patients").val();
        hora = $("#date-time option:selected").val();
        if (dates.length == 0 || paciente.length == 0) {
            if (dates.length == 0) {
                notification("Tienes que seleccionar al menos una fecha", "#e85151");
            }

        } else {

            $.ajax({
                method: "POST",
                cache: false,
                url: "agregarCita.htm",
                data: {fecha: dates,
                    isNewPatient: nuevoPaciente,
                    paciente: paciente,
                    hora: hora,
                    idPaciente: idPaciente
                },
                complete: function () {
                },
                success: function (data) {
                    console.log(data);
                    if (data == 1) {
                        
                        notification("Se ha agregado una cita", "#62e852");
                        getAppointmentsByDate(day, month, year)
                        nuevoPaciente = 1;
                    }
                    if(data == 2){
                        if(dates.length == 1){
                            notification("El día que seleccionaste está lleno", "#e85151");
                        }
                        if (dates.length > 1){
                            notification("Alguno de los días que seleccionaste está lleno", "#e85151");
                        }
                        
                    }
                    if (data == 3) {
                        window.location.href = "login.htm"
                    }
                }
            });
        }
    });

    function getAppointmentsByDate(day, month, year) {
        var tipo;
        $.ajax({
            method: "POST",
            cache: false,
            url: "citasPorFecha.htm",
            data: {dia: day,
                mes: month + 1,
                año: year
            },
            complete: function () {
            },
            success: function (data) {
                $(".algo").empty();
                if (data) {
                    for (var i = 0; i < data.length; i++) {
                        if (data[i][1].tipo == 1) {
                            tipo = "terapista"
                        }
                        if (data[i][1].tipo == 2) {
                            tipo = "doctor"
                        }
                        if (data[i][1].assisted == 0) {
                            colorCircle = "black"
                        }
                        if (data[i][1].assisted == 1) {
                            colorCircle = "#11c711"
                        }
                        if (data[i][1].assisted == 2) {
                            colorCircle = "red"
                        }
                        print = "<tr id='00'  class='tr-"+tipo+"'>\n" +
                                "                                    <td>\n" +
                                "                                        <svg width=\"30\" height=\"30\">\n" +
                                "                                        <circle class='circle-default' data-assist=" + cont + " data-paciente=" + data[i][1].idPaciente + " data-cita=" + data[i][1].id + "  cx=\"15\" cy=\"15\" r=\"15\"  fill=" + colorCircle + " />\n" +
                                "                                        </svg>\n" +
                                "                                    </td>\n" +
                                "                                    <td>\n" +
                                "                                        <div class='date-" + tipo + "' data-cita=" + data[i][1].id + ">\n" +
                                "                                            <span class='date-session' >"+ data[i][2].id +"  - " + data[i][2].nombre + "</span>\n" +
                                "                                        </div>\n" +
                                "                                    </td>\n" +
                                "                                </tr>";

                        $("#table-" + data[i][0].hour).append(print);
                        cont++;

                    }
                    nuevoPaciente = 0;
                }
                if(!data){
                    window.location.href = "login.htm";
                }

            }
        });

    }
    function busquedaPaciente(escrito, tipo){
    delay(function () {
            $.ajax({
                method: "POST",
                cache: false,
                url: "busquedaPacientes.htm",
                data: {
                    buscar: escrito
                },
                complete: function () {
                },
                success: function (data) {
                    resultadosPacientes = [];
                    for (var i = 0; i < data.length; i++) {
                        resultadosPacientes.push({
                            id: data[i].id,
                            value: data[i].nombre + " - " + data[i].id
                        });
                    }


                    autocomplete(tipo)
                }
            });


        }, 100);
}
</script>
</body>

</html>
