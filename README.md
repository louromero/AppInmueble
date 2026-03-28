# AppInmueble

Aplicación web desarrollada en **Java EE** para la gestión de una inmobiliaria.
Permite administrar clientes, agentes, inmuebles y visitas de forma eficiente.

---

## Funcionalidades

*  Gestión de clientes
*  Gestión de agentes
*  Administración de inmuebles
*  Registro de visitas
*  Búsqueda y filtrado de propiedades
*  Manejo de sesiones de usuario

---

## Tecnologías utilizadas

* Java EE (Servlets + JSP)
* EJB (Enterprise Java Beans)
* JPA (Java Persistence API)
* GlassFish Server
* HTML / CSS / JavaScript
* NetBeans IDE

---

## Estructura del proyecto

```
AppInmueble/
│── src/
│   ├── java/
│   │   ├── servlets/
│   │   ├── services/
│   │   ├── models/
│   │   └── dao/
│   ├── webapp/
│   │   ├── views/
│   │   ├── css/
│   │   └── js/
│
│── nbproject/
│── pom.xml (si usas Maven)
│── README.md
```

---

## Requisitos

* JDK 8 o superior
* NetBeans IDE
* GlassFish Server configurado
* Navegador web moderno

---

## Cómo ejecutar el proyecto

1. Clonar el repositorio:

   ```bash
   git clone https://github.com/louromero/AppInmueble.git
   ```

2. Abrir el proyecto en NetBeans.

3. Configurar el servidor (GlassFish).

4. Ejecutar el proyecto:

   * Click derecho → **Run**

5. Acceder desde el navegador:

   ```
   http://localhost:8080/AppInmueble
   ```

---

## Arquitectura

El proyecto sigue una arquitectura en capas:

* **Servlets** → Controladores (manejo de requests)
* **Services** → Lógica de negocio
* **DAO** → Acceso a datos
* **Models** → Entidades
* **JSP** → Vista

Se utiliza una fachada de servicios para simplificar la interacción con la lógica del sistema y delegar la gestión de transacciones al contenedor.

---

