<%-- 
    Document   : sesion
    Created on : Nov 1, 2016, 3:45:34 PM
    Author     : edgaralonsolopezorduno
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="form-date.jsp"/>
<br>
<div class=container>

    <div class="row">
        <div class="col-sm-12 col-lg-11 col-md-12 " >
            <p class='text-center bPatient' data-paciente="${sesion[1].id}" data-nombre="${sesion[1].nombre}">${sesion[1].nombre}</p><br>
            <table class='info-table-session'>
                <tr>
                    <td><strong>Número del sesión</strong></td>
                    <td class='td-number-session'><span class='number-session'>${sesion[2].idSesion}</span></td>
                </tr>
                <tr>
                    <td><strong>Fecha del cita</strong></td>
                    <td class='td-info-date'><span class='info-date'></span></td>
                </tr>
                <tr>
                    <td><strong>Hora del cita</strong></td>
                    <td class='td-info-time-date'><span class='info-time-date'>${sesion[3].hour}</span></td>
                </tr><tr>
                    <td><strong>Tratamiento</strong></td>
                    <td class='td-info-treatment'><span class='info-treatment'>${sesion[4].tratamiento}</span></td>
                </tr>
                <tr>
                    <td></td>
                    <td class='td-info-bEdit'><button class='info-bEdit'>Editar</button><button class='info-bAccept' data-cita='${sesion[2].id}' data-idPaciente='${sesion[1].id}'>Aceptar</button><button class='info-bCancel'>Cancelar</button></td>
                </tr>
            </table>
        </div>

        <div class="col-sm-12 col-lg-11 col-md-12 " >
            <table class='table-assist col-xs-8 col-xs-offset-3    col-md-offset-4'>
                <tr>
                    <td><i class='glyphicon glyphicon-ok'></i></td>
                    <td><i class='glyphicon glyphicon-remove'></i></td>
                </tr>

            </table>
        </div>
    </div>
</div>

<script type="text/javascript">
    var hora;
    var asistido = ${sesion[2].assisted};
    
    $(document).on('click ', '.glyphicon-ok', function () {
        asistirCita(${sesion[1].id}, ${sesion[2].id}, 1, 0, 2);
    });
    $(document).on('click ', '.glyphicon-remove', function () {
        asistirCita(${sesion[1].id}, ${sesion[2].id}, 2, 0, 2);
    });
    
    $(".info-date").text("${sesion[3].day} de " + months[${sesion[3].month} - 1] + " del ${sesion[3].year}");
    
    
    $(".form-add-date").hide();
    $('#simpliest-usage').multiDatesPicker({
        maxPicks: 1
    });
    
    if (asistido == 1) {
        $(".glyphicon-ok").css("color", "#3fd03f");
        $(".glyphicon-remove").css("color", "black");
        iconHover(1);
    }
    if (asistido == 2) {
        $(".glyphicon-remove").css("color", "#f13f3f");
        $(".glyphicon-ok").css("color", "black");
        iconHover(2);
    }
    
    if ($(".info-time-date").text().length == 1) {
        hora = $(".info-time-date").text();
        $(".info-time-date").text("0" + hora + ":00")
    } else {
        hora = $(".info-time-date").text();
        $(".info-time-date").text(hora + ":00")
    }

    function iconHover(tipo) {
        if (tipo == 1) {
            $(".glyphicon-remove").hover(
                    function () {
                        $(".glyphicon-remove").css("color", "#f13f3f");
                    }, function () {
                $(".glyphicon-remove").css("color", "black");
            }
            );
        }
        if (tipo == 2) {
            $(".glyphicon-ok").hover(
                    function () {
                        $(".glyphicon-ok").css("color", "#3fd03f");
                    }, function () {
                $(".glyphicon-ok").css("color", "black");
            }
            );
        }

    }
</script>