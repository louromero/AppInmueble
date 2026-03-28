package entities;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import jakarta.validation.constraints.Email;
import java.io.Serializable;

@Entity
@Table(name = "agente", catalog = "dbinmuebles", schema = "")
public class Agente implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "idagente", nullable = false)
    private Integer idagente;

    @NotNull(message = "El nombre no puede ser nulo")
    @Size(min = 1, max = 45, message = "El nombre debe tener entre 1 y 45 caracteres")
    @Column(name = "nombre", nullable = false, length = 45)
    private String nombre;

    @NotNull(message = "El teléfono no puede ser nulo")
    @Size(min = 1, max = 45, message = "El teléfono debe tener entre 1 y 45 caracteres")
    @Column(name = "telefono", nullable = false, length = 45)
    private String telefono;

    @Email(message = "Debe proporcionar un correo válido")
    @NotNull(message = "El email no puede ser nulo")
    @Size(min = 1, max = 50, message = "El email debe tener entre 1 y 50 caracteres")
    @Column(name = "email", nullable = false, length = 50)
    private String email;

    @NotNull(message = "La clave no puede ser nula")
    @Size(min = 1, max = 45, message = "La clave debe tener entre 1 y 45 caracteres")
    @Column(name = "clave", nullable = false, length = 45)
    private String clave;

    public Agente() {
    }

    public Agente(Integer idagente) {
        this.idagente = idagente;
    }

    public Agente(Integer idagente, String nombre, String telefono, String email, String clave) {
        this.idagente = idagente;
        this.nombre = nombre;
        this.telefono = telefono;
        this.email = email;
        this.clave = clave;
    }

    // Getters y Setters actualizados
    public Integer getIdagente() { return idagente; }
    public void setIdagente(Integer idagente) { this.idagente = idagente; }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public String getTelefono() { return telefono; }
    public void setTelefono(String telefono) { this.telefono = telefono; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getClave() { return clave; }
    public void setClave(String clave) { this.clave = clave; }

    @Override
    public String toString() {
        return "Agente{" + "idagente=" + idagente + ", nombre=" + nombre + ", email=" + email + '}';
    }
}