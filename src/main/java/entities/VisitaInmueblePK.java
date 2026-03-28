/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entities;

import jakarta.persistence.Basic;
import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import jakarta.validation.constraints.NotNull;
import java.io.Serializable;
import java.time.LocalDate;
import java.util.Date;

/**
 *
 * @author lulur
 */
@Embeddable
public class VisitaInmueblePK implements Serializable {

    @Basic(optional = false)
    @Column(name = "idvisita_inmueble", nullable = false)
    private int idvisitaInmueble;
    @Basic(optional = false)
    @Column(name = "fecha", nullable = false)
    private LocalDate fecha;

    public VisitaInmueblePK() {
    }

    public VisitaInmueblePK(int idvisitaInmueble, LocalDate fecha) {
        this.idvisitaInmueble = idvisitaInmueble;
        this.fecha = fecha;
    }

    public int getIdvisitaInmueble() {
        return idvisitaInmueble;
    }

    public void setIdvisitaInmueble(int idvisitaInmueble) {
        this.idvisitaInmueble = idvisitaInmueble;
    }



    public LocalDate getFecha() {
        return fecha;
    }

    public void setFecha(LocalDate fecha) {
        this.fecha = fecha;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (int) idvisitaInmueble;
        hash += (fecha != null ? fecha.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof VisitaInmueblePK)) {
            return false;
        }
        VisitaInmueblePK other = (VisitaInmueblePK) object;
        if (this.idvisitaInmueble != other.idvisitaInmueble) {
            return false;
        }
        if ((this.fecha == null && other.fecha != null) || (this.fecha != null && !this.fecha.equals(other.fecha))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entidad.VisitaInmueblePK[ idvisitaInmueble=" + idvisitaInmueble + ", fecha=" + fecha + " ]";
    }

}
