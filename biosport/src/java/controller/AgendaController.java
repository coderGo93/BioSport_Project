/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.CitaDAO;
import dao.FechaDAO;
import dao.PacienteDAO;
import dao.TratamientoDAO;
import dao.UsuarioDAO;
import java.io.IOException;
import static java.lang.Integer.parseInt;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.TblCitas;
import model.TblFechas;
import model.TblPacientes;
import model.TblUsuarios;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 *
 * @author edgaralonsolopezorduno
 */
@Controller("HomeController")
public class AgendaController {

    @Autowired
    private UsuarioDAO usuarioDAO;

    @Autowired
    private CitaDAO citaDAO;

    @Autowired
    private FechaDAO fechaDAO;

    @Autowired
    private PacienteDAO pacienteDAO;

    @Autowired
    private TratamientoDAO tratamientoDAO;

    @RequestMapping("/agenda")
    public String home(HttpServletRequest request, ModelMap model, HttpServletResponse response) {
        HttpSession session = request.getSession(true);
        String retorno = "";
        if (session.getAttribute("idUsuario") != null) {
            List<TblUsuarios> usuarios = new ArrayList<TblUsuarios>();

            usuarios = usuarioDAO.listaUsuarios();

            if (usuarios != null) {
                model.addAttribute("usuarios", usuarios);

            }
            retorno = "agenda";
        } else {
            retorno = "login";
        }

        return retorno;

    }

    @RequestMapping("/")
    public String home() {

        return "index";

    }

    @RequestMapping("/sesion")
    public String sesion(HttpServletRequest request, ModelMap model, HttpServletResponse response) {
        response.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(true);
        String retorno = "";
        if (session.getAttribute("idUsuario") != null) {
            int idCita = parseInt(request.getParameter("idCita"));

            Object[] cita = null;
            cita = (Object[]) citaDAO.informacionCitaPaciente(idCita);

            if (cita != null) {
                model.addAttribute("sesion", cita);
            }
            retorno = "sesion";
        } else {
            retorno = null;
        }

        return retorno;

    }

    @RequestMapping("/paciente")
    public String patient(HttpServletRequest request, ModelMap model, HttpServletResponse response) {
        response.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(true);
        String retorno = "";
        if (session.getAttribute("idUsuario") != null) {
            int idPaciente = parseInt(request.getParameter("idPaciente"));
            int tipo = (int) (session.getAttribute("tipo"));
            String paciente = request.getParameter("paciente");
            List<Object> cita = new ArrayList<Object>();
            cita = citaDAO.listaCitasIdPacienteTipo(idPaciente,tipo); 

            if (cita.size() != 0) {
                model.addAttribute("paciente", cita);
            } else {
                model.addAttribute("nombre", paciente);
            }
            retorno = "paciente";
        } else {
            retorno = null;
        }

        return retorno;

    }
    
    @RequestMapping("/datosPaciente")
    @ResponseBody
    public Object dataPatient(HttpServletRequest request, ModelMap model, HttpServletResponse response) {
        response.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(true);
        Object datos = null;
        if (session.getAttribute("idUsuario") != null) {
            int paciente = parseInt(request.getParameter("paciente"));
            int tipo = parseInt(request.getParameter("tipo"));

            datos = citaDAO.listaCitasIdPacienteTipo(paciente, tipo);
        } else {
            datos = null;
        }

        return datos;

    }
    
    

    @RequestMapping("/pacientes")
    public String patients(HttpServletRequest request, ModelMap model, HttpServletResponse response) {
        response.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(true);
        String retorno = "";
        if (session.getAttribute("idUsuario") != null) {
            retorno = "pacientes";
        } else {
            retorno = null;
        }
        return retorno;

    }

    @RequestMapping("/citas")
    public String dates(HttpServletRequest request, ModelMap model, HttpServletResponse response) {
        response.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(true);
        String retorno = "";
        if (session.getAttribute("idUsuario") != null) {
            retorno = "citas";
        } else {
            retorno = null;
        }
        return retorno;

    }

    @RequestMapping("/administrar_perfil")
    public String change_password(HttpServletRequest request, ModelMap model, HttpServletResponse response) {
        response.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(true);
        String retorno = "";
        if (session.getAttribute("idUsuario") != null) {
            retorno = "administrar_perfil";
        } else {
            retorno = null;
        }
        return retorno;

    }

    @RequestMapping("/login")
    public String login(HttpServletRequest request, ModelMap model, HttpServletResponse response) {
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(true);
        String retorno = "";
        if (session.getAttribute("idUsuario") != null) {
            List<TblUsuarios> usuarios = new ArrayList<TblUsuarios>();

            usuarios = usuarioDAO.listaUsuarios();

            if (usuarios != null) {
                model.addAttribute("usuarios", usuarios);

            }
            retorno = "agenda";
        } else {
            retorno = "login";
        }
        return retorno;

    }

