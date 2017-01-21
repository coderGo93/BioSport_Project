/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import java.util.List;
import model.TblCitas;

/**
 *
 * @author edgaralonsolopezorduno
 */
public interface CitaDAO {
    
    public int agregarCita(int idPaciente, int sesion, int tipo);
    
    public List<TblCitas> listaCitasGeneral();
    
    public List<Object> listaCitasIdPacienteTipo(int idPaciente, int tipo);
    
    public TblCitas citasPorSesion(int idSesion);
    
    public int asistirCita(int idCita,int sesion, int asistido);
    
    public int actualizarSesion(int idPaciente,int sesion, int sesionActualizada);
    
    public int contadorCitasAsistidos(int idPaciente);
    
    public int contadorCitasTotal(int idPaciente, int tipo);
    
    public Object informacionCitaPaciente(int idCita);
    
}
