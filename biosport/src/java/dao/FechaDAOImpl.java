/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import java.util.ArrayList;
import java.util.List;
import model.TblCitas;
import model.TblFechas;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;

/**
 *
 * @author edgaralonsolopezorduno
 */
@Repository
public class FechaDAOImpl implements FechaDAO {

    private SessionFactory sessionFactory;

    public FechaDAOImpl() {
    }

    public FechaDAOImpl(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    @Override
    public int agregarFecha(String hora, String dia, String mes, String año, int idCita) {
        Session session = sessionFactory.openSession();

        int exito = 0;
        TblFechas fecha = new TblFechas();
        try {
            fecha.setHour(hora);
            fecha.setDay(dia);
            fecha.setMonth(mes);
            fecha.setYear(año);
            fecha.setDeleted(0);
            fecha.setIdCita(idCita);
            session.save(fecha);
            exito = 1;

        } catch (Exception ex) {
            exito = 0;
        }finally{
            session.close();
        }
        return exito;
    }

    @Override
    public List<Object> listaCitasPorFecha(String dia, String mes, String años) {
        Session session = sessionFactory.openSession();
        List<Object> citas = new ArrayList<Object>();

        String sql = "From TblFechas tf,TblCitas tc, TblPacientes tp, TblUsuarios tu"
                + " WHERE tf.day = ? AND tf.month = ? AND tf.year = ? AND tc.deleted = 0 "
                + "AND tf.deleted = 0 AND tc.id=tf.idCita AND tc.idPaciente=tp.id AND tu.id=tp.idUsuario";
        try {
            citas = session
                    .createQuery(sql)
                    .setParameter(0, dia)
                    .setParameter(1, mes)
                    .setParameter(2, años).list();

        } catch (Exception ex) {

        }finally{
            session.close();
        }

        return citas;
    }

    @Override
    public int contadorCitasPorFecha(String dia, String mes, String año, String hora, int tipo) {
        Session session = sessionFactory.openSession();

        List<Object> citas = new ArrayList<Object>();
        int contador = 0;
        String sql = "From TblFechas tf,TblCitas tc, TblPacientes tp, TblUsuarios tu"
                + " WHERE tf.day = ? AND tf.month = ? AND tf.year = ? AND tf.hour = ? AND tc.tipo = ? AND tc.deleted = 0 "
                + "AND tf.deleted = 0 AND tc.id=tf.idCita AND tc.idPaciente=tp.id AND tu.id=tp.idUsuario";
        try {
            citas = session
                    .createQuery(sql)
                    .setParameter(0, dia)
                    .setParameter(1, mes)
                    .setParameter(2, año)
                    .setParameter(3, hora)
                    .setParameter(4, tipo).list();
            
            
            contador = citas.size();
        } catch (Exception ex) {

        }finally{
            session.close();
        }

        return contador;
    }

}
