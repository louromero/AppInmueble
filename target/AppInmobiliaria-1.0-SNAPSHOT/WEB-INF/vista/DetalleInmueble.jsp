<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/vista/Menu.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Detalle de Inmueble</title>
        <link rel="stylesheet" href="css/vista.css">
        <style>
            body { background-color: #f4f7f6; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
            .detail-container { width: 85%; margin: 30px auto; display: flex; flex-wrap: wrap; gap: 25px; }
            .info-card, .upload-section { background: white; padding: 25px; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.08); flex: 1; min-width: 350px; }
            .carousel-container { flex: 1.5; min-width: 400px; position: relative; background: #1a1a1a; border-radius: 12px; overflow: hidden; height: 450px; display: flex; align-items: center; }
            .slide-img { width: 100%; height: 100%; object-fit: contain; display: none; }
            .slide-img.active { display: block; animation: fadeIn 0.5s; }
            @keyframes fadeIn { from { opacity: 0; } to { opacity: 1; } }
            .nav-btn { cursor: pointer; position: absolute; top: 50%; transform: translateY(-50%); background: rgba(255,255,255,0.2); color: white; border: none; padding: 15px; border-radius: 50%; font-size: 18px; transition: 0.3s; z-index: 10; }
            .nav-btn:hover { background: rgba(255,255,255,0.5); }
            .prev { left: 15px; } .next { right: 15px; }
            .upload-section h3 { color: #333; margin-bottom: 20px; border-bottom: 2px solid #28a745; display: inline-block; }
            .form-group { margin-bottom: 15px; }
            .form-group label { display: block; margin-bottom: 5px; font-weight: 600; color: #555; }
            .form-control { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 6px; box-sizing: border-box; transition: border 0.3s; }
            .form-control:focus { border-color: #28a745; outline: none; }
            .btn-submit { background: #28a745; color: white; border: none; padding: 12px 25px; border-radius: 6px; cursor: pointer; font-weight: bold; width: 100%; font-size: 16px; margin-top: 10px;}
            .btn-submit:hover { background: #218838; }
            .no-images { height: 100%; width: 100%; display: flex; flex-direction: column; align-items: center; justify-content: center; background: #e9ecef; color: #6c757d; }
            .fallback-img { width: 100%; height: 100%; object-fit: cover; }
        </style>
    </head>
    <body>
        <div class="detail-container">
            <section class="info-card">
                <h2 style="color: #2c3e50; margin-top: 0;">${inmueble.titulo}</h2>
                <hr>
                <p><strong>Precio:</strong> <span style="color: #28a745; font-size: 1.2em;">$${inmueble.precio}</span></p>
                <p><strong>Ubicación:</strong> ${inmueble.ubicacion}</p>
                <p><strong>Estado:</strong> ${inmueble.estado}</p>
                <p><strong>Tipo:</strong> ${inmueble.tipo}</p>
                <p><strong>Descripción:</strong><br>${inmueble.descripcion}</p>
            </section>

            <section class="carousel-container">
                <c:choose>
                    <c:when test="${not empty inmueble.imagenesInmuebleCollection}">
                        <c:forEach var="img" items="${inmueble.imagenesInmuebleCollection}" varStatus="status">
                            <%-- Lógica para detectar si es URL externa o local --%>
                            <c:set var="imgUrl" value="${img.urlImagen.startsWith('http') ? img.urlImagen : pageContext.request.contextPath.concat('/').concat(img.urlImagen)}" />
                            
                            <img src="${imgUrl}" 
                                 class="slide-img ${status.first ? 'active' : ''}" 
                                 alt="${img.descripcion}"
                                 onerror="this.onerror=null; this.src='https://static.vecteezy.com/system/resources/previews/017/173/007/non_2x/can-not-load-corrupted-image-concept-illustration-flat-design-eps10-modern-graphic-element-for-landing-page-empty-state-ui-infographic-icon-vector.jpg';">
                        </c:forEach>
                        <c:if test="${inmueble.imagenesInmuebleCollection.size() > 1}">
                            <button class="nav-btn prev" onclick="moveSlide(-1)">&#10094;</button>
                            <button class="nav-btn next" onclick="moveSlide(1)">&#10095;</button>
                        </c:if>
                    </c:when>
                    <c:otherwise>
                        <div class="no-images">
                            <img src="https://static.vecteezy.com/system/resources/previews/017/173/007/non_2x/can-not-load-corrupted-image-concept-illustration-flat-design-eps10-modern-graphic-element-for-landing-page-empty-state-ui-infographic-icon-vector.jpg" class="fallback-img">
                        </div>
                    </c:otherwise>
                </c:choose>
            </section>

            <section class="upload-section">
                <h3>Agregar Nueva Imagen</h3>
                <form action="${pageContext.request.contextPath}/CargarImagen" method="POST" enctype="multipart/form-data">
                    <input type="hidden" name="idInmueble" value="${inmueble.idinmueble}">

                    <div class="form-group">
                        <label>Opción A: Subir archivo local</label>
                        <input type="file" name="archivoImagen" accept="image/*" class="form-control">
                    </div>

                    <div style="text-align: center; margin: 10px 0; font-weight: bold; color: #888;">- O -</div>

                    <div class="form-group">
                        <label>Opción B: Pegar URL de internet</label>
                        <input type="text" name="urlExterna" placeholder="https://ejemplo.com/foto.jpg" class="form-control">
                    </div>

                    <div class="form-group">
                        <label>Descripción:</label>
                        <input type="text" name="descripcionImagen" placeholder="Ej: Fachada principal" class="form-control">
                    </div>

                    <button type="submit" class="btn-submit">Subir y Guardar</button>
                </form>
            </section>
        </div>

        <script>
            let index = 0;
            function moveSlide(step) {
                const slides = document.querySelectorAll('.slide-img');
                if (slides.length <= 1) return;
                slides[index].classList.remove('active');
                index = (index + step + slides.length) % slides.length;
                slides[index].classList.add('active');
            }
        </script>
    </body>
</html>