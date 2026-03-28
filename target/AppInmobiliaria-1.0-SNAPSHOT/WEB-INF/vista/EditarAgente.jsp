<%@page import="entities.Agente"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Editar Agente - AppInmobiliaria</title>
    <link rel="stylesheet" href="css/vista.css">
</head>
<body>
    <%@ include file="/WEB-INF/vista/Menu.jsp" %>
    <main>
        <% Agente a = (Agente) request.getAttribute("agenteEditar"); %>
        <section class="form-section">
            <h2>Editar Agente</h2>
            <form action="EditarAgente" method="post">
                <input type="hidden" name="idAgente" value="<%= a.getIdagente() %>">
                <div class="form-group">
                    <label>Nombre:</label>
                    <input type="text" name="nombre" value="<%= a.getNombre() %>" required>
                </div>
                <div class="form-group">
                    <label>Correo:</label>
                    <input type="email" name="email" value="<%= a.getEmail() %>" required>
                </div>
                <div class="form-group">
                    <label>Teléfono:</label>
                    <input type="tel" name="telefono" value="<%= a.getTelefono() %>" required>
                </div>
                <div class="form-group">
                    <label>Clave:</label>
                    <input type="password" name="clave" value="<%= a.getClave() %>" required>
                </div>
                <button type="submit" class="btn">Guardar Cambios</button>
                <a href="ListarAgentes" style="margin-left:10px;">Cancelar</a>
            </form>
        </section>
    </main>
</body>
</html>