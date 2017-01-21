/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import java.util.List;
import model.TblTratamientos;

/**
 *
 * @author edgaralonsolopezorduno
 */
public interface TratamientoDAO {
    
    public int agregarTratamiento(int idUsuario, int idPaciente, int idCita, String tratamiento);
    
    public List<TblTratamientos> listaTratamientos(int idPaciente);
    
    public int actualizarTratamiento(int idCita, String tratamiento);
}
