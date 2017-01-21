/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import java.util.List;
import model.TblFechas;

/**
 *
 * @author edgaralonsolopezorduno
 */
public interface FechaDAO {
    
    public int agregarFecha(String hora, String dia, String mes, String año, int idCita);
    
    public List<Object> listaCitasPorFecha(String dia, String mes, String años);
    
    public int contadorCitasPorFecha(String dia, String mes, String año, String hora, int tipo);
    
    
    
}
