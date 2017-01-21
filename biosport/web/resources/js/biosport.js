
var activoMenu = 0;
var d = new Date();

var month = d.getMonth();
var months = ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"];
var day = d.getDate();
var year = d.getFullYear();
var hour = d.getHours();
var pos = 0;
var timeoutId = 0;
var activoRojo = 0;
var activoVerde = 0;
var activoScroll = 0;
var idAssist;
var width = $(window).width();
var activoBotonFecha = 0;
var activoFormDate = 0;

var selected;
var nSesiones = 0;
var flag = 0;
var flagMobileDesktop = 0;
var user;
var flagUser = 0;
var myUsers = [];

var assisted = 0;
var paciente = 0;
var sesion = 0;
var n = 0;
var tipo = 1;

$(document).ready(function () {

    $(".container-pestaña-general").hide();
    $(".form-add-date").hide();
    isHidden();
    $('#' + hour).css("background", "#d6d3d3");
    if (hour < 15) {
        pos = 0;
    } else {
        pos = 10;
    }
    $('html, body').animate({
        scrollTop: pos
    }, 500);

    $("#date-time").val(hour);
    var date_input = $('input[name="date"]'); //our date input has the name "date"
    var container = $('.bootstrap-iso form').length > 0 ? $('.bootstrap-iso form').parent() : "body";
    var options = {
        format: 'dd/mm/yyyy',
        container: container,
        todayHighlight: true,
        autoclose: true,
    };
});



$('.today-date').text(day + " de " + months[month] + " del " + year)
$(document).on('click ', '.navbar-toggle', function () {

    if ($(".container-menu").hasClass("hidden-xs")) {
        $(".container-menu").removeClass("hidden-xs");
    } else {
        $(".container-menu").addClass("hidden-xs");
    }

});
function isHidden() {
    if ($('.container-menu').is(':hidden')) { // cuando es movil
        $('.container-menu').css("margin-top", "11.6%");
        if (flagMobileDesktop == 0) {
            $('.container-agenda').css("margin-top", "18%");
            $('.img-plus').css("margin-top", "4%");
            $('.container-menu').css("margin-top", "-2.3%");
        }

        flagMobileDesktop = 1;

    } else { // cuando es desktop
        if (flagMobileDesktop)
            $('.container-agenda').css("margin-top", "4%");
    }
}

$(document).on('mousedown ', '.circle-default', function () {
    idAssist = $(this).attr("data-assist");
    paciente = $(this).attr("data-paciente");
    idCita = $(this).attr("data-cita");
    timeoutId = setTimeout(function () {
        assisted = 2;
        activoVerde = 0;
        activoRojo = 1;

        asistirCita(paciente, idCita, assisted, idAssist, 1)

    }, 200);
}).bind('mouseup mouseleave', function () {

    clearTimeout(timeoutId);

});
var timer;
var touchduration = 300;
$(document).on('touchend', '.circle-default', function () {
    if (timer) {
        clearTimeout(timer);
    }
});
$(document).on('touchstart', '.circle-default', function () {
    idAssist = $(this).attr("data-assist");
    paciente = $(this).attr("data-paciente");
    idCita = $(this).attr("data-cita");
    timer = setTimeout(function () {
        assisted = 2;
        activoVerde = 0;
        activoRojo = 1;

        asistirCita(paciente, idCita, assisted, idAssist, 1)

    }, touchduration);
});



$(document).on('click touchstart', '.circle-default', function () {

    activoVerde = 1;
    if (activoRojo == 0 && activoVerde == 1) {
        idAssist = $(this).attr("data-assist");
        assisted = 1;
        paciente = $(this).attr("data-paciente");
        idCita = $(this).attr("data-cita");
        asistirCita(paciente, idCita, assisted, idAssist, 1);

        activoVerde = 0;

    }
    activoRojo = 0;
});

$(document).on('click ', '.img-plus', function () {

    $("html, body").animate({scrollTop: 0}, "slow");
    $(".form-add-date").slideToggle("slow");

    $(".container-menu").addClass("hidden-xs");
    activoMenu = 0;
    $('#name').val('');
    $('#date').val('');
    activoBotonFecha = 0;
});
$(document).on('click ', '.container-agenda', function () {
    $(".container-menu").addClass("hidden-xs");
    activoMenu = 0;
});
$(document).on('click ', '.search-field', function () {
    $(".container-menu").addClass("hidden-xs");
    activoMenu = 0;
});




