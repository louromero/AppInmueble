<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Iniciar Sesión - AppInmobiliaria</title>
        <link rel="stylesheet" href="css/vista.css">
        <style>
            body.login-page::before {
                content: "";
                position: absolute;
                top: 20%;
                /*left: 10%;*/
                width: 40%;
                height: 80%;
                border-radius: 50%;
                background-image: url('https://theolivebranchnest.com/wp-content/uploads/2024/10/Built-ins-living-room-24.jpg'); /* Reemplaza con la ruta de tu imagen */
                background-size: cover;
                opacity: 0.6;
                pointer-events: none;
                z-index: -1;
            }

            body.login-page::after {
                content: "";
                position: absolute;
                bottom: 16%;
                right: 1%;
                width: 34%;
                height: 74%;
                border-radius: 50%;
                background-image: url('https://theolivebranchnest.com/wp-content/uploads/2024/10/Built-ins-living-room-37.jpg'); /* Reemplaza con la ruta de tu segunda imagen */
                background-size: cover;
                opacity: 0.6;
                pointer-events: none;
                z-index: -1;
            }
        </style>
    </head>
    <body class="login-page">
        <header>
            <div class="logo">
                <a href="index.jsp">
                    <h1>AppInmobiliaria</h1>
                </a>
            </div>
            <nav>
                <ul>
                    <li><a href="index.jsp">Inicio</a></li>
                    <li><a href="RegistrarAgente">Registrarse</a></li>
                </ul>
            </nav>
        </header>
        <main>
            <section class="form-section">
                <h2>Iniciar Sesión</h2>
                <form action="IniciarSesion" method="post">
                    <div class="form-group">
                        <label for="email">Correo Electrónico:</label>
                        <input type="email" id="email" name="correo" required>
                    </div>
                    <div class="form-group">
                        <label for="password">Contraseña:</label>
                        <input type="password" id="password" name="contrasena" required>
                    </div>
                    <button type="submit" class="btn">Iniciar Sesión</button>
                </form>

                <p>¿No tienes cuenta? <a href="RegistrarAgente" style="color: black;">Regístrate aquí</a></p>
            </section>
        </main>
    </body>
</html>
