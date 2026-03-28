package entities;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import jakarta.xml.bind.annotation.XmlRootElement;
import jakarta.xml.bind.annotation.XmlTransient;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Collection;

@Entity
@Table(name = "inmueble", catalog = "dbinmuebles", schema = "")
@XmlRootElement
public class Inmueble implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "idinmueble", nullable = false)
    private Integer idinmueble;

    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 45)
    @Column(name = "titulo", nullable = false, length = 45)
    private String titulo;

    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 800)
    @Column(name = "descripcion", nullable = false, length = 800)
    private String descripcion;

    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 80)
    @Column(name = "ubicacion", nullable = false, length = 80)
    private String ubicacion;

    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 8)
    @Column(name = "estado", nullable = false, length = 8)
    private String estado;

    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 12)
    @Column(name = "tipo", nullable = false, length = 12)
    private String tipo;

    @Basic(optional = false)
    @NotNull
    @Column(name = "precio", nullable = false, precision = 10, scale = 2)
    private BigDecimal precio;

    // Relación corregida para el carrusel
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "inmueble", fetch = FetchType.EAGER)
    private Collection<ImagenesInmueble> imagenesInmuebleCollection;

    public Inmueble() {}

    public Inmueble(Integer idinmueble, String titulo, String descripcion, String ubicacion, String estado, String tipo, BigDecimal precio) {
        this.idinmueble = idinmueble;
        this.titulo = titulo;
        this.descripcion = descripcion;
        this.ubicacion = ubicacion;
        this.estado = estado;
        this.tipo = tipo;
        this.precio = precio;
    }

    // Getters y Setters
    public Integer getIdinmueble() { return idinmueble; }
    public void setIdinmueble(Integer idinmueble) { this.idinmueble = idinmueble; }
    public String getTitulo() { return titulo; }
    public void setTitulo(String titulo) { this.titulo = titulo; }
    public String getDescripcion() { return descripcion; }
    public void setDescripcion(String descripcion) { this.descripcion = descripcion; }
    public String getUbicacion() { return ubicacion; }
    public void setUbicacion(String ubicacion) { this.ubicacion = ubicacion; }
    public String getEstado() { return estado; }
    public void setEstado(String estado) { this.estado = estado; }
    public String getTipo() { return tipo; }
    public void setTipo(String tipo) { this.tipo = tipo; }
    public BigDecimal getPrecio() { return precio; }
    public void setPrecio(BigDecimal precio) { this.precio = precio; }

    @XmlTransient
    public Collection<ImagenesInmueble> getImagenesInmuebleCollection() {
        return imagenesInmuebleCollection;
    }

    public void setImagenesInmuebleCollection(Collection<ImagenesInmueble> imagenesInmuebleCollection) {
        this.imagenesInmuebleCollection = imagenesInmuebleCollection;
    }
}