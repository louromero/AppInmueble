/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package session;

import entities.Agente;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;

@Stateless
public class AgenteFacade extends AbstractFacade<Agente> {

    @PersistenceContext(unitName = "my_persistence_unit")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public AgenteFacade() {
        super(Agente.class);
    }

    public Agente iniciarSesion(String email, String clave) {
        try {
            TypedQuery<Agente> query = em.createQuery("SELECT a FROM Agente a WHERE a.email = :email AND a.clave = :clave", Agente.class);
            query.setParameter("email", email);
            query.setParameter("clave", clave);
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }

    public Agente findByEmail(String email) {
        try {
            return em.createQuery("SELECT a FROM Agente a WHERE a.email = :email", Agente.class)
                    .setParameter("email", email)
                    .getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }
}