$("#search-field").keyup(function () {
});
$(document).on('click ', '.date-doctor', function () {
    activoFormDate = 1;
    activoScroll = 0;
});
$(document).on('click ', '.date-terapista', function () {
    activoFormDate = 1;
    activoScroll = 0;
});
$(document).on('click ', '.circle-default', function () {
    activoFormDate = 1;
    activoScroll = 0;
});
$(document).on('click ', '.principal', function () {
    if (activoScroll == 1) {
        $("html, body").animate({scrollTop: 0}, "slow");
    }

    if (activoBotonFecha == 0 && activoFormDate == 0) {

        $(".form-add-date").slideToggle("slow");
        $(".container-menu").addClass("hidden-xs");
        activoMenu = 0;
        activoBotonFecha = 1;

    }
    $('#name').val('');
    $('#date').val('');
    $("#date-time").val($(this).attr('id'));
    activoFormDate = 0;
    activoScroll = 1;

});
$(document).on('click ', '.info-bEdit', function () {
    var textArea = $(".info-treatment").text();
    $('.td-info-treatment').html("<div class='form-group'><textarea class='form-control textArea' rows='10' cols='70' id='comment'></textarea></div>");
    $('#comment').val(textArea);
    $('.info-bEdit').hide();
    $('.info-bAccept').show();
    $('.info-bCancel').show();
});
$(document).on('click ', '.info-bCancel', function () {
    var textArea = $("#comment").val();
    $('.td-info-treatment').html("<span class='info-treatment'></span>");
    $('.info-treatment').text(textArea);
    $('.info-bEdit').show();
    $('.info-bAccept').hide();
    $('.info-bCancel').hide();
});
$(document).on('click ', '.info-bAccept', function () {
    var textArea = $("#comment").val();
    if (textArea.length > 0) {
        $.ajax({
            method: "POST",
            cache: false,
            url: "actualizarTratamiento.htm",
            data: {idCita: $(this).attr('data-cita'),
                tratamiento: textArea
            },
            success: function (data) {
                if (data == 0) {
                    notification("No se pudo actualizar el tratamiento", "#e85151")
                }
                if (data == 1) {
                    notification("Se ha actualizado el tratamiento", "#62e852")
                    $('.td-info-treatment').html("<span class='info-treatment'></span>");
                    $('.info-treatment').text(textArea);
                    $('.info-bEdit').show();
                    $('.info-bAccept').hide();
                    $('.info-bCancel').hide();
                }

            }
        });
    } else {
        notification("Tienes que llenar el tratamiento", "#e85151");
    }

});
$(document).on('click ', '.date-terapista', function () {
    sesionPaciente($(this).attr('data-cita'))

});
$(document).on('click ', '.date-doctor', function () {
    sesionPaciente($(this).attr('data-cita'))

});

$(document).on('click ', '.bPatient', function () {
    datosPaciente($(this).attr('data-paciente'), $(this).attr('data-nombre'))

});
$(document).on('click ', '.pPatients', function () {
    $(".container-menu").addClass("hidden-xs");
    $.ajax({
        method: "POST",
        cache: false,
        url: "pacientes.htm",
        data: {idUsuario: $(this).attr('data-user'),
            usuario: $(this).attr('data-usuario')
        },
        success: function (data) {
            document.title = "BioSport - Pacientes";
            $('.container-agenda').slideUp("slow");
            $('.container-agenda').slideDown("slow");
            $(this).data("timeout", setTimeout(function () {
                $(".container-agenda").html(data);

            }, 700));

        }
    });
});

$(document).on('click ', '.pDates', function () {
    $(".container-menu").addClass("hidden-xs");
    $.ajax({
        url: "citas.htm"
    }).done(function (data) {
        if (data != null) {
            document.title = "BioSport - Citas";
            $(".form-add-date").hide();
            $('.container-agenda').slideUp("slow");
            $('.container-agenda').slideDown("slow");
            $(this).data("timeout", setTimeout(function () {
                $(".container-agenda").html(data);

            }, 700));
        }
        if (!data) {
            window.location.href = "login.htm";
        }
    });
});

