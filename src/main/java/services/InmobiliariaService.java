/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package services;

/**
 *
 * @author lulur
 */
import entities.VisitaInmueblePK;
import entities.Cliente;
import entities.Agente;
import entities.Inmueble;
import entities.VisitaInmueble;
import entities.ImagenesInmueble;
import jakarta.ejb.EJB;
import jakarta.ejb.Stateless;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import session.*;

@Stateless
public class InmobiliariaService {

    @EJB
    private AgenteFacade agenteF;
    @EJB
    private ClienteFacade clienteF;
    @EJB
    private InmuebleFacade inmuebleF;
    @EJB
    private VisitaInmuebleFacade visitaF;
    @EJB
    private ImagenesInmuebleFacade imagenesF;

    // --- LÓGICA DE AGENTES ---
    public Agente autenticar(String email, String clave) {
        return agenteF.iniciarSesion(email, clave);
    }

    public void registrarAgente(String nombre, String email, String telefono, String clave) throws Exception {
        if (agenteF.findByEmail(email) != null) {
            throw new Exception("El correo ya está registrado.");
        }
        Agente nuevo = new Agente(null, nombre, telefono, email, clave);
        agenteF.create(nuevo);
    }

    public List<Agente> listarAgentes() {
        return agenteF.findAll();
    }

    public void eliminarAgente(int id) {
        Agente a = agenteF.find(id);
        if (a != null) {
            agenteF.remove(a);
        }
    }

    public Agente buscarAgente(int id) {
        return agenteF.find(id);
    }

    public void actualizarAgente(int id, String nombre, String email, String telefono, String clave) {
        Agente a = agenteF.find(id);
        if (a != null) {
            a.setNombre(nombre);
            a.setEmail(email);
            a.setTelefono(telefono);
            a.setClave(clave);
            agenteF.edit(a);
        }
    }

    // --- LÓGICA DE CLIENTES ---
    public void registrarCliente(String nombre, String email, String telefono) {
        Cliente c = new Cliente(null, nombre, telefono, email);
        clienteF.create(c);
    }

    public List<Cliente> listarClientes() {
        return clienteF.findAll();
    }

    public void eliminarCliente(int id) {
        Cliente c = clienteF.find(id);
        if (c != null) {
            // Al estar en una transacción EJB, el remove debería 
            // disparar el borrado de las visitas por el CascadeType.ALL definido en la entidad.
            clienteF.remove(c);
        }
    }

    // --- LÓGICA DE INMUEBLES ---
    public void registrarInmueble(String titulo, String desc, String ubicacion, String estado, String tipo, String precio) {
        Inmueble i = new Inmueble(null, titulo, desc, ubicacion, estado, tipo, new BigDecimal(precio));
        inmuebleF.create(i);
    }

    public List<Inmueble> listarInmuebles() {
        return inmuebleF.findAll();
    }

    public Inmueble obtenerDetalleInmueble(int id) {
        return inmuebleF.obtenerInmueblePorId(id);
    }

    public void eliminarInmueble(int id) {
        Inmueble i = inmuebleF.find(id);
        if (i != null) {
            inmuebleF.remove(i);
        }
    }

    public void agregarImagenAInmueble(int idInmueble, String url, String descripcion) {
        Inmueble i = inmuebleF.find(idInmueble);
        if (i != null) {
            ImagenesInmueble img = new ImagenesInmueble();
            img.setInmueble(i);
            img.setUrlImagen(url);
            img.setDescripcion(descripcion);

            // Persistir la imagen
            imagenesF.create(img);

            // Refrescar el objeto inmueble para que la colección incluya la nueva foto
            inmuebleF.getEntityManager().refresh(i);
        }
    }

    // --- LÓGICA DE VISITAS ---
    public void registrarVisita(int idAgente, int idCliente, int idInmueble, String fecha, String hora, String estado) {
        Agente a = agenteF.find(idAgente);
        Cliente c = clienteF.find(idCliente);
        Inmueble i = inmuebleF.find(idInmueble);

        // LÓGICA PARA GENERAR ID AUTOMÁTICO MANUALMENTE (Evita Duplicate Entry '0')
        int nuevoId = 1;
        List<VisitaInmueble> todas = visitaF.findAll();
        for (VisitaInmueble vis : todas) {
            if (vis.getVisitaInmueblePK().getIdvisitaInmueble() >= nuevoId) {
                nuevoId = vis.getVisitaInmueblePK().getIdvisitaInmueble() + 1;
            }
        }

        VisitaInmueblePK pk = new VisitaInmueblePK(nuevoId, LocalDate.parse(fecha));
        VisitaInmueble v = new VisitaInmueble(pk, estado);
        v.setHora(LocalTime.parse(hora));
        v.setAgente(a);
        v.setCliente(c);
        v.setInmueble(i);

        visitaF.create(v);
    }

    public List<VisitaInmueble> listarVisitas() {
        return visitaF.findAll();
    }

    public VisitaInmueble buscarVisita(int idVisita, String fecha) {
        // Creamos la PK para buscar la entidad exacta
        VisitaInmueblePK pk = new VisitaInmueblePK(idVisita, LocalDate.parse(fecha));
        return visitaF.find(pk);
    }

    public void actualizarEstadoVisita(int idVisita, String fecha, String hora, String estado) {
        VisitaInmueblePK pk = new VisitaInmueblePK(idVisita, LocalDate.parse(fecha));
        VisitaInmueble v = visitaF.find(pk);
        if (v != null) {
            v.setHora(LocalTime.parse(hora));
            v.setEstado(estado);
            visitaF.edit(v); // Guarda los cambios en la base de datos
        }
    }

    public void eliminarVisita(int idVisita, String fecha) {
        VisitaInmueblePK pk = new VisitaInmueblePK(idVisita, LocalDate.parse(fecha));
        VisitaInmueble v = visitaF.find(pk);
        if (v != null) {
            visitaF.remove(v);
        }
    }

    // --- LÓGICA PARA REPORTES ---
    public java.util.Map<String, Long> obtenerVisitasPorAgente() {
        return listarVisitas().stream()
                .collect(java.util.stream.Collectors.groupingBy(v -> v.getAgente().getNombre(), java.util.stream.Collectors.counting()));
    }

    public java.util.Map<String, Long> obtenerEstadoVisitas() {
        return listarVisitas().stream()
                .collect(java.util.stream.Collectors.groupingBy(entities.VisitaInmueble::getEstado, java.util.stream.Collectors.counting()));
    }

    public java.util.Map<String, Long> obtenerTiposInmuebles() {
        return listarInmuebles().stream()
                .collect(java.util.stream.Collectors.groupingBy(entities.Inmueble::getTipo, java.util.stream.Collectors.counting()));
    }
}
