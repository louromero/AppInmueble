/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import entities.VisitaInmueble;
import services.InmobiliariaService;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "VisitaServlet", urlPatterns = {"/ListarVisitas", "/RegistrarVisita", "/EditarVisita", "/EliminarVisita"})
public class VisitaServlet extends HttpServlet {

    @EJB
    private InmobiliariaService service;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();
        String method = request.getMethod();
        String url = "/WEB-INF/vista/error.jsp";

        try {
            switch (path) {
                case "/ListarVisitas":
                    request.setAttribute("visitas", service.listarVisitas());
                    url = "/WEB-INF/vista/ListarVisitas.jsp";
                    break;

                case "/RegistrarVisita":
                    if (method.equals("POST")) {
                        service.registrarVisita(
                                Integer.parseInt(request.getParameter("agenteId")),
                                Integer.parseInt(request.getParameter("clienteId")),
                                Integer.parseInt(request.getParameter("inmuebleId")),
                                request.getParameter("fecha"),
                                request.getParameter("hora"),
                                request.getParameter("estado")
                        );
                        response.sendRedirect("ListarVisitas");
                        return;
                    }
                    request.setAttribute("agentes", service.listarAgentes());
                    request.setAttribute("clientes", service.listarClientes());
                    request.setAttribute("inmuebles", service.listarInmuebles());
                    url = "/WEB-INF/vista/RegistrarVisita.jsp";
                    break;

                case "/EliminarVisita":
                    int idEliminar = Integer.parseInt(request.getParameter("idVisita"));
                    String fechaEliminar = request.getParameter("fecha");
                    service.eliminarVisita(idEliminar, fechaEliminar);
                    response.sendRedirect("ListarVisitas");
                    return;

                case "/EditarVisita":
                    if (method.equals("POST")) {
                        // Recibe los datos del formulario de EditarVisita.jsp
                        service.actualizarEstadoVisita(
                                Integer.parseInt(request.getParameter("idVisita")),
                                request.getParameter("fechaOriginal"),
                                request.getParameter("hora"),
                                request.getParameter("estado")
                        );
                        response.sendRedirect("ListarVisitas");
                        return;
                    } else {
                        // Carga los datos para el formulario (GET)
                        int idV = Integer.parseInt(request.getParameter("idVisita"));
                        String fechaV = request.getParameter("fecha");
                        VisitaInmueble v = service.buscarVisita(idV, fechaV);
                        request.setAttribute("visita", v);
                        url = "/WEB-INF/vista/EditarVisita.jsp";
                    }
                    break;
            }
            request.getRequestDispatcher(url).forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error en el sistema: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/vista/error.jsp").forward(request, response);
        }
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
