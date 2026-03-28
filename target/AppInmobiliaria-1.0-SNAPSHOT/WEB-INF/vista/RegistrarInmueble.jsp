<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>Registrar Inmueble - AppInmobiliaria</title>
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
                padding: 15px;
                border-radius: 5px;
                margin-bottom: 20px;
                text-align: center;
                font-weight: bold;
                display: none; /* Se activa por JS */
            }
            .success {
                background-color: #4CAF50;
                color: white;
            }
            .error {
                background-color: #f44336;
                color: white;
            }

            /* Ajustes de formulario */
            .form-row {
                display: flex;
                gap: 20px;
            }
            .form-group {
                flex: 1;
                margin-bottom: 15px;
            }
            input, select, textarea {
                width: 100%;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 4px;
                box-sizing: border-box;
            }
            textarea {
                height: 80px;
                resize: none;
            }

            .btn-secundario {
                display: block;
                text-align: center;
                margin-top: 10px;
                text-decoration: none;
                color: #666;
                font-size: 0.9em;
            }
        </style>
    </head>
    <body class="register-page">
        <%@ include file="/WEB-INF/vista/Menu.jsp" %>
        <main>
            <section class="form-section">

                <h2>Registrar Nuevo Inmueble</h2>

                <c:if test="${not empty error}">
                    <div class="notification error" id="notif">${error}</div>
                </c:if>
                <c:if test="${not empty registroExitoso}">
                    <div class="notification success" id="notif">¡El inmueble se registró con éxito!</div>
                </c:if>

                <form action="RegistrarInmueble" method="POST">
                    <div class="form-group">
                        <label for="titulo">Título del Anuncio:</label>
                        <input type="text" name="titulo" id="titulo" placeholder="Ej: Hermosa casa en zona norte" required>
                    </div>

                    <div class="form-group">
                        <label for="descripcion">Descripción Detallada:</label>
                        <textarea name="descripcion" id="descripcion" placeholder="Describa las características principales..." required></textarea>
                    </div>

                    <div class="form-group">
                        <label for="ubicacion">Ubicación / Dirección:</label>
                        <input type="text" name="ubicacion" id="ubicacion" placeholder="Calle, Ciudad, Barrio" required>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="estado">Operación:</label>
                            <select name="estado" id="estado" required>
                                <option value="Alquiler">Alquiler</option>
                                <option value="Venta">Venta</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="tipo">Tipo de Propiedad:</label>
                            <select name="tipo" id="tipo" required>
                                <option value="Casa">Casa</option>
                                <option value="Departamento">Departamento</option>
                                <option value="Terreno">Terreno</option>
                                <option value="Oficina">Oficina</option>
                                <option value="Local">Local</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="precio">Precio (USD/ARS):</label>
                        <input type="number" step="0.01" name="precio" id="precio" placeholder="0.00" required>
                    </div>

                    <button type="submit" class="btn">Publicar Inmueble</button>
                    <a href="ListarInmuebles" class="btn-secundario">Cancelar y volver al listado</a>
                </form>

            </section>
        </main>

        <script>
            window.onload = function () {
                const notification = document.getElementById('notif');
                if (notification && notification.innerText.trim() !== "") {
                    notification.style.display = 'block';
                    setTimeout(() => {
                        notification.style.display = 'none';
            <% if (request.getAttribute("registroExitoso") != null) { %>
                        window.location.href = 'ListarInmuebles';
            <% }%>
                    }, 3000);
                }
            };
        </script>
    </body>
</html>