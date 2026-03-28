/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package session;

import entities.Inmueble;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;

@Stateless
public class InmuebleFacade extends AbstractFacade<Inmueble> {

    @PersistenceContext(unitName = "my_persistence_unit")
    private EntityManager em;

    @Override
    public EntityManager getEntityManager() {
        return em;
    }

    public InmuebleFacade() {
        super(Inmueble.class);
    }

    public Inmueble obtenerInmueblePorId(int id) {
        try {
            // El LEFT JOIN FETCH asegura que traiga la colección de imágenes aunque esté vacía
            TypedQuery<Inmueble> query = em.createQuery(
                    "SELECT i FROM Inmueble i LEFT JOIN FETCH i.imagenesInmuebleCollection WHERE i.idinmueble = :id",
                    Inmueble.class);
            query.setParameter("id", id);
            return query.getSingleResult();
        } catch (Exception e) {
            return null;
        }
    }
}
