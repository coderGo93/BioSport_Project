/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import java.util.ArrayList;
import java.util.List;
import model.TblTratamientos;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;

/**
 *
 * @author edgaralonsolopezorduno
 */
@Repository
public class TratamientoDAOImpl implements TratamientoDAO {

    private SessionFactory sessionFactory;

    public TratamientoDAOImpl() {
    }

    public TratamientoDAOImpl(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    @Override
    public int agregarTratamiento(int idUsuario, int idPaciente, int idCita, String tratamiento) {
        Session session = sessionFactory.openSession();
        int exito = 0;
        TblTratamientos tratamiento2 = new TblTratamientos();
        try {
            tratamiento2.setIdUsuario(idUsuario);
            tratamiento2.setIdPaciente(idPaciente);
            tratamiento2.setIdCita(idCita);
            tratamiento2.setTratamiento(tratamiento);
            tratamiento2.setDeleted(0);
            session.save(tratamiento2);
            exito = 1;

        } catch (Exception ex) {
            exito = 0;
        }finally{
            session.close();
        }
        return exito;
    }

    @Override
    public List<TblTratamientos> listaTratamientos(int idPaciente) {
        Session session = sessionFactory.openSession();

        List<TblTratamientos> tratamientos = new ArrayList<TblTratamientos>();

        String sql = "From TblTratamientos WHERE idPaciente = ?";
        try {
            tratamientos = session
                    .createQuery(sql)
                    .setParameter(0, idPaciente).list();
        } catch (Exception ex) {

        }finally{
            session.close();
        }

        return tratamientos;
    }

    @Override
    public int actualizarTratamiento(int idCita, String tratamiento) {
        Session session = sessionFactory.openSession();

        int exito = 0;
        try {
            String sql = "UPDATE TblTratamientos SET tratamiento = ? WHERE idCita = ?";
            Query query = session
                    .createQuery(sql)
                    .setParameter(0, tratamiento)
                    .setParameter(1, idCita);
            query.executeUpdate();

            exito = 1;

        } catch (Exception ex) {
            exito = 0;
        }finally{
            session.close();
        }
        return exito;
    }

}