    @RequestMapping("/checkLogin")
    public String checkLogin(HttpServletRequest request, ModelMap model) {

        HttpSession session = request.getSession(true);
        String retorno = "";
        if (session.getAttribute("idUsuario") != null) {
            retorno = "agenda";
        } else {
            String usuario = request.getParameter("user");
            String contraseña = request.getParameter("password");
            String correcto = usuarioDAO.checarContraseñaEncriptada(usuario, contraseña);
            TblUsuarios user;
            if (correcto != null) {
                user = usuarioDAO.iniciarSesion(usuario, correcto);

                if (user != null) {
                    session.setAttribute("idUsuario", user.getId());
                    session.setAttribute("tipo", user.getTipo());

                    List<TblUsuarios> usuarios = new ArrayList<TblUsuarios>();

                    usuarios = usuarioDAO.listaUsuarios();

                    if (usuarios != null) {
                        model.addAttribute("usuarios", usuarios);

                    }
                    retorno = "redirect";
                }
            } else {
                retorno = "login";
            }
        }

        return retorno;
    }

    @RequestMapping("/agregarUsuario")
    @ResponseBody
    public int addUser(HttpServletRequest request, ModelMap model, HttpServletResponse response) {
        response.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(true);

        int exito = 0;
        if (session.getAttribute("idUsuario") != null) {
            String usuario = request.getParameter("user");
            String contraseña = request.getParameter("password");
            int tipo = parseInt(request.getParameter("tipo"));

            String contraseñaEncriptado = BCrypt.hashpw(contraseña, BCrypt.gensalt(12));

            exito = usuarioDAO.agregarUsuario(usuario, contraseñaEncriptado, tipo);

        } else {
            exito = 2;
        }
        return exito;
    }

    @RequestMapping("/actualizarContraseña")
    @ResponseBody
    public int updatePassword(HttpServletRequest request, ModelMap model, HttpServletResponse response) {
        response.setCharacterEncoding("UTF-8");
        int exito = 0;
        HttpSession session = request.getSession(true);
        if (session.getAttribute("idUsuario") != null) {
            String contraseña = request.getParameter("password");
            String contraseñaEncriptado = BCrypt.hashpw(contraseña, BCrypt.gensalt(12));
            exito = usuarioDAO.actualizarContraseña((int) session.getAttribute("idUsuario"), contraseñaEncriptado);
        } else {
            exito = 2;
        }

        return exito;

    }

    @RequestMapping("/agregarCita")
    @ResponseBody
    public int addAppointment(HttpServletRequest request, ModelMap model, HttpServletResponse response) {
        response.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(true);
        int exito = 0;
        if (session.getAttribute("idUsuario") != null) {

            int idPaciente = parseInt(request.getParameter("idPaciente"));;
            int isNewPatient = parseInt(request.getParameter("isNewPatient"));
            int sesionNueva = 0;
            int idUsuario = (int) session.getAttribute("idUsuario");
            int idCita = 0;
            String paciente = request.getParameter("paciente");
            String fecha[] = request.getParameterValues("fecha[]");
            ArrayList<Object> fechasIndividuales = new ArrayList<Object>();
            String[] fechaIndividual;
            String dia = "";
            String mes = "";
            String año = "";
            String hora = request.getParameter("hora");
            String[] fechaInd;
            int flag = 0;
            int tipo = (int) session.getAttribute("tipo");
            int flag2 = 1;
            int cont = 0;

            //Agregar fecha
            for (int i = 0; i < fecha.length; i++) {
                fechaIndividual = fecha[i].split("/");
                fechasIndividuales.add(fechaIndividual);
            }

            for (int i = 0; i < fechasIndividuales.size(); i++) {
                fechaInd = (String[]) fechasIndividuales.get(i);
                dia = fechaInd[0];
                mes = fechaInd[1];
                año = "20" + fechaInd[2];
                if (tipo == 1) {
                    if (fechaDAO.contadorCitasPorFecha(dia, mes, año, hora, 1) == 3) {
                        flag = 1;
                    }
                }
                if (tipo == 2) {
                    if (fechaDAO.contadorCitasPorFecha(dia, mes, año, hora, 2) == 1) {
                        flag = 1;
                    }
                }
                if (flag == 0) {
                    if (flag2 == 1) {
                        //Agregar cita
                        if (isNewPatient == 1) { //Si es nuevo el paciente
                            idPaciente = pacienteDAO.agregarPaciente(idUsuario, paciente);

                        } else {// El paciente ya existe
                            sesionNueva = citaDAO.contadorCitasTotal(idPaciente,tipo);

                        }
                        flag = 0;
                    }
                    if (isNewPatient == 1) {
                        cont++;
                        idCita = citaDAO.agregarCita(idPaciente, cont,tipo);
                        tratamientoDAO.agregarTratamiento(idUsuario, idPaciente, idCita, "");
                    } else {
                        sesionNueva++;
                        idCita = citaDAO.agregarCita(idPaciente, sesionNueva, tipo);
                        tratamientoDAO.agregarTratamiento(idUsuario, idPaciente, idCita, "");

                    }
                    exito = fechaDAO.agregarFecha(hora, dia, mes, año, idCita);

                }
                if (flag == 1) {
                    exito = 2;
                }
            }
        } else {
            exito = 3;
        }

        return exito;

    }

