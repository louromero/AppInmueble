/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entities;

import jakarta.persistence.Basic;
import jakarta.persistence.Column;
import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinColumns;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.NamedQueries;
import jakarta.persistence.NamedQuery;
import jakarta.persistence.Table;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import jakarta.persistence.UniqueConstraint;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import jakarta.xml.bind.annotation.XmlRootElement;
import java.io.Serializable;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.Date;

/**
 *
 * @author lulur
 */
@Entity
@Table(name = "visita_inmueble", catalog = "dbinmuebles", schema = "", uniqueConstraints = {
    @UniqueConstraint(columnNames = {"idvisita_inmueble"})})
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "VisitaInmueble.findAll", query = "SELECT v FROM VisitaInmueble v"),
    @NamedQuery(name = "VisitaInmueble.findByIdvisitaInmueble", query = "SELECT v FROM VisitaInmueble v WHERE v.visitaInmueblePK.idvisitaInmueble = :idvisitaInmueble"),
    @NamedQuery(name = "VisitaInmueble.findByFecha", query = "SELECT v FROM VisitaInmueble v WHERE v.visitaInmueblePK.fecha = :fecha"),
    @NamedQuery(name = "VisitaInmueble.findByHora", query = "SELECT v FROM VisitaInmueble v WHERE v.hora = :hora"),
    @NamedQuery(name = "VisitaInmueble.findByEstado", query = "SELECT v FROM VisitaInmueble v WHERE v.estado = :estado")})
public class VisitaInmueble implements Serializable {

    private static final long serialVersionUID = 1L;
    @EmbeddedId
    protected VisitaInmueblePK visitaInmueblePK;
    @Column(name = "hora")
    //@Temporal(TemporalType.TIME)
    private LocalTime hora;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 10)
    @Column(name = "estado", nullable = false, length = 10)
    private String estado;
    @JoinColumns({
        @JoinColumn(name = "agente_idagente", referencedColumnName = "idagente", nullable = false),
        @JoinColumn(name = "agente_idagente", referencedColumnName = "idagente", nullable = false)})
    @ManyToOne(optional = false)
    private Agente agente;
    @JoinColumns({
        @JoinColumn(name = "cliente_idcliente", referencedColumnName = "idcliente", nullable = false),
        @JoinColumn(name = "cliente_idcliente", referencedColumnName = "idcliente", nullable = false)})
    @ManyToOne(optional = false)
    private Cliente cliente;
    @JoinColumns({
        @JoinColumn(name = "inmueble_idinmueble", referencedColumnName = "idinmueble", nullable = false),
        @JoinColumn(name = "inmueble_idinmueble", referencedColumnName = "idinmueble", nullable = false)})
    @ManyToOne(optional = false)
    private Inmueble inmueble;

    public VisitaInmueble() {
    }

    public VisitaInmueble(VisitaInmueblePK visitaInmueblePK) {
        this.visitaInmueblePK = visitaInmueblePK;
    }

    public VisitaInmueble(VisitaInmueblePK visitaInmueblePK, String estado) {
        this.visitaInmueblePK = visitaInmueblePK;
        this.estado = estado;
    }

    public VisitaInmueble(int idvisitaInmueble, LocalDate fecha) {
        this.visitaInmueblePK = new VisitaInmueblePK(idvisitaInmueble, fecha);
    }

    public VisitaInmueblePK getVisitaInmueblePK() {
        return visitaInmueblePK;
    }

    public void setVisitaInmueblePK(VisitaInmueblePK visitaInmueblePK) {
        this.visitaInmueblePK = visitaInmueblePK;
    }

    public LocalTime getHora() {
        return hora;
    }

    public void setHora(LocalTime hora) {
        this.hora = hora;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public Agente getAgente() {
        return agente;
    }

    public void setAgente(Agente agente) {
        this.agente = agente;
    }

    public Cliente getCliente() {
        return cliente;
    }

    public void setCliente(Cliente cliente) {
        this.cliente = cliente;
    }

    public Inmueble getInmueble() {
        return inmueble;
    }

    public void setInmueble(Inmueble inmueble) {
        this.inmueble = inmueble;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (visitaInmueblePK != null ? visitaInmueblePK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof VisitaInmueble)) {
            return false;
        }
        VisitaInmueble other = (VisitaInmueble) object;
        if ((this.visitaInmueblePK == null && other.visitaInmueblePK != null) || (this.visitaInmueblePK != null && !this.visitaInmueblePK.equals(other.visitaInmueblePK))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entidad.VisitaInmueble[ visitaInmueblePK=" + visitaInmueblePK + " ]";
    }
    
}
