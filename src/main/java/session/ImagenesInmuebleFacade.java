/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package session;

import entities.ImagenesInmueble;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;
import java.util.List;

/**
 *
 * @author lulur
 */
@Stateless
public class ImagenesInmuebleFacade extends AbstractFacade<ImagenesInmueble> {

    @PersistenceContext(unitName = "my_persistence_unit")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public ImagenesInmuebleFacade() {
        super(ImagenesInmueble.class);
    }

    public List<ImagenesInmueble> obtenerImagenesPorInmuebleId(int idInmueble) {
        TypedQuery<ImagenesInmueble> query = em.createQuery(
                "SELECT img FROM ImagenesInmueble img WHERE img.inmueble.id = :idInmueble", ImagenesInmueble.class);
        query.setParameter("idInmueble", idInmueble);
        return query.getResultList();
    }
}