    @RequestMapping("/citasPorFecha")
    @ResponseBody
    public Object appointmentByDates(HttpServletRequest request, ModelMap model, HttpServletResponse response) {
        response.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(true);
        Object citas = null;
        if (session.getAttribute("idUsuario") != null) {
            String dia = request.getParameter("dia");
            String mes = request.getParameter("mes");;
            String año = request.getParameter("año");

            citas = fechaDAO.listaCitasPorFecha(dia, mes, año);
        } else {
            citas = null;
        }

        return citas;

    }

    @RequestMapping("/asistencia_cita")
    @ResponseBody
    public int assistDate(HttpServletRequest request, ModelMap model, HttpServletResponse response) {
        response.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(true);
        int exito = 0;
        int contadorAsistidos = 0;
        if (session.getAttribute("idUsuario") != null) {
            int idPaciente = parseInt(request.getParameter("paciente"));
            int idCita = parseInt(request.getParameter("idCita"));
            int asistido = parseInt(request.getParameter("asistido"));
            if(asistido == 1){
                contadorAsistidos = citaDAO.contadorCitasAsistidos(idPaciente) + 1;
            }
            
            exito = citaDAO.asistirCita(idCita, contadorAsistidos, asistido);
        } else {
            exito = 2;
        }
        return exito;

    }

    @RequestMapping("/actualizarTratamiento")
    @ResponseBody
    public int addThreatment(HttpServletRequest request, ModelMap model, HttpServletResponse response) {
        response.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(true);
        int exito = 0;
        String tratamiento = request.getParameter("tratamiento");
        int idCita = parseInt(request.getParameter("idCita"));
        if (session.getAttribute("idUsuario") != null) {
            exito = tratamientoDAO.actualizarTratamiento(idCita, tratamiento);
        } else {
            exito = 2;
        }

        return exito;

    }


    @RequestMapping("/busquedaPacientes")
    @ResponseBody
    public List<TblPacientes> searchPatients(HttpServletRequest request, ModelMap model, HttpServletResponse response) {
        response.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(true);
        List<TblPacientes> pacientes = new ArrayList<TblPacientes>();
        if (session.getAttribute("idUsuario") != null) {
            String buscar = request.getParameter("buscar");
            pacientes = pacienteDAO.busquedaPacientes(buscar);
        } else {
            pacientes = null;
        }

        return pacientes;

    }

    @RequestMapping("/listaPacientes")
    @ResponseBody
    public List<TblPacientes> listPatients(HttpServletRequest request, ModelMap model, HttpServletResponse response) {
        response.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(true);
        List<TblPacientes> pacientes = new ArrayList<TblPacientes>();
        if (session.getAttribute("idUsuario") != null) {
            int idUsuario = parseInt(request.getParameter("idUsuario"));
            int actual = parseInt(request.getParameter("actual"));
            pacientes = pacienteDAO.listaPacientesId(idUsuario, actual);
        } else {
            pacientes = null;
        }

        return pacientes;

    }

    @RequestMapping("/existeUsuario")
    @ResponseBody
    public int texistsUser(HttpServletRequest request, ModelMap model, HttpServletResponse response) {
        response.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(true);
        int existe = 0;
        if (session.getAttribute("idUsuario") != null) {
            String usuario = request.getParameter("usuario");
            existe = usuarioDAO.existeUsuario(usuario);
        }

        return existe;

    }

    @RequestMapping("/logout")
    public String logout(HttpServletRequest request, ModelMap model, HttpServletResponse response) {
        HttpSession session = request.getSession(true);
        if (session.getAttribute("idUsuario") != null) {
            session.invalidate();
            return "login";
        } else {
            return "login";
        }

    }

}
