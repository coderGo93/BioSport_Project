/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import java.util.List;
import model.TblUsuarios;


/**
 *
 * @author edgaralonsolopezorduno
 */
public interface UsuarioDAO {
    
    public TblUsuarios iniciarSesion(String nombre, String contraseña);
    
    public int agregarUsuario(String nombre, String contraseña, int tipo);
    
    public int actualizarContraseña(int id, String contraseña);
    
    public String checarContraseñaEncriptada(String nombre, String contraseña);
    
    public int existeUsuario(String nombre);
    
    public List<TblUsuarios> listaUsuarios();
}
