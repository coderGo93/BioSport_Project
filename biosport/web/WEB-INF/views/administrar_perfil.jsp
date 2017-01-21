<%-- 
    Document   : cambiar_contraseña
    Created on : Nov 2, 2016, 12:12:59 AM
    Author     : edgaralonsolopezorduno
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class=container>
    <div class="row">
        <div class="col-sm-12 col-lg-12 col-md-12">
            <h2 class="col-lg-offset-4 col-xs-offset-1">Cambiar contraseña</h2>
            <table class='table-password' col-md-8>
                <tr>
                    <td><label>Introduce la nueva contraseña</label></td>
                    <td><input type="password" placeholder="Contraseña" class="inputPassword" id='uPassword'></td>
                </tr>
                <tr style='margin-top: 2%'>
                    <td><label>Vuelve a introducir la contraseña</label></td>
                    <td><input type="password" placeholder="Comprobar contraseña" class="inputPassword" id='uMPassword'></td>
                </tr>
                <tr style='margin-top: 2%'>
                    <td></td>
                    <td><button class='bUpdatePass'>Actualizar contraseña</button></td>
                </tr>
            </table>
        </div>
    </div>
</div>
<div class=container>
    <div class="row">
        <div class="col-sm-12 col-lg-12 col-md-12">
            <h2 class="col-lg-offset-4 col-xs-offset-2">Agregar Usuario</h2>
            <table class='table-password'>
                <tr>
                    <td><label>Tipo de usuario</label></span></td>
                    <td>
                        <select id='tipoUsuario'>
                            <option value='1'>Terapia física</option>
                            <option value='2'>Medicina</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td><label>Introduce el usuario que desea agregar</label></span></td>
                    <td><input type="text" placeholder="Nuevo usuario" class="inputPassword" id='aUser'></td>
                </tr>
                <tr style='margin-top: 2%'>
                    <td><label>Introduce la contraseña</label></td>
                    <td><input type="password" placeholder="Contraseña" class="inputPassword" id='aPassword'></td>
                </tr>
                <tr style='margin-top: 2%'>
                    <td><label>Vuelve a introducir la contraseña</label></td>
                    <td><input type="password" placeholder="Comprobar contraseña" class="inputPassword" id='aMPassword'></td>
                </tr>
                <tr style='margin-top: 2%'>
                    <td></td>
                    <td><button class='bAddUser'>Agregar usuario</button></td>
                </tr>
            </table>
        </div>
    </div>
