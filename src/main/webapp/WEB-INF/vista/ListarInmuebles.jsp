<%@page import="java.util.List"%>
<%@page import="entities.Inmueble"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lista de Inmuebles - AppInmobiliaria</title>
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
            background-color: #007bff; /* Azul estándar para botones de creación */
            color: white;
            padding: 10px 20px;
            border-radius: 5px;
            text-decoration: none;
            font-weight: bold;
        }
        .price-tag { 
            color: #28a745; 
            font-weight: bold;
        }
        /* Estilos alineados con Agentes y Visitas */
        .btn-edit {
            background-color: #ffc107;
            color: #212529;
            padding: 5px 10px;
            border-radius: 4px;
            text-decoration: none;
            font-size: 0.85em;
            font-weight: bold;
        }
        .btn-delete {
            background-color: #dc3545;
            color: white;
            padding: 5px 10px;
            border-radius: 4px;
            text-decoration: none;
            font-size: 0.85em;
            font-weight: bold;
            border: none;
            cursor: pointer;
        }
        .actions-cell {
            display: flex;
            gap: 5px;
        }
        .badge {
            background-color: #e9ecef;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 0.9em;
        }
    </style>
</head>
<body>
    <%@ include file="/WEB-INF/vista/Menu.jsp" %>
    <main>
        <div class="card-container">
            <div class="card">
                <div class="header-actions">
                    <h2>Catálogo de Inmuebles</h2>
                    <a href="RegistrarInmueble" class="btn-nuevo"> + Registrar Nuevo Inmueble</a>
                </div>

                <table class="styled-table">
                    <thead>
                        <tr>
                            <th>Título</th>
                            <th>Ubicación</th>
                            <th>Tipo</th>
                            <th>Estado</th>
                            <th>Precio</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            List<Inmueble> inmuebles = (List<Inmueble>) request.getAttribute("inmuebles");
                            if (inmuebles != null) {
                                for (Inmueble inmueble : inmuebles) {
                        %>
                        <tr>
                            <td><%= inmueble.getTitulo() %></td>
                            <td><%= inmueble.getUbicacion() %></td>
                            <td><%= inmueble.getTipo() %></td>
                            <td><span class="badge"><%= inmueble.getEstado() %></span></td>
                            <td class="price-tag">$<%= inmueble.getPrecio() %></td>
                            <td class="actions-cell">
                                <a href="DetalleInmueble?id=<%= inmueble.getIdinmueble() %>" class="btn-edit">Ver Detalle</a>
                                
                                <form action="EliminarInmueble" method="post" style="display:inline;">
                                    <input type="hidden" name="idInmueble" value="<%= inmueble.getIdinmueble() %>">
                                    <button type="submit" class="btn-delete" onclick="return confirm('¿Borrar inmueble?')">Eliminar</button>
                                </form>
                            </td>
                        </tr>
                        <% 
                                }
                            } else {
                        %>
                        <tr>
                            <td colspan="6" style="text-align: center;">No hay inmuebles registrados.</td>
                        </tr>
                        <% 
                            } 
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </main>
</body>
</html>