$(document).on('click ', '.bEditPass', function () {
    $(".container-menu").addClass("hidden-xs");
    $.ajax({
        url: "administrar_perfil.htm"
    }).done(function (data) {

        document.title = "BioSport - Administrar perfil";
        $('.container-agenda').slideUp("slow");
        $('.container-agenda').slideDown("slow");
        $(this).data("timeout", setTimeout(function () {
            $(".container-agenda").html(data);

        }, 700));
    });
});


$(document).on('click ', '.bLogout', function () {
    $.ajax({
        url: "logout.htm"
    }).done(function (data) {
        window.location.href = "login.htm";
    });
});
$(window).resize(function () {
    isHidden();
});

$(".container-user").each(function () {
    myUsers.push($(this).attr('data-user'));
});

$('.container-user').on('click ', function () {
    user = $(this).attr("data-user");
    $(".container-pestaña-" + user).show();

    for (var i = 0; i < myUsers.length; i++) {
        if (myUsers[i] == user) {

        } else {
            $(".container-pestaña-" + myUsers[i]).hide();
        }
    }


});
$(document).on('click ', '.principal2', function () {
    datosPaciente($(this).attr("data-paciente"), $(this).attr("data-nombre"))
});

function asistirCita(paciente, idCita, asistido, idAssist, tipo) {

    $.ajax({
        method: "POST",
        cache: false,
        url: "asistencia_cita.htm",
        data: {paciente: paciente,
            idCita: idCita,
            asistido: asistido
        },
        complete: function () {
        },
        success: function (data) {
            if (data == 0) {
                notification("Error de solicitud", "#e85151");
            }
            if (data > 0) {
                notification("Se ha actualizado la asistencia", "#62e852");
            }
            if (tipo == 1) {
                if (asistido == 1) {
                    $(".circle-default[data-assist='" + idAssist + "']").css("fill", "#11c711");
                    
                }
                if (asistido == 2) {
                    $(".circle-default[data-assist='" + idAssist + "']").css("fill", "red");
                }
            }
            if (tipo == 2) {
                if (asistido == 1) {
                    $(".glyphicon-ok").css("color", "#3fd03f");
                    $(".glyphicon-remove").css("color", "black");
                    $(".glyphicon-remove").off('hover');
                    $(".glyphicon-ok").hover(
                            function () {
                                $(".glyphicon-ok").css("color", "#3fd03f");
                            }, function () {
                        $(".glyphicon-ok").css("color", "#3fd03f");
                    });
                    $(".glyphicon-remove").hover(
                            function () {
                                $(".glyphicon-remove").css("color", "#f13f3f");
                            }, function () {
                        $(".glyphicon-remove").css("color", "black");
                    });
                }
                if (asistido == 2) {
                    $(".glyphicon-remove").css("color", "#f13f3f");
                    $(".glyphicon-ok").css("color", "black");
                    $(".glyphicon-ok").off('hover');
                    $(".glyphicon-remove").hover(
                            function () {
                                $(".glyphicon-remove").css("color", "#f13f3f");
                            }, function () {
                        $(".glyphicon-remove").css("color", "#f13f3f");
                    });
                    $(".glyphicon-ok").hover(
                            function () {
                                $(".glyphicon-ok").css("color", "#3fd03f");
                            }, function () {
                        $(".glyphicon-ok").css("color", "black");
                    });

                }
            }


        }
    });

}
function sesionPaciente(idCita) {
    $.ajax({
        method: "POST",
        cache: false,
        url: "sesion.htm",
        data: {idCita: idCita
        },
        complete: function () {
        },
        success: function (data) {
            if (data) {
                document.title = "BioSport - Sesión";
                $('.container-agenda').slideUp("slow");
                $('.container-agenda').slideDown("slow");
                $(this).data("timeout", setTimeout(function () {
                    $(".container-agenda").html(data);

                }, 700));
            }
            if (!data) {
                window.location.href = "login.htm"
            }

        }
    });
}

function datosPaciente(idPaciente, paciente) {
    $.ajax({
        method: "POST",
        cache: false,
        url: "paciente.htm",
        data: {idPaciente: idPaciente,
            paciente: paciente
        },
        complete: function () {
        },
        success: function (data) {
            if (data) {
                document.title = "BioSport - Datos del paciente";
                $('.container-agenda').slideUp("slow");
                $('.container-agenda').slideDown("slow");
                $(this).data("timeout", setTimeout(function () {
                    $(".container-agenda").html(data);

                }, 700));
            }
            if (!data) {
                window.location.href = "login.htm"
            }

        }
    });
}

