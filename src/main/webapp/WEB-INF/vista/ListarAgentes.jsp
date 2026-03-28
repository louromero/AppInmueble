<%@page import="java.util.List"%>
<%@page import="entities.Agente"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lista de Agentes - AppInmobiliaria</title>
    <link rel="stylesheet" href="css/vista.css">
    <style>
        .header-actions { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }
        .btn-nuevo { background-color: #007bff; color: white; padding: 10px 20px; border-radius: 5px; text-decoration: none; font-weight: bold; }
        .btn-edit { background-color: #ffc107; color: #212529; padding: 5px 10px; border-radius: 4px; text-decoration: none; font-size: 0.85em; font-weight: bold; margin-right: 5px; }
        .btn-delete { background-color: #dc3545; color: white; padding: 5px 10px; border-radius: 4px; text-decoration: none; font-size: 0.85em; font-weight: bold; border: none; cursor: pointer; }
        .actions-cell { display: flex; gap: 5px; }
    </style>
</head>
<body>
    <%@ include file="/WEB-INF/vista/Menu.jsp" %>
    <%
        Agente userSession = (Agente) session.getAttribute("agente");
        boolean isAdmin = userSession != null && "admin@gmail.com".equals(userSession.getEmail());
    %>
    <main>
        <div class="card-container">
            <div class="card">
                <div class="header-actions">
                    <h2>Lista de Agentes</h2>
                    <% if (isAdmin) { %>
                        <a href="RegistrarAgente" class="btn-nuevo"> + Nuevo Agente</a>
                    <% } %>
                </div>
                <table class="styled-table">
                    <thead>
                        <tr>
                            <th>Nombre</th>
                            <th>Teléfono</th>
                            <th>Correo</th>
                            <% if (isAdmin) { %> <th>Acciones</th> <% } %>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            List<Agente> agentes = (List<Agente>) request.getAttribute("agentes");
                            if (agentes != null) {
                                for (Agente agente : agentes) {
                        %>
                        <tr>
                            <td><%= agente.getNombre() %></td>
                            <td><%= agente.getTelefono() %></td>
                            <td><%= agente.getEmail() %></td>
                            <% if (isAdmin) { %>
                            <td class="actions-cell">
                                <a href="EditarAgente?idAgente=<%= agente.getIdagente() %>" class="btn-edit">Editar</a>
                                <a href="EliminarAgente?idAgente=<%= agente.getIdagente() %>" 
                                   class="btn-delete" 
                                   onclick="return confirm('¿Eliminar a este agente?')">Eliminar</a>
                            </td>
                            <% } %>
                        </tr>
                        <% 
                                }
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </main>
</body>
</html>