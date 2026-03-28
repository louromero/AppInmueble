package entities;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import java.io.Serializable;

@Entity
@Table(name = "imagenes_inmueble")
public class ImagenesInmueble implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idimagenes_inmueble")
    private Integer idimagenesInmueble;

    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 255)
    @Column(name = "url_imagen")
    private String urlImagen;

    @Size(max = 255)
    @Column(name = "descripcion", nullable = true) // Ahora permite valores nulos
    private String descripcion;

    @JoinColumn(name = "inmueble_idinmueble", referencedColumnName = "idinmueble")
    @ManyToOne(optional = false)
    private Inmueble inmueble;

    public ImagenesInmueble() {}

    public Integer getIdimagenesInmueble() { 
        return idimagenesInmueble; 
    }
    public void setIdimagenesInmueble(Integer idimagenesInmueble) { 
        this.idimagenesInmueble = idimagenesInmueble; 
    }
    public String getUrlImagen() { 
        return urlImagen; 
    }
    public void setUrlImagen(String urlImagen) { 
        this.urlImagen = urlImagen; 
    }
    public String getDescripcion() { 
        return descripcion; 
    }
    public void setDescripcion(String descripcion) { 
        this.descripcion = descripcion; 
    }
    public Inmueble getInmueble() { 
        return inmueble; 
    }
    public void setInmueble(Inmueble inmueble) { 
        this.inmueble = inmueble; 
    }
}