function closeNotification() {
    $('.notification').slideUp('fast');
}
var delay = (function () {
    var timer = 0;
    return function (callback, ms) {
        clearTimeout(timer);
        timer = setTimeout(callback, ms);
    };
})();

function notification(texto, fondoColor) {
    $(".textNotification").text(texto);
    $(".notification").css("background", fondoColor);
    $('.notification').slideDown('fast');
    window.setTimeout(closeNotification, 2000);
}
$(document).on('click ', '.fondo-terapista', function () {
    getDataPatient(paciente, 1);

    $(".fondo-terapista").css("border-style", "solid");
    $(".fondo-medicina").css("border-style", "none");

});
$(document).on('click ', '.fondo-medicina', function () {
    getDataPatient(paciente, 2);
    $(".fondo-medicina").css("border-style", "solid");
    $(".fondo-terapista").css("border-style", "none");
});

function emptyTablePatient() {
    var texto = "<tr>\n" +
            "                            <td><strong>Cantidad de sesiones</strong></td>\n" +
            "                            <td class='td-number-session'>\n" +
            "                                <select class=\"select-bSessions\" disabled>\n" +
            "\n" +
            "                                    <option value=\"\">0</option>\n" +
            "\n" +
            "                                </select>\n" +
            "\n" +
            "                            </td>\n" +
            "                        </tr>"
    $(".info-table-session").html(texto);

}
function notEmptyTablePatient() {
    var texto = "<tr>\n" +
            "                            <td><strong>Cantidad de sesiones</strong></td>\n" +
            "                            <td class='td-number-session'>\n" +
            "                                <select class=\"select-bSessions\">\n" +
            "\n" +
            "                                    \n" +
            "\n" +
            "                                </select>\n" +
            "\n" +
            "                            </td>\n" +
            "                        </tr>\n" +
            "                        <tr>\n" +
            "                            <td><strong>Fecha del cita más reciente</strong></td>\n" +
            "                            <td class='td-info-date'><span class='info-date'></span></td>\n" +
            "                        </tr>\n" +
            "                        <tr>\n" +
            "                            <td><strong>Tratamiento más reciente</strong></td>\n" +
            "\n" +
            "                            <td class='td-info-treatment'>\n" +
            "                                <span class='info-treatment'></span></td>\n" +
            "                        </tr>\n" +
            "                        <tr>\n" +
            "                            <td></td>\n" +
            "                            <td class='td-info-bHTreatment'><button class='info-bHTreatment'>Historial de tratamiento</button><button class='info-bAccept'>Accept</button></td>\n" +
            "                        </tr>";
    $(".info-table-session").html(texto);
}
function getDataPatient(paciente, tipo) {
    var cont = 1;
    $.ajax({
        method: "POST",
        cache: false,
        url: "datosPaciente.htm",
        data: {paciente: paciente,
            tipo: tipo
        },
        success: function (data) {
            console.log(data);
            if (data.length == 0) {
                emptyTablePatient();
            }
            if (data.length > 0) {
                notEmptyTablePatient();
                for (var i = 0; i < data.length; i++) {

                    if (i == data.length - 1) {
                        $(".select-bSessions").append("<option value='" + data[i][0].id + "' selected>" + cont + "</option>");
                        $(".info-date").text("" + data[i][1].day + " de " + months[data[i][1].month - 1] + " del " + data[i][1].year + "");
                        $(".select-treatment").append("<option selected>" + data[i][2].tratamiento + "</option>");
                        $('.td-info-treatment').html("<span class='info-treatment'>" + data[i][2].tratamiento + "</span>");
                    } else {
                        $(".select-bSessions").append("<option value='" + data[i][0].id + "'>" + cont + "</option>");
                        $(".select-treatment").append("<option>" + data[i][2].tratamiento + "</option>");
                    }

                    cont++;
                }
                $(".select-bSessions").change(function () {

                    selected = $(".select-bSessions option:selected").val();
                    sesionPaciente(selected)

                });
            }

        }
    });
}