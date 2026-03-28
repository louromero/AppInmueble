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

@WebServlet(name = "ReporteServlet", urlPatterns = {"/Reporte"})
public class ReporteServlet extends HttpServlet {

    @EJB
    private InmobiliariaService service;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // --- BLOQUE DE SEGURIDAD ---
        HttpSession session = request.getSession();
        Agente usuario = (Agente) session.getAttribute("agente");

        if (usuario == null || !"admin@gmail.com".equals(usuario.getEmail())) {
            // Si no es el admin, lo mandamos a la lista de inmuebles o error
            response.sendRedirect("ListarInmuebles");
            return;
        }
        // ---------------------------

        request.setAttribute("datosAgentes", service.obtenerVisitasPorAgente());
        request.setAttribute("datosEstados", service.obtenerEstadoVisitas());
        request.setAttribute("datosInmuebles", service.obtenerTiposInmuebles());
        
        request.getRequestDispatcher("/WEB-INF/vista/Reporte.jsp").forward(request, response);
    }
}