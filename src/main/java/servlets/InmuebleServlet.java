package servlets;

import services.InmobiliariaService;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.util.UUID;

@WebServlet(name = "InmuebleServlet", urlPatterns = {
    "/ListarInmuebles", 
    "/RegistrarInmueble", 
    "/DetalleInmueble", 
    "/EliminarInmueble", 
    "/CargarImagen"
})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 50   // 50MB
)
public class InmuebleServlet extends HttpServlet {

    @EJB
    private InmobiliariaService service;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String path = request.getServletPath();
        String method = request.getMethod();

        try {
            switch (path) {
                case "/ListarInmuebles":
                    request.setAttribute("inmuebles", service.listarInmuebles());
                    request.getRequestDispatcher("/WEB-INF/vista/ListarInmuebles.jsp").forward(request, response);
                    break;

                case "/RegistrarInmueble":
                    if ("POST".equalsIgnoreCase(method)) {
                        service.registrarInmueble(
                            request.getParameter("titulo"), request.getParameter("descripcion"),
                            request.getParameter("ubicacion"), request.getParameter("estado"),
                            request.getParameter("tipo"), request.getParameter("precio")
                        );
                        response.sendRedirect(request.getContextPath() + "/ListarInmuebles");
                    } else {
                        request.getRequestDispatcher("/WEB-INF/vista/RegistrarInmueble.jsp").forward(request, response);
                    }
                    break;

                case "/DetalleInmueble":
                    int idDetalle = Integer.parseInt(request.getParameter("id"));
                    request.setAttribute("inmueble", service.obtenerDetalleInmueble(idDetalle));
                    request.getRequestDispatcher("/WEB-INF/vista/DetalleInmueble.jsp").forward(request, response);
                    break;

                case "/CargarImagen":
                    if ("POST".equalsIgnoreCase(method)) {
                        int idInm = Integer.parseInt(request.getParameter("idInmueble"));
                        String desc = request.getParameter("descripcionImagen");
                        String urlExterna = request.getParameter("urlExterna");
                        
                        if (desc == null || desc.trim().isEmpty()) desc = "Sin descripción";

                        // PRIORIDAD 1: Si hay URL de internet
                        if (urlExterna != null && !urlExterna.trim().isEmpty()) {
                            service.agregarImagenAInmueble(idInm, urlExterna.trim(), desc);
                        } 
                        // PRIORIDAD 2: Si hay archivo local
                        else {
                            Part filePart = request.getPart("archivoImagen"); 
                            if (filePart != null && filePart.getSize() > 0) {
                                String fileName = UUID.randomUUID().toString() + "_" + getFileName(filePart);
                                String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
                                File uploadDir = new File(uploadPath);
                                if (!uploadDir.exists()) uploadDir.mkdirs();

                                filePart.write(uploadPath + File.separator + fileName);
                                service.agregarImagenAInmueble(idInm, "uploads/" + fileName, desc);
                            }
                        }
                        response.sendRedirect(request.getContextPath() + "/DetalleInmueble?id=" + idInm);
                    }
                    break;

                case "/EliminarInmueble":
                    service.eliminarInmueble(Integer.parseInt(request.getParameter("id")));
                    response.sendRedirect(request.getContextPath() + "/ListarInmuebles");
                    break;
                    
                default:
                    response.sendRedirect(request.getContextPath() + "/ListarInmuebles");
                    break;
            }
        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/WEB-INF/vista/error.jsp").forward(request, response);
        }
    }

    private String getFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        for (String token : contentDisp.split(";")) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf("=") + 2, token.length() - 1);
            }
        }
        return "imagen.jpg";
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        processRequest(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        processRequest(req, resp);
    }
}