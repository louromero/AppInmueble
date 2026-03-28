<%@page import="java.util.List"%>
<%@page import="entities.VisitaInmueble"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Control de Visitas - AppInmobiliaria</title>
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
            background-color: #007bff;
            color: white;
            padding: 10px 20px;
            border-radius: 5px;
            text-decoration: none;
            font-weight: bold;
        }
        .status-scheduled { 
            color: #856404;
            background-color: #fff3cd; 
            padding: 4px 8px; 
            border-radius: 4px; 
            font-size: 0.9em;
        }
        .btn-edit {
            background-color: #ffc107;
            color: #212529;
            padding: 5px 10px;
            border-radius: 4px;
            text-decoration: none;
            font-size: 0.85em;
            font-weight: bold;
            margin-right: 5px;
        }
        /* Estilo para el botón eliminar */
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
    </style>
</head>
<body>
    <%@ include file="/WEB-INF/vista/Menu.jsp" %>
    <main>
        <div class="card-container">
            <div class="card">
                <div class="header-actions">
                    <h2>Visitas Programadas</h2>
                    <a href="RegistrarVisita" class="btn-nuevo"> + Agendar Nueva Visita</a>
                </div>

                <table class="styled-table">
                    <thead>
                        <tr>
                            <th>Fecha</th>
                            <th>Hora</th>
                            <th>Inmueble</th>
                            <th>Cliente</th>
                            <th>Agente</th>
                            <th>Estado</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            List<VisitaInmueble> visitas = (List<VisitaInmueble>) request.getAttribute("visitas");
                            if (visitas != null) {
                                for (VisitaInmueble v : visitas) {
                        %>
                        <tr>
                            <td><%= v.getVisitaInmueblePK().getFecha() %></td>
                            <td><%= v.getHora() %></td>
                            <td><%= v.getInmueble().getTitulo() %></td>
                            <td><%= v.getCliente().getNombre() %></td>
                            <td><%= v.getAgente().getNombre() %></td>
                            <td><span class="status-scheduled"><%= v.getEstado() %></span></td>
                            <td class="actions-cell">
                                <a href="EditarVisita?idVisita=<%= v.getVisitaInmueblePK().getIdvisitaInmueble() %>&fecha=<%= v.getVisitaInmueblePK().getFecha() %>" 
                                   class="btn-edit">Editar</a>
                                
                                <a href="EliminarVisita?idVisita=<%= v.getVisitaInmueblePK().getIdvisitaInmueble() %>&fecha=<%= v.getVisitaInmueblePK().getFecha() %>" 
                                   class="btn-delete" 
                                   onclick="return confirm('¿Está seguro de que desea eliminar esta visita?');">Eliminar</a>
                            </td>
                        </tr>
                        <% 
                                }
                            } else {
                        %>
                        <tr>
                            <td colspan="7" style="text-align: center;">No hay visitas programadas.</td>
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