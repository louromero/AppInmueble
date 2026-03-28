<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>Registrar Visita - AppInmobiliaria</title>
        <link rel="stylesheet" href="css/vista.css">
        <style>
            body.register-page::before {
                content: "";
                position: absolute;
                top: 20%;
                width: 40%;
                height: 80%;
                border-radius: 50%;
                background-image: url('https://theolivebranchnest.com/wp-content/uploads/2024/10/Built-ins-living-room-24.jpg');
                background-size: cover;
                opacity: 0.6;
                pointer-events: none;
                z-index: -1;
            }

            body.register-page::after {
                content: "";
                position: absolute;
                bottom: 16%;
                right: 1%;
                width: 34%;
                height: 74%;
                border-radius: 50%;
                background-image: url('https://theolivebranchnest.com/wp-content/uploads/2024/10/Built-ins-living-room-37.jpg');
                background-size: cover;
                opacity: 0.6;
                pointer-events: none;
                z-index: -1;
            }

            .notification {
                padding: 15px;
                border-radius: 5px;
                margin-bottom: 20px;
                text-align: center;
                font-weight: bold;
            }
            .success {
                background-color: #4CAF50;
                color: white;
            }
            .error {
                background-color: #f44336;
                color: white;
            }

            .form-row {
                display: flex;
                gap: 20px;
            }
            .form-group {
                flex: 1;
                margin-bottom: 15px;
            }
            select, input {
                width: 100%;
                padding: 8px;
                border-radius: 4px;
                border: 1px solid #ccc;
            }
        </style>
    </head>
    <body class="register-page">
        <%@ include file="/WEB-INF/vista/Menu.jsp" %>
        <main>
            <section class="form-section">

                <h1>Registrar Visita a Inmueble</h1>

                <c:if test="${not empty error}">
                    <div class="notification error">${error}</div>
                </c:if>
                <c:if test="${not empty registroExitoso}">
                    <div class="notification success">¡La visita se registró con éxito!</div>
                </c:if>

                <form action="RegistrarVisita" method="post">
                    <div class="form-group">
                        <label for="agenteId">Agente Responsable:</label>
                        <select name="agenteId" id="agenteId" required>
                            <option value="">Seleccione un agente</option>
                            <c:forEach var="agente" items="${agentes}">
                                <option value="${agente.idagente}">${agente.nombre}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="clienteId">Cliente Interesado:</label>
                        <select name="clienteId" id="clienteId" required>
                            <option value="">Seleccione un cliente</option>
                            <c:forEach var="cliente" items="${clientes}">
                                <option value="${cliente.idcliente}">${cliente.nombre}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="inmuebleId">Inmueble a Visitar:</label>
                        <select name="inmuebleId" id="inmuebleId" required>
                            <option value="">Seleccione un inmueble</option>
                            <c:forEach var="inmueble" items="${inmuebles}">
                                <option value="${inmueble.idinmueble}">${inmueble.titulo} - ${inmueble.ubicacion}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="fecha">Fecha:</label>
                            <input type="date" id="fecha" name="fecha" required>
                        </div>

                        <div class="form-group">
                            <label for="hora">Hora:</label>
                            <input type="time" id="hora" name="hora" required>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="estado">Estado Inicial:</label>
                        <select name="estado" id="estado" required>
                            <option value="Pendiente">Pendiente</option>
                            <option value="Confirmada">Confirmada</option>
                        </select>
                    </div>

                    <button type="submit" class="btn">Confirmar Registro</button>
                    <a href="ListarVisitas" class="btn-secundario" style="display: block; text-align: center; margin-top: 10px; text-decoration: none; color: #666;">Cancelar</a>
                </form>

            </section>
        </main>
    </body>
</html>