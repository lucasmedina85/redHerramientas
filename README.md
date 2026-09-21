# Red de Herramientas - Landing Page MVP 🛠️

Este proyecto es el MVP (Producto Mínimo Viable) del rediseño de la landing page para **Red de Herramientas**. Desarrollado en Flutter (Web/Mobile), el rediseño tiene un enfoque riguroso en la **accesibilidad (UX/UI)** pensado específicamente para mujeres mayores de 60 años.

## 🚀 Características Principales

- **Alto Contraste y Legibilidad:** Paleta de colores cálida (blanco, rosa pastel oscuro, amarillo pastel, celeste, verde pastel) con tipografías de gran tamaño (min 18px-20px).
- **Navegación Explícita:** Se evita la carga cognitiva con un Drawer global adaptativo (ícono de 3 rayas) para todas las plataformas y áreas táctiles grandes.
- **Diseño Adaptativo (Responsivo):** Layout estructurado en Desktop (70% contenido, 30% sidebar) y adaptado a una sola columna en Mobile. Tarjetas adaptativas sin scroll horizontal oculto.
- **Carrusel de Noticias Interactivo:** Sección de novedades estilo periodístico con giro automático (5s) y pausa inteligente cuando el usuario expande una nota para leer.
- **Botones Accesibles:** Áreas de interacción masivas (`minimumSize` extendido) que previenen clics accidentales.
- **Accesos Rápidos:** Botón flotante de WhatsApp local y botón de scroll up para navegación vertical sin fricción.
- **Identidad Gráfica:** Transición de paletas oscuras a tonos pasteles amigables (Rosa dominante, amarillo, verde agua y celeste).
- **Redirección de Donaciones:** Integración precisa con ScrollController para focalizar la zona de donativos ("Apoyá nuestro espacio") directamente desde el menú.

## 🛠️ Tecnologías

- [Flutter](https://flutter.dev/) (SDK >=3.0.0)
- Google Fonts (`google_fonts` package)

## 🏃‍♂️ Cómo ejecutar el proyecto

1. Asegúrate de tener instalado Flutter en tu entorno.
2. Clona este repositorio y ubícate en la carpeta del proyecto.
3. Descarga las dependencias:
   ```bash
   flutter pub get
   ```
4. Ejecuta la aplicación en tu navegador web:
   ```bash
   flutter run -d chrome
   ```

## 📖 Documentación Adicional
Para ver el detalle de los requerimientos, los ejes implementados y el diseño original, consulta el archivo [WIKI.md](WIKI.md) incluido en este repositorio.
