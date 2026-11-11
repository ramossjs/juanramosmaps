# maps_and_geolocation

A new Flutter project.

## Desplegar en Render

Esta aplicación se despliega como un servicio web Docker en Render.

1. Sube este proyecto a un repositorio de GitHub, incluyendo `Dockerfile`,
   `nginx.conf`, `.dockerignore` y `render.yaml`.
2. En [Render](https://render.com), selecciona **New > Blueprint** y conecta el
   repositorio.
3. Render detectará `render.yaml`. Confirma la creación del servicio
   `maps-and-geolocation`.
4. Espera a que termine el primer build y abre la URL `.onrender.com`.

El navegador debe estar usando HTTPS para que la geolocalización funcione.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
