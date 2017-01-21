<%-- 
    Document   : pacientes
    Created on : Nov 1, 2016, 4:56:46 PM
    Author     : edgaralonsolopezorduno
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/resources/fonts/ring.svg" var="ringLoader" />
<jsp:include page="form-date.jsp"/>
<p class='tPatients text-center'> <strong>Pacientes del ${param.usuario}</strong></p>
<div class=container>
    <div class="row">
        <div class="col-sm-12 col-lg-12 col-md-12">

            <input id='search-patient' placeholder="Nombre del paciente" type="text" >
        </div>
    </div>
</div>

<div class=container>
    <div class="row">
        <div class="col-sm-12 col-lg-12 col-md-12">
            <table class="algo">

            </table>
            <div class='loadMore'><p class='text-center'><img src="${ringLoader}" class="ringLoader"><span class="textLoadMore">Cargar más pacientes</span></p></div>
        </div>
    </div>
</div>
<script type="text/javascript">
    var cont = 0;
    var flagLoader = 0;
    autocomplete("search-patient");
    pacientes(${param.idUsuario})
    $(document).on('click ', '.loadMore', function () {
        pacientes(${param.idUsuario})
    });
    
    $(".form-add-date").hide();
    $(".algo").empty();
    $('#simpliest-usage').multiDatesPicker({
        dateFormat: "d/m/y",
        maxPicks: 1
    });
    

    $('#search-patient').keyup(function () {
        var escrito = $('#search-patient').val();
        resultadosPacientes = [];
        busquedaPaciente(escrito,"search-patient");
    });


    
    function pacientes(idUsuario) {
        $(".loadMore").css("padding-bottom", "0");
        $(".loadMore").css("padding-top", "0");
        $(".textLoadMore").hide();
        $(".ringLoader").show();
        $.ajax({
            method: "POST",
            cache: false,
            url: "listaPacientes.htm",
            data: {idUsuario: idUsuario,
                actual: cont
            },
            complete: function () {
            },
            success: function (data) {
                console.log(data)
                if (data) {
                    $(".loadMore").css("padding-bottom", "5px");
                    $(".loadMore").css("padding-top", "10px");
                    if (data.length == 0) {
                        flagLoader = 1;
                    } else {
                        flagLoader = 0;
                    }
                    $(".textLoadMore").show();
                    $(".ringLoader").hide();
                    for (var i = 0; i < data.length; i++) {
                        print = "                <tr class='principal2' data-paciente='" + data[i].id + "' data-nombre='"+ data[i].nombre +"'>\n" +
                                "                    <td><p>"+data[i].id+" - " + data[i].nombre + "</p>\n" +
                                "\n" +
                                "                    </td>\n" +
                                "                </tr>\n";
                        $(".algo").append(print);
                        cont++;
                        flagLoader = 0;
                    }
                    if (flagLoader == 0) {
                        $(".textLoadMore").text("Cargar más pacientes");
                    } else {
                        $(".textLoadMore").text("Ya no hay más pacientes que mostrar");

                    }
                }
                if (!data) {
                    window.location.href = "login.htm";
                }

            }
        });
    }
</script>
