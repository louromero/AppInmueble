<%@page import="entities.Agente"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<header class="main-header">
    <div class="logo">
        <a href="index.jsp">
            <h1>AppInmobiliaria</h1>
        </a>
    </div>
    <nav class="nav-container">
        <ul class="nav-list">
            <li><a href="ListarInmuebles">Inmuebles</a></li>
            <li><a href="ListarClientes">Clientes</a></li>
            <li><a href="ListarVisitas">Visitas</a></li>
            <li><a href="ListarAgentes">Agentes</a></li>
            
            <% 
                // Recuperar el agente de la sesión para validar el rol
                Agente usuarioSesion = (Agente) session.getAttribute("agente");
                if (usuarioSesion != null && "admin@gmail.com".equals(usuarioSesion.getEmail())) {
            %>
                <li><a href="Reporte" class="admin-link">Reportes</a></li>
            <% } %>

            <li class="logout-item"><a href="CerrarSesion">Cerrar Sesión</a></li>
        </ul>
    </nav>
</header>

<style>
    /* Estilos del encabezado principal */
    .main-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 10px 40px;
        background: #fff;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        font-family: Arial, sans-serif;
    }
    .logo a { 
        text-decoration: none; 
        color: #4b4b4b; 
    }
    .logo h1 {
        margin: 0;
        font-size: 24px;
    }
    .nav-list {
        list-style: none;
        display: flex;
        gap: 25px;
        margin: 0;
        padding: 0;
        align-items: center;
    }
    .nav-list li a {
        text-decoration: none;
        color: #333;
        font-weight: 500;
        transition: color 0.3s;
    }
    .nav-list li a:hover {
        color: #007bff;
    }
    /* Estilo especial para el link de administrador */
    .admin-link {
        color: #dc3545 !important; /* Un tono rojo/distintivo para indicar privilegio */
        font-weight: bold !important;
    }
    .logout-item a {
        background-color: #f8f9fa;
        padding: 8px 15px;
        border-radius: 5px;
        border: 1px solid #ddd;
    }
    .logout-item a:hover {
        background-color: #dc3545;
        color: white !important;
        border-color: #dc3545;
    }
</style>