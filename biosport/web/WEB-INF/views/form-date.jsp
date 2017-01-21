<%-- 
    Document   : form-date
    Created on : Nov 1, 2016, 9:56:23 PM
    Author     : edgaralonsolopezorduno
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/resources/js/auto-complete.min.js" var="easyAutoCompleteJS" />

<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<div class=container>
    <div class="row">
        <div class="col-sm-12 col-lg-12 col-md-12 form-add-date">
            <table>
                <tr>
                    <td>Nombre del paciente</td>
                    <td><input id='search-patients' name="search-patient"  placeholder="Nombre del paciente" type="text"></td>
                </tr>
                <tr>
                    <td>Fecha del sesión</td>
                    <td>
                        <div class='cMultiple'><input id='sMultiple-date' type="checkbox" name="multiple-date" value="multiple-date"> Múltiple fechas</div>
                        <div id="simpliest-usage" class="box"></div>
                    </td>
                </tr>
                <tr>
                    <td>Hora del sesión</td>
                    <td>
                        <select id='date-time'>
                            <option value="0">00:00</option>
                            <option value="1">01:00</option>
                            <option value="2">02:00</option>
                            <option value="3">03:00</option>
                            <option value="4">04:00</option>
                            <option value="5">05:00</option>
                            <option value="6">06:00</option>
                            <option value="7">07:00</option>
                            <option value="8">08:00</option>
                            <option value="9">09:00</option>
                            <option value="10">10:00</option>
                            <option value="11">11:00</option>
                            <option value="12">12:00</option>
                            <option value="13">13:00</option>
                            <option value="14">14:00</option>
                            <option value="15">15:00</option>
                            <option value="16">16:00</option>
                            <option value="17">17:00</option>
                            <option value="18">18:00</option>
                            <option value="19">19:00</option>
                            <option value="20">20:00</option>
                            <option value="21">21:00</option>
                            <option value="22">22:00</option>
                            <option value="23">23:00</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td><button id='bAddDate'>Agregar</button></td>
                </tr>
            </table>
        </div>
    </div>
</div>



<script>

    var d = new Date();
    var hour = d.getHours();
    var resultadosPacientes = [];
    $("#date-time").val(hour);
    autocomplete("search-patients", 0)
    $('#search-patients').keyup(function () {
        var escrito = $('#search-patients').val();
        resultadosPacientes = [];

        busquedaPaciente(escrito, "search-patients");

    });


    function autocomplete(selector, flag) {
        $("#" + selector + "").autocomplete({
            change: function (event, ui) {
                try {
                    if (ui.item.id) {
                        nuevoPaciente = 0;
                    }
                } catch (err) {
                    nuevoPaciente = 1;
                }
                console.log(nuevoPaciente)

            },
            source: resultadosPacientes,
            select: function (event, ui) {
                idPaciente = ui.item.id;
                nuevoPaciente = 0;
                if (flag == 1) {
                    datosPaciente(idPaciente)
                }
            }

        });
    }
</script>       