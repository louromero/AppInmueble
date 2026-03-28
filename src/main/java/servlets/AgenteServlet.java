/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import entities.Agente;
import services.InmobiliariaService;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "AgenteServlet", urlPatterns = {
    "/IniciarSesion", "/RegistrarAgente", "/ListarAgentes", "/EliminarAgente", "/EditarAgente", "/CerrarSesion"
})
public class AgenteServlet extends HttpServlet {

    @EJB
    private InmobiliariaService service;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();
        String method = request.getMethod();
        HttpSession session = request.getSession();
        Agente agenteLogueado = (Agente) session.getAttribute("agente");
        boolean esAdmin = agenteLogueado != null && "admin@gmail.com".equals(agenteLogueado.getEmail());

        try {
            switch (path) {
                case "/IniciarSesion":
                    if (method.equals("POST")) {
                        Agente ag = service.autenticar(request.getParameter("correo"), request.getParameter("contrasena"));
                        if (ag != null) {
                            session.setAttribute("agente", ag);
                            response.sendRedirect("ListarInmuebles");
                            return;
                        }
                        request.setAttribute("error", "Correo o clave incorrectos");
                    }
                    request.getRequestDispatcher("/WEB-INF/vista/IniciarSesion.jsp").forward(request, response);
                    break;

                case "/ListarAgentes":
                    request.setAttribute("agentes", service.listarAgentes());
                    request.getRequestDispatcher("/WEB-INF/vista/ListarAgentes.jsp").forward(request, response);
                    break;

                case "/RegistrarAgente":
                    if (!esAdmin) { response.sendRedirect("ListarAgentes"); return; }
                    if (method.equals("POST")) {
                        service.registrarAgente(request.getParameter("nombre"), request.getParameter("email"),
                                request.getParameter("telefono"), request.getParameter("clave"));
                        response.sendRedirect("ListarAgentes");
                        return;
                    }
                    request.getRequestDispatcher("/WEB-INF/vista/RegistrarAgente.jsp").forward(request, response);
                    break;

                case "/EditarAgente":
                    if (!esAdmin) { response.sendRedirect("ListarAgentes"); return; }
                    if (method.equals("POST")) {
                        service.actualizarAgente(Integer.parseInt(request.getParameter("idAgente")),
                                request.getParameter("nombre"), request.getParameter("email"),
                                request.getParameter("telefono"), request.getParameter("clave"));
                        response.sendRedirect("ListarAgentes");
                        return;
                    } else {
                        int id = Integer.parseInt(request.getParameter("idAgente"));
                        request.setAttribute("agenteEditar", service.buscarAgente(id));
                        request.getRequestDispatcher("/WEB-INF/vista/EditarAgente.jsp").forward(request, response);
                    }
                    break;

                case "/EliminarAgente":
                    if (!esAdmin) { response.sendRedirect("ListarAgentes"); return; }
                    service.eliminarAgente(Integer.parseInt(request.getParameter("idAgente")));
                    response.sendRedirect("ListarAgentes");
                    break;

                case "/CerrarSesion":
                    session.invalidate();
                    response.sendRedirect("index.jsp");
                    break;
            }
        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/WEB-INF/vista/error.jsp").forward(request, response);
        }
    }

    @Override protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException { processRequest(req, resp); }
    @Override protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException { processRequest(req, resp); }
}