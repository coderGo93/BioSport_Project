<%-- 
    Document   : citas
    Created on : Nov 1, 2016, 4:56:51 PM
    Author     : edgaralonsolopezorduno
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/resources/fonts/ring.svg" var="ringLoader" />
<jsp:include page="form-date.jsp"/>
<div class='container'>
    <div class='row'>
        <div class="col-xs-11 col-md-11 col-xs-offset-1">
            <div id="simpliest-usage2" class="box"></div>
        </div>
    </div>
    <button id='bShowDates'>Ver citas</button>
</div>

<div class='container '>
    <div class="row">
        <div class="col-sm-12 col-lg-12 col-md-12 container-results-date">
            <p class='today-date text-center'> 28 de octubre del 2016</p>
            <div class='loadMoreWhite'><p class='text-center'><img src="${ringLoader}" class="ringLoader"><span class="textLoadMore"><i>No hay citas en esta fecha</i></span></p></div>
            <table class="algo">

            </table>
        </div>
    </div>

</div>
<script type="text/javascript">

    $(".form-add-date").hide();
    $(".today-date").text(day + " de " + months[month] + " del " + year)
    var date;

    var fecha;
    var horas = ["00:00", "01:00", "02:00", "03:00", "04:00", "05:00", "06:00", "07:00", "08:00", "09:00"
                , "10:00", "11:00", "12:00", "13:00", "14:00", "15:00", "16:00", "17:00", "18:00", "19:00", "20:00"
                , "21:00", "22:00", "23:00"]
    $(".textLoadMore").hide();
    $(".ringLoader").hide();
    $('#simpliest-usage').multiDatesPicker({
        dateFormat: "d/m/y",
        maxPicks: 1
    });
    $('#simpliest-usage2').multiDatesPicker({
        dateFormat: "d/m/y",
        maxPicks: 1,
    });

    $("#bShowDates").click(function () {
        date = $('#simpliest-usage2').multiDatesPicker('value');
        if (date == "") {
            notification("Tienes que seleccionar una fecha", "#e85151");
        } else {
            fecha = date.split("/");
            citasFecha(fecha[0], fecha[1] - 1, "20" + fecha[2])
        }

    });
    $(document).on('click ', '.dates-doctor', function () {
        sesionPaciente($(this).attr('data-cita'))
    });
    $(document).on('click ', '.dates-terapista', function () {
        sesionPaciente($(this).attr('data-cita'))
    });
    function citasFecha(day, month, year) {
        var tipo;
        $(".ringLoader").show();
        $(".textLoadMore").hide();
        $(".today-date").text(day + " de " + months[month] + " del " + year);
        $(".algo").empty();
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
                    if (data.length == 0) {
                        flagLoader = 1;
                    } else {
                        flagLoader = 0;
                    }
                    for (var i = 0; i < data.length; i++) {
                        if (data[i][1].tipo == 1) {
                            tipo = "terapista"
                        }
                        if (data[i][1].tipo == 2) {
                            tipo = "doctor"
                        }
                        print = "                <tr id='" + horas[data[i][0].hour] + "' class=' dates-"+tipo+"' data-cita='" + data[i][1].id + "'>\n" +
                                "                    <td><p class='text-center'>" + data[i][2].nombre + "     " + horas[data[i][0].hour] + "</p>\n" +
                                "\n" +
                                "                    </td>\n" +
                                "                </tr>\n";
                        $(".algo").append(print);
                    }
                    if (flagLoader == 1) {
                        $(".ringLoader").hide();
                        $(".textLoadMore").show();
                    } else {
                        $(".ringLoader").hide();
                        $(".textLoadMore").hide();
                    }
                }
                if(!data){
                    window.location.href = "login.htm";
                }

            }
        });
    }
</script>