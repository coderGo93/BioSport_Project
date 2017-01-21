/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import java.util.List;
import model.TblPacientes;

/**
 *
 * @author edgaralonsolopezorduno
 */
public interface PacienteDAO {
    
    public int agregarPaciente(int idUsuario, String nombre);
    
    public List<TblPacientes> busquedaPacientes(String nombre);
    
    public List<TblPacientes> listaPacientesId(int idUsuario, int actual);
    
}
