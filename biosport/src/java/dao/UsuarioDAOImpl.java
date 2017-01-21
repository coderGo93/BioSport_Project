/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import java.util.ArrayList;
import java.util.List;
import model.HibernateUtil;
import model.TblUsuarios;
import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

/**
 *
 * @author edgaralonsolopezorduno
 */
@Repository
public class UsuarioDAOImpl implements UsuarioDAO {

    private SessionFactory sessionFactory;

    public UsuarioDAOImpl() {
    }

    public UsuarioDAOImpl(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    @Override
    public TblUsuarios iniciarSesion(String nombre, String contraseña) {
        Session session = sessionFactory.openSession();
        
        TblUsuarios user = null;
        List<TblUsuarios> users = new ArrayList<TblUsuarios>();
        try {
            
            String sql = "FROM TblUsuarios WHERE name = ? AND password = ? AND deleted = 0";
            users = session.createQuery(sql)
                    .setParameter(0, nombre)
                    .setParameter(1, contraseña).list();
            user = users.get(0);
        } catch (Exception ex) {

        }finally{
            session.close();
        }
        return user;
    }

    @Override
    public int agregarUsuario(String nombre, String contraseña, int tipo) {
        Session session = sessionFactory.openSession();
        int exito = 0;
        TblUsuarios user = new TblUsuarios();
        try {
            user.setName(nombre);
            user.setPassword(contraseña);
            user.setTipo(tipo);
            user.setDeleted(0);
            session.save(user);
            exito = 1;

        } catch (Exception ex) {
            exito = 0;
        }finally{
            session.close();
        }
        return exito;
    }

    @Override
    public int actualizarContraseña(int id, String contraseña) {
        Session session = sessionFactory.openSession();
        int exito = 0;
        try {
            String sql = "UPDATE TblUsuarios SET password = ? WHERE id = ?";
            Query query = session
                    .createQuery(sql)
                    .setParameter(0, contraseña)
                    .setParameter(1, id);
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
    public List<TblUsuarios> listaUsuarios() {
        Session session = sessionFactory.openSession();
        List<TblUsuarios> users = new ArrayList<TblUsuarios>();

        String sql = "From TblUsuarios WHERE deleted = 0";
        try {
            users = session.createQuery(sql).list();
        } catch (Exception ex) {
        }finally{
            session.close();
        }

        return users;
    }

    @Override
    public String checarContraseñaEncriptada(String nombre, String contraseña) {
        Session session = sessionFactory.openSession();
        TblUsuarios user = null;
        List<TblUsuarios> users = new ArrayList<TblUsuarios>();
        String correcto = "";
        try {
            String sql = "FROM TblUsuarios WHERE name = ?";
            users = session
                    .createQuery(sql)
                    .setParameter(0, nombre).list();
            user = users.get(0);

            if (BCrypt.checkpw(contraseña, user.getPassword())) {
                correcto = user.getPassword();
            } else {
                correcto = null;
            }

        } catch (Exception ex) {

        }finally{
            session.close();
        }
        return correcto;
    }

    @Override
    public int existeUsuario(String nombre) {
        Session session = sessionFactory.openSession();
        List<TblUsuarios> users = new ArrayList<TblUsuarios>();
        int existe = 0;

        try {
            String sql = "FROM TblUsuarios WHERE name = ? AND deleted = 0";
            users = session
                    .createQuery(sql)
                    .setParameter(0, nombre).list();
            if(users.size() > 0){
                existe = 1;
            }
        } catch (Exception ex) {
            existe = 0;
        }finally{
            session.close();
        }
        return existe;
    }
}
