<%@page import="java.util.Map"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reportes Estadísticos - AppInmobiliaria</title>
    <link rel="stylesheet" href="css/vista.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        .report-actions {
            display: flex;
            gap: 10px;
            margin-bottom: 30px;
            flex-wrap: wrap;
            justify-content: center;
        }
        .btn-report {
            background-color: #f8f9fa;
            color: #333;
            padding: 12px 20px;
            border: 2px solid #dee2e6;
            border-radius: 8px;
            cursor: pointer;
            font-weight: bold;
            transition: all 0.3s;
        }
        .btn-report.active {
            background-color: #007bff;
            color: white;
            border-color: #007bff;
        }
        .chart-wrapper {
            position: relative;
            margin: auto;
            height: 400px;
            width: 100%;
            max-width: 800px;
        }
    </style>
</head>
<body>
    <%@ include file="/WEB-INF/vista/Menu.jsp" %>
    <main>
        <div class="card-container">
            <div class="card">
                <h2>Panel de Reportes Interactivos</h2>
                <p style="text-align: center; color: #666; margin-bottom: 20px;">
                    Seleccione un reporte para visualizar las estadísticas en tiempo real.
                </p>

                <div class="report-actions">
                    <button class="btn-report active" onclick="mostrarGrafico('agentes', this)">Visitas por Agente</button>
                    <button class="btn-report" onclick="mostrarGrafico('estados', this)">Estado de Visitas</button>
                    <button class="btn-report" onclick="mostrarGrafico('inmuebles', this)">Tipos de Inmuebles</button>
                </div>

                <div class="chart-wrapper">
                    <canvas id="myChart"></canvas>
                </div>
            </div>
        </div>
    </main>

    <script>
        let chartInstance = null;

        // Datos inyectados desde el servidor
        const datosAgentes = {
            labels: [<% Map<String, Long> da = (Map<String, Long>)request.getAttribute("datosAgentes");
                       for(String key : da.keySet()) { out.print("'" + key + "',"); } %>],
            data: [<% for(Long val : da.values()) { out.print(val + ","); } %>]
        };

        const datosEstados = {
            labels: [<% Map<String, Long> de = (Map<String, Long>)request.getAttribute("datosEstados");
                       for(String key : de.keySet()) { out.print("'" + key + "',"); } %>],
            data: [<% for(Long val : de.values()) { out.print(val + ","); } %>]
        };

        const datosInmuebles = {
            labels: [<% Map<String, Long> di = (Map<String, Long>)request.getAttribute("datosInmuebles");
                       for(String key : di.keySet()) { out.print("'" + key + "',"); } %>],
            data: [<% for(Long val : di.values()) { out.print(val + ","); } %>]
        };

        function generarGrafico(config) {
            const ctx = document.getElementById('myChart').getContext('2d');
            
            if (chartInstance) {
                chartInstance.destroy();
            }

            chartInstance = new Chart(ctx, {
                type: config.type,
                data: {
                    labels: config.labels,
                    datasets: [{
                        label: config.title,
                        data: config.data,
                        backgroundColor: [
                            'rgba(0, 123, 255, 0.7)',
                            'rgba(40, 167, 69, 0.7)',
                            'rgba(255, 193, 7, 0.7)',
                            'rgba(220, 53, 69, 0.7)',
                            'rgba(102, 16, 242, 0.7)'
                        ],
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: { position: 'bottom' }
                    }
                }
            });
        }

        function mostrarGrafico(tipo, elemento) {
            // Manejo de clase activa en botones
            document.querySelectorAll('.btn-report').forEach(btn => btn.classList.remove('active'));
            elemento.classList.add('active');

            if (tipo === 'agentes') {
                generarGrafico({
                    type: 'bar',
                    labels: datosAgentes.labels,
                    data: datosAgentes.data,
                    title: 'Cantidad de Visitas'
                });
            } else if (tipo === 'estados') {
                generarGrafico({
                    type: 'pie',
                    labels: datosEstados.labels,
                    data: datosEstados.data,
                    title: 'Estados'
                });
            } else if (tipo === 'inmuebles') {
                generarGrafico({
                    type: 'doughnut',
                    labels: datosInmuebles.labels,
                    data: datosInmuebles.data,
                    title: 'Inmuebles por Tipo'
                });
            }
        }

        // Cargar el primer gráfico por defecto
        window.onload = () => {
            mostrarGrafico('agentes', document.querySelector('.btn-report'));
        };
    </script>
</body>
</html>