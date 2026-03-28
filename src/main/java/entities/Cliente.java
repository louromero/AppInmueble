package entities;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import java.io.Serializable;
import java.util.Collection;

@Entity
@Table(name = "cliente", catalog = "dbinmuebles", schema = "")
public class Cliente implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "idcliente", nullable = false)
    private Integer idcliente;

    @NotNull
    @Basic(optional = false)
    @Size(min = 1, max = 45)
    @Column(name = "nombre", nullable = false, length = 45)
    private String nombre;

    @NotNull
    @Basic(optional = false)
    @Size(min = 1, max = 45)
    @Column(name = "telefono", nullable = false, length = 45)
    private String telefono;

    @NotNull
    @Basic(optional = false)
    @Size(min = 1, max = 45)
    @Column(name = "email", nullable = false, length = 45)
    private String email;

    // RELACIÓN AÑADIDA: Para permitir la eliminación en cascada de visitas
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "cliente", orphanRemoval = true)
    private Collection<VisitaInmueble> visitaInmuebleCollection;

    public Cliente() {
    }

    public Cliente(Integer idcliente, String nombre, String telefono, String email) {
        this.idcliente = idcliente;
        this.nombre = nombre;
        this.telefono = telefono;
        this.email = email;
    }

    // Getters and Setters
    public Integer getIdcliente() {
        return idcliente;
    }

    public void setIdcliente(Integer idcliente) {
        this.idcliente = idcliente;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Collection<VisitaInmueble> getVisitaInmuebleCollection() {
        return visitaInmuebleCollection;
    }

    public void setVisitaInmuebleCollection(Collection<VisitaInmueble> visitaInmuebleCollection) {
        this.visitaInmuebleCollection = visitaInmuebleCollection;
    }
}