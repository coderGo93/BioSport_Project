/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import java.util.ArrayList;
import java.util.List;
import model.TblCitas;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;

/**
 *
 * @author edgaralonsolopezorduno
 */
@Repository
public class CitaDAOImpl implements CitaDAO {

    private SessionFactory sessionFactory;

    public CitaDAOImpl() {
    }

    public CitaDAOImpl(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    @Override
    public int agregarCita(int idPaciente, int sesion, int tipo) {
        Session session = sessionFactory.openSession();

        int idCita = 0;
        TblCitas cita = new TblCitas();
        try {
            cita.setIdPaciente(idPaciente);
            cita.setDeleted(0);
            cita.setIdSesion(sesion);
            cita.setAssisted(0);
            cita.setTipo(tipo);
            session.save(cita);
            idCita = cita.getId();

        } catch (Exception ex) {
            idCita = 0;
        }finally{
            session.close();
        }
        return idCita;
    }

    @Override
    public List<TblCitas> listaCitasGeneral() {
        Session session = sessionFactory.openSession();
        List<TblCitas> citas = new ArrayList<TblCitas>();

        String sql = "From TblCitas";
        try {
            citas = session
                    .createQuery(sql).list();

        } catch (Exception ex) {

        }finally{
            session.close();
        }

        return citas;
    }

    @Override
    public List<Object> listaCitasIdPacienteTipo(int idPaciente,int tipo) {
        Session session = sessionFactory.openSession();

        List<Object> citas = new ArrayList<Object>();
        String sql = "From TblCitas tc, TblFechas tf, TblTratamientos tt, TblPacientes tp WHERE tc.idPaciente=tp.id AND tc.id=tf.idCita AND tc.id=tt.idCita AND tc.assisted = 1 AND tc.idPaciente = ? AND tc.tipo = ?";
        try {
            citas = session
                    .createQuery(sql)
                    .setParameter(0, idPaciente)
                    .setParameter(1, tipo).list();
        } catch (Exception ex) {

        }finally{
            session.close();
        }

        return citas;
    }

    @Override
    public TblCitas citasPorSesion(int idSesion) {
        Session session = sessionFactory.openSession();
        TblCitas cita = new TblCitas();
        List<TblCitas> citas = new ArrayList<TblCitas>();

        String sql = "From TblCitas WHERE idSesion = ? AND deleted = 0";
        try {
            citas = session
                    .createQuery(sql)
                    .setParameter(0, idSesion).list();
        } catch (Exception ex) {

        }finally{
            session.close();
        }

        cita = citas.get(0);

        return cita;
        //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public int asistirCita(int idCita, int sesion, int asistido) {
        Session session = sessionFactory.openSession();
        int exito = 0;
        try {
            String sql = "UPDATE TblCitas SET assisted = ?, idSesion = ? WHERE id = ?";
            Query query = session
                    .createQuery(sql)
                    .setParameter(0, asistido)
                    .setParameter(1, sesion)
                    .setParameter(2, idCita);
            query.executeUpdate();

            exito = 1;

        } catch (Exception ex) {
            exito = 0;
        }finally{
            session.close();
        }
        return exito;
    }

    @Override
    public Object informacionCitaPaciente(int idCita) {
        Session session = sessionFactory.openSession();
        Object cita = new Object();
        List<TblCitas> citas = new ArrayList<TblCitas>();

        String sql = "FROM TblUsuarios tu, TblPacientes tp, TblCitas tc, TblFechas tf, TblTratamientos tt\n"
                + "WHERE tc.idPaciente = tp.id AND tf.idCita=tc.id AND  tc.id=tt.idCita AND tc.id=? AND tu.id=tp.idUsuario";
        try {
            citas = session
                    .createQuery(sql)
                    .setParameter(0, idCita).list();

            cita = citas.get(0);
        } catch (Exception ex) {

        }finally{
            session.close();
        }

        return cita;
        //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public int contadorCitasAsistidos(int idPaciente) {
        Session session = sessionFactory.openSession();
        List<TblCitas> citas = new ArrayList<TblCitas>();
        int contador = 0;

        String sql = "From TblCitas WHERE idPaciente = ? AND assisted = 1";

        try {
            citas = session
                    .createQuery(sql)
                    .setParameter(0, idPaciente).list();

            contador = citas.size();
        } catch (Exception ex) {
        }finally{
            session.close();
        }

        return contador;
    }

    @Override
    public int actualizarSesion(int idPaciente, int sesion, int sesionActualizada) {
        Session session = sessionFactory.openSession();

        int exito = 0;
        try {
            String sql = "UPDATE TblCitas SET idSesion = ? WHERE idPaciente = ? AND idSesion = ?";
            Query query = session
                    .createQuery(sql)
                    .setParameter(0, sesionActualizada)
                    .setParameter(1, idPaciente)
                    .setParameter(2, sesion);
            query.executeUpdate();

            exito = 1;

        } catch (Exception ex) {
            exito = 0;
        }finally{
            session.close();
        }
        return exito;

    }

    @Override
    public int contadorCitasTotal(int idPaciente, int tipo) {
        Session session = sessionFactory.openSession();
        List<TblCitas> citas = new ArrayList<TblCitas>();
        int contador = 0;

        String sql = "From TblCitas WHERE idPaciente = ? AND tipo = ?";
        try {
            citas = session
                    .createQuery(sql)
                    .setParameter(0, idPaciente)
                    .setParameter(1, tipo).list();

            contador = citas.size();
        } catch (Exception ex) {

        }finally{
            session.close();
        }

        return contador;
    }

}
