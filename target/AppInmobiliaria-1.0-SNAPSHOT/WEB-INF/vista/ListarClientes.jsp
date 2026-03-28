<%@page import="java.util.List"%>
<%@page import="entities.Cliente"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lista de Clientes - AppInmobiliaria</title>
    <link rel="stylesheet" href="css/vista.css">
    <style>
        .header-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #eee;
        }
        .btn-nuevo {
            background-color: #28a745;
            color: white;
            padding: 10px 20px;
            border-radius: 5px;
            text-decoration: none;
            font-weight: bold;
            transition: background 0.3s;
        }
        .btn-nuevo:hover {
            background-color: #218838;
        }
        .error-msg {
            color: #721c24;
            background-color: #f8d7da;
            padding: 12px;
            border: 1px solid #f5c6cb;
            border-radius: 5px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <%@ include file="/WEB-INF/vista/Menu.jsp" %>
    <main>
        <div class="card-container">
            <div class="card">
                <div class="header-actions">
                    <h2>Gestión de Clientes</h2>
                    <a href="RegistrarCliente" class="btn-nuevo"> + Registrar Nuevo Cliente</a>
                </div>

                <% if (request.getAttribute("error") != null) { %>
                    <div class="error-msg">
                        <strong>Error:</strong> <%= request.getAttribute("error") %>
                    </div>
                <% } %>

                <table class="styled-table">
                    <thead>
                        <tr>
                            <th>Nombre</th>
                            <th>Teléfono</th>
                            <th>Correo</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            List<Cliente> clientes = (List<Cliente>) request.getAttribute("clientes");
                            if (clientes != null) {
                                for (Cliente cliente : clientes) {
                        %>
                        <tr>
                            <td><%= cliente.getNombre() %></td>
                            <td><%= cliente.getTelefono() %></td>
                            <td><%= cliente.getEmail() %></td>
                            <td>
                                <form action="EliminarCliente" method="post" style="display:inline;">
                                    <input type="hidden" name="idCliente" value="<%= cliente.getIdcliente() %>">
                                    <button type="submit" class="btn-detalle" 
                                            onclick="return confirm('¿Está seguro de eliminar este cliente?')">Eliminar</button>
                                </form>
                            </td>
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