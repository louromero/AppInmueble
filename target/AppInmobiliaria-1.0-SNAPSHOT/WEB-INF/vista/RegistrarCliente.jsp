<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Registrar Cliente - AppInmobiliaria</title>
        <link rel="stylesheet" href="css/vista.css">
        <style>
            /* Imágenes de fondo transparentes */
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

            /* Estilo para mensajes de notificación */
            .notification {
                position: fixed;
                top: 20px;
                right: 20px;
                padding: 15px;
                border-radius: 5px;
                display: none;
                z-index: 1000;
                font-weight: bold;
                color: white;
            }
            .success {
                background-color: #4CAF50;
            }
            .error {
                background-color: #f44336;
            }

            .btn-secundario {
                display: block;
                text-align: center;
                margin-top: 15px;
                text-decoration: none;
                color: #666;
                font-size: 0.9em;
            }

            input {
                width: 100%;
                padding: 10px;
                margin-bottom: 15px;
                border: 1px solid #ccc;
                border-radius: 4px;
                box-sizing: border-box;
            }
        </style>
    </head>
    <body class="register-page">
        <%@ include file="/WEB-INF/vista/Menu.jsp" %>
        <main>
            <section class="form-section">

                <h2>Registrar Nuevo Cliente</h2>

                <div id="notification" class="notification <c:if test='${not empty error}'>error</c:if><c:if test='${not empty registroExitoso}'>success</c:if>">
                    <c:choose>
                        <c:when test='${not empty registroExitoso}'>¡Cliente registrado con éxito!</c:when>
                        <c:when test='${not empty error}'>${error}</c:when>
                    </c:choose>
                </div>

                <form action="RegistrarCliente" method="post" onsubmit="return validarFormulario()">
                    <div class="form-group">
                        <label for="nombre">Nombre Completo:</label>
                        <input type="text" id="nombre" name="nombre" placeholder="Ej: Juan Pérez" required>
                    </div>
                    <div class="form-group">
                        <label for="email">Correo Electrónico:</label>
                        <input type="email" id="email" name="email" placeholder="ejemplo@correo.com" required>
                    </div>
                    <div class="form-group">
                        <label for="telefono">Teléfono de Contacto:</label>
                        <input type="tel" id="telefono" name="telefono" placeholder="Ej: 12345678" required>
                    </div>

                    <button type="submit" class="btn">Confirmar Registro</button>
                    <a href="ListarClientes" class="btn-secundario">Cancelar y volver al listado</a>
                </form>

            </section>
        </main>

        <script>
            window.onload = function () {
                const notification = document.getElementById('notification');
                if (notification.innerText.trim() !== "") {
                    notification.style.display = 'block';
                    setTimeout(() => {
                        notification.style.display = 'none';
            <c:if test="${not empty registroExitoso}">
                        window.location.href = 'ListarClientes';
            </c:if>
                    }, 3000);
                }
            };

            function validarFormulario() {
                var nombre = document.getElementById("nombre").value.trim();
                var email = document.getElementById("email").value.trim();
                var telefono = document.getElementById("telefono").value.trim();

                if (nombre === "" || email === "" || telefono === "") {
                    alert("Por favor, complete todos los campos requeridos.");
                    return false;
                }
                return true;
            }
        </script>
    </body>
</html>