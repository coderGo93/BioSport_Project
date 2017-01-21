/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import java.util.ArrayList;
import java.util.List;
import model.TblFechas;
import model.TblPacientes;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;

/**
 *
 * @author edgaralonsolopezorduno
 */
@Repository
public class PacienteDAOImpl implements PacienteDAO {

    private SessionFactory sessionFactory;

    public PacienteDAOImpl() {
    }

    public PacienteDAOImpl(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    @Override
    public int agregarPaciente(int idUsuario, String nombre) {
        Session session = sessionFactory.openSession();
        int id = 0;
        TblPacientes paciente = new TblPacientes();
        try {
            paciente.setIdUsuario(idUsuario);
            paciente.setNombre(nombre);
            session.save(paciente);
            id = paciente.getId();

        } catch (Exception ex) {
            id = 0;
        }finally{
            session.close();
        }
        return id;
    }

    @Override
    public List<TblPacientes> busquedaPacientes(String nombre) {
        Session session = sessionFactory.openSession();

        List<TblPacientes> pacientes = new ArrayList<TblPacientes>();

        String sql = "From  TblPacientes WHERE nombre LIKE ?";
        try {
            pacientes = session
                    .createQuery(sql)
                    .setParameter(0, nombre + "%").list();

        } catch (Exception ex) {

        }finally{
            session.close();
        }

        return pacientes;
    }

    @Override
    public List<TblPacientes> listaPacientesId(int idUsuario, int actual) {
        Session session = sessionFactory.openSession();

        List<TblPacientes> pacientes = new ArrayList<TblPacientes>();

        String sql = "From  TblPacientes tp WHERE tp.idUsuario = ?";
        try {
            pacientes = session
                    .createQuery(sql)
                    .setParameter(0, idUsuario)
                    .setFirstResult(actual)
                    .setMaxResults(10).list();
            

        } catch (Exception ex) {

        }finally{
            session.close();
        }

        return pacientes;
    }

}
