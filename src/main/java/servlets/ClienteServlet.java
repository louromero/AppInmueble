/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import services.InmobiliariaService;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "ClienteServlet", urlPatterns = {"/ListarClientes", "/RegistrarCliente", "/EliminarCliente"})
public class ClienteServlet extends HttpServlet {

    @EJB
    private InmobiliariaService service;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();
        if (path.equals("/ListarClientes")) {
            request.setAttribute("clientes", service.listarClientes());
            request.getRequestDispatcher("/WEB-INF/vista/ListarClientes.jsp").forward(request, response);
        } else if (path.equals("/RegistrarCliente") && request.getMethod().equals("POST")) {
            service.registrarCliente(request.getParameter("nombre"), request.getParameter("email"), request.getParameter("telefono"));
            response.sendRedirect("ListarClientes");
        } else if (path.equals("/RegistrarCliente")) {
            request.getRequestDispatcher("/WEB-INF/vista/RegistrarCliente.jsp").forward(request, response);
        } else if (path.equals("/EliminarCliente")) {
            service.eliminarCliente(Integer.parseInt(request.getParameter("idCliente")));
            response.sendRedirect("ListarClientes");
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