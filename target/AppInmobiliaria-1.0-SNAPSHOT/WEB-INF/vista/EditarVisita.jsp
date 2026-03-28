<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Editar Visita - AppInmobiliaria</title>
    <link rel="stylesheet" href="css/vista.css">
    <style>
        body.register-page::before {
            content: ""; position: absolute; top: 20%; width: 40%; height: 80%;
            border-radius: 50%; background-image: url('https://theolivebranchnest.com/wp-content/uploads/2024/10/Built-ins-living-room-24.jpg');
            background-size: cover; opacity: 0.6; pointer-events: none; z-index: -1;
        }
        body.register-page::after {
            content: ""; position: absolute; bottom: 16%; right: 1%; width: 34%; height: 74%;
            border-radius: 50%; background-image: url('https://theolivebranchnest.com/wp-content/uploads/2024/10/Built-ins-living-room-37.jpg');
            background-size: cover; opacity: 0.6; pointer-events: none; z-index: -1;
        }
        .form-group { margin-bottom: 15px; }
        select, input { width: 100%; padding: 10px; border-radius: 4px; border: 1px solid #ccc; box-sizing: border-box; }
        .info-readonly { background: #eee; color: #666; cursor: not-allowed; }
    </style>
</head>
<body class="register-page">
    <%@ include file="/WEB-INF/vista/Menu.jsp" %>
    <main>
        <section class="form-section">
            <h2>Modificar Visita</h2>

            <form action="EditarVisita" method="post">
                <input type="hidden" name="idVisita" value="${visita.visitaInmueblePK.idvisitaInmueble}">
                <input type="hidden" name="fechaOriginal" value="${visita.visitaInmueblePK.fecha}">

                <div class="form-group">
                    <label>Inmueble:</label>
                    <input type="text" class="info-readonly" value="${visita.inmueble.titulo}" readonly>
                </div>

                <div class="form-group">
                    <label>Cliente:</label>
                    <input type="text" class="info-readonly" value="${visita.cliente.nombre}" readonly>
                </div>

                <div class="form-group">
                    <label for="estado">Actualizar Estado:</label>
                    <select name="estado" id="estado" required>
                        <option value="Pendiente" ${visita.estado == 'Pendiente' ? 'selected' : ''}>Pendiente</option>
                        <option value="Confirmada" ${visita.estado == 'Confirmada' ? 'selected' : ''}>Confirmada</option>
                        <option value="Realizada" ${visita.estado == 'Realizada' ? 'selected' : ''}>Realizada</option>
                        <option value="Cancelada" ${visita.estado == 'Cancelada' ? 'selected' : ''}>Cancelada</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="hora">Modificar Hora:</label>
                    <%-- Se asegura el formato HH:mm para evitar el error de validación --%>
                    <input type="time" id="hora" name="hora" 
                           value="${fn:substring(visita.hora, 0, 5)}" required>
                </div>

                <button type="submit" class="btn">Guardar Cambios</button>
                <a href="ListarVisitas" class="btn-secundario" style="display:block; text-align:center; margin-top:15px; text-decoration:none; color:#666;">Volver al Listado</a>
            </form>
        </section>
    </main>
</body>
</html>