</div>
<script>
    var contraseña = $('#uPassword').val();
    var contraseña2 = $('#uMPassword').val();
    var contraseña3 = $('#aPassword').val();
    var contraseña4 = $('#aMPassword').val();
    var password;
    var usuario = $('#aUser').val();
    var existeUsuario = 0;
    var flagPassword = 0;
    var flagPassword2 = 0;
    var emptyUser = 0;
    var tipoUsuario = 0;
    $("#uPassword").keyup(function () {
        contraseña = $('#uPassword').val();
        contraseña2 = $('#uMPassword').val();
        if (contraseña2 == contraseña) {
            $("#uPassword").css("background", "#4aec4a");
            $("#uMPassword").css("background", "#4aec4a");
            flagPassword = 1;
            password = contraseña;
        } else {
            $("#uPassword").css("background", "#f15f5f");
            $("#uMPassword").css("background", "#f15f5f");
            flagPassword = 0;
        }
    });
    $("#uMPassword").keyup(function () {
        contraseña = $('#uPassword').val();
        contraseña2 = $('#uMPassword').val();
        if (contraseña2 == contraseña) {
            $("#uPassword").css("background", "#4aec4a");
            $("#uMPassword").css("background", "#4aec4a");
            flagPassword = 1;
            password = contraseña;
        } else {
            $("#uPassword").css("background", "#f15f5f");
            $("#uMPassword").css("background", "#f15f5f");
            flagPassword = 0;
        }
    });
    $(document).on('click ', '.bUpdatePass', function () {
        if (contraseña.length == 0 || contraseña2.length == 0) {
            notification("Tienes que llenar las contraseñas", "#e85151");
            flagPassword2 = 0;
        } else {
            flagPassword2 = 1;
        }
        if (flagPassword == 0 && flagPassword2 == 1) {
            notification("Las contraseñas no coinciden", "#e85151");
        }
        if (flagPassword == 1 && flagPassword2 == 0) {
            notification("Tienes que llenar las contraseñas", "#e85151");
        }

        if (flagPassword == 1 && flagPassword2 == 1) {
            $.ajax({
                method: "POST",
                url: "actualizarContraseña.htm",
                data: {
                    password: password},
                complete: function () {
                },
                success: function (data) {
                    if (data == 0) {
                        notification("No se pudo actualizar la contraseña", "#e85151");
                    }
                    if (data == 1) {
                        notification("Se ha actualizado la contraseña", "#62e852");
                    }

                    if (data == 2) {
                        window.location.href = "login.htm";
                    }
                }
            });
        }

    });
    $("#aPassword").keyup(function () {
        contraseña3 = $('#aPassword').val();
        contraseña4 = $('#aMPassword').val();
        if (contraseña3 == contraseña4) {
            $("#aPassword").css("background", "#4aec4a");
            $("#aMPassword").css("background", "#4aec4a");
            flagPassword = 1;
            password = contraseña4;
        } else {
            $("#aPassword").css("background", "#f15f5f");
            $("#aMPassword").css("background", "#f15f5f");
            flagPassword = 0;
        }
    });
    $("#aMPassword").keyup(function () {
        contraseña3 = $('#aPassword').val();
        contraseña4 = $('#aMPassword').val();
        if (contraseña3 == contraseña4) {
            $("#aPassword").css("background", "#4aec4a");
            $("#aMPassword").css("background", "#4aec4a");
            flagPassword = 1;
            password = contraseña4;
        } else {
            $("#aPassword").css("background", "#f15f5f");
            $("#aMPassword").css("background", "#f15f5f");
            flagPassword = 0;
        }
    });
    $("#aUser").keyup(function () {
        usuario = $('#aUser').val();

        delay(function () {
            $.ajax({
                method: "POST",
                url: "existeUsuario.htm",
                data: {usuario: usuario},
                complete: function () {
                },
                success: function (data) {

                    if (data == 0) {
                        $("#aUser").css("background", "#4aec4a");
                        existeUsuario = 0;
                    }
                    if (data == 1) {
                        $("#aUser").css("background", "#f15f5f");
                        existeUsuario = 1;
                    }
                    if (data == 2) {
                        window.location.href = "login.htm";
                    }
                }
            });
        }, 500);
    });
    $(document).on('click ', '.bAddUser', function () {
        if (contraseña3.length == 0 || contraseña4.length == 0) {
            notification("Faltan datos que llenar", "#e85151");
            flagPassword2 = 0;
        } else {
            flagPassword2 = 1;
        }
        if (usuario.length == 0) {
            emptyUser = 1;
        } else {
            emptyUser = 0;
        }
        if (flagPassword == 0 && flagPassword2 == 1) {
            notification("Las contraseñas no coinciden", "#e85151");
        }
        if (flagPassword == 1 && flagPassword2 == 0) {
            notification("Tienes que llenar las contraseñas", "#e85151");
        }
        if (flagPassword == 1 && flagPassword2 == 1 && emptyUser == 1) {
            notification("Tienes que introducir el usuario", "#e85151");
        }
        if (flagPassword == 1 && flagPassword2 == 1 && emptyUser == 0) {
            if (existeUsuario == 1) {
                notification("El usuario ya existe", "#e85151");
            } else {
                tipoUsuario = $('#tipoUsuario').val();
                $.ajax({
                    method: "POST",
                    url: "agregarUsuario.htm",
                    data: {user: usuario,
                        password: password,
                        tipo: tipoUsuario},
                    complete: function () {
                    },
                    success: function (data) {
                        if (data == 0) {
                            notification("No se pudo agregar el usuario", "#e85151");
                        }
                        if (data == 1) {
                            notification("Se ha agregado el usuario", "#62e852");
                        }
                        if (data == 2) {
                            window.location.href = "login.htm";
                        }
                    }
                });
            }
        }
    });
</script>