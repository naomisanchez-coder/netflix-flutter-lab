# Netflix Flutter Lab

Aplicación académica de streaming inspirada en [Netflix Perú](https://www.netflix.com/pe/), con cinco pantallas, catálogo ficticio y tema oscuro. No está afiliada a Netflix y no ofrece reproducción real, autenticación ni suscripciones.

| Datos académicos | Información |
|---|---|
| Curso | Aplicaciones Multiplataformas |
| Desarrolladora | Naomi Sánchez Chavarría |
| Proyecto | Netflix Flutter Lab |
| Repositorio | https://github.com/naomisanchez-coder/netflix-flutter-lab |

## Objetivos

**General:** desarrollar una interfaz multiplataforma que aplique composición de widgets, navegación y manejo de estado en Flutter.

**Específicos:** construir cinco pantallas adaptables; representar un catálogo mediante listas, mapas y modelos tipados; filtrar contenido dinámicamente; compartir favoritos por perfil; integrar tres fuentes locales e imágenes locales y remotas con manejo de fallos.

## Tecnologías

Flutter 3.47.6 stable, Dart 3.13.5, Material, ChangeNotifier, flutter_test y flutter_lints. Orientada a Flutter Web en Chrome, con widgets compatibles con móvil. No requiere servicios externos para la lógica del catálogo ni paquetes de estado adicionales.

## Arquitectura y carpetas

Separación entre presentación, datos y estado. `main.dart` inicia la aplicación; `NetflixApp` configura tema y rutas; `MainShell` coordina las tres pestañas; `AppController` contiene el perfil y los favoritos.

```text
lib/
  main.dart
  app/netflix_app.dart
  theme/app_theme.dart
  models/media_item.dart
  data/catalog.dart
  controllers/app_controller.dart
  screens/
    profile_screen.dart
    home_screen.dart
    catalog_screen.dart
    detail_screen.dart
    my_netflix_screen.dart
  widgets/media_widgets.dart
assets/
  fonts/                  # Tres familias y sus licencias OFL
  images/                 # Identidad, tres avatares y cinco fondos originales
test/widget_test.dart
tools/generate_assets.py
evidencias/README.md
```

## Pantallas y funcionalidades

1. **Selección de perfil:** bienvenida, identidad local, tres avatares y administración informativa. Seleccionar un perfil abre Inicio y conserva su nombre en el estado.
2. **Inicio:** promoción destacada con imagen remota, título, género, reproducción simulada y botón Mi Lista. Carruseles Tendencias, Populares, Series y Películas con pósteres locales. Los accesos superiores abren el catálogo filtrado.
3. **Catálogo y búsqueda:** lista de resultados con póster, título, género, año y tipo. Búsqueda al escribir por título o género, insensible a mayúsculas; filtros Todos/Películas/Series; limpieza y estado sin coincidencias. No normaliza tildes.
4. **Detalle:** recibe un `MediaItem` por argumentos de ruta. Presenta imagen, título, año, duración o temporadas, género, clasificación demostrativa, sinopsis y contenido relacionado. Los botones guardan/quitan y explican que la reproducción es simulada.
5. **Mi Netflix:** perfil activo, lista guardada, eliminación directa, estado vacío, cuenta y configuración informativas; cambio de perfil sin acumular rutas anteriores.

Todos los botones tienen una respuesta. Las opciones de administración y cuenta informan su alcance demostrativo. No se solicitan credenciales.

## Matriz de cumplimiento del docente

| Requisito | Implementación real | Cómo demostrarlo |
|---|---|---|
| ListView | `screens/home_screen.dart`, `screens/detail_screen.dart`, `screens/my_netflix_screen.dart` | Desplazamiento vertical y carruseles horizontales |
| Row | `screens/home_screen.dart` | Identidad, saludo y acceso a búsqueda en el encabezado |
| Column | `screens/profile_screen.dart`, `screens/home_screen.dart` | Perfiles, promoción y agrupación vertical de secciones |
| ListTile | `screens/catalog_screen.dart`, `screens/my_netflix_screen.dart` | Resultados, favoritos y opciones de cuenta |
| Listas y mapas | `data/catalog.dart`, `controllers/app_controller.dart` | `List<Map<String, Object>>`, catálogo tipado y mapa de favoritos por perfil |
| Rutas | `app/netflix_app.dart` | `/`, `/home`, `/detail`; argumentos tipados y ruta inválida controlada |
| Tema global | `theme/app_theme.dart`, `app/netflix_app.dart` | `ThemeData` oscuro centralizado en MaterialApp |
| Card | `widgets/media_widgets.dart`, pantallas de perfiles, catálogo y usuario | Pósteres, perfiles, resultados y opciones |
| Tres tipografías | `theme/app_theme.dart`, `widgets/media_widgets.dart`, `pubspec.yaml` | Bebas Neue en promoción/pósteres; Montserrat en títulos de sección; Inter en textos generales |
| Imágenes locales | `assets/images/`, `widgets/media_widgets.dart` | `Image.asset` en identidad, perfiles, pósteres y respaldo |
| Imágenes en la nube | `widgets/media_widgets.dart`, `data/catalog.dart` | `Image.network` en promoción y detalle, indicador de carga y `errorBuilder` con respaldo local |

`ListView` permite desplazar contenido y construir los carruseles con `Axis.horizontal`. `Row` organiza elementos sobre el eje horizontal y `Column` sobre el vertical. `Expanded`, `Wrap`, zonas seguras y un ancho máximo de 1200 px ayudan a adaptar la composición. `ListTile` mantiene una estructura uniforme para listas accionables; `Card` agrupa contenido visual y ofrece superficies consistentes.

## Catálogo, listas y mapas

Hay 15 títulos ficticios entre películas y series. Cada mapa define ID único, título, sinopsis, género, año, duración/temporadas, tipo, categoría, póster local, URL principal e indicador destacado. `MediaItem.fromMap` transforma esos mapas en modelos tipados y el catálogo se expone como una lista no modificable.

La búsqueda combina título y género en minúsculas y aplica el tipo seleccionado. La aplicación no usa una API cinematográfica ni descarga metadatos.

## Navegación y estado

El inicio es `/` (perfiles). Seleccionar un perfil reemplaza esa ruta por `/home`. Inicio, Buscar y Mi Netflix son vistas de un mismo shell con navegación inferior; no agregan rutas repetidas al cambiar de pestaña. `/detail` recibe un objeto de catálogo; los argumentos incorrectos y rutas desconocidas muestran una salida controlada. Las rutas que requieren perfil verifican su presencia.

`AppController extends ChangeNotifier` notifica cambios; `ListenableBuilder` actualiza el shell y los botones guardados. Los favoritos se almacenan en `Map<String, Set<String>>`, donde cada perfil tiene sus IDs. Cambiar de perfil conserva las listas en memoria, pero recargar o cerrar la aplicación las elimina. No hay persistencia en disco, backend, pagos ni base de datos.

## Tema y fuentes

Fondo `#080808`, superficies `#141414`, acento `#E50914` y texto blanco/secundario. El tema global concentra colores, botones, entradas y estilos tipográficos.

| Familia local | Aplicación |
|---|---|
| Bebas Neue | Identidad textual, promoción, títulos sobre los pósteres y detalle |
| Montserrat | Títulos de secciones, pantallas y elementos con estilos de título Material |
| Inter | Descripciones, metadatos, búsquedas, diálogos y texto general |

Las tres fuentes se declaran en `pubspec.yaml` y se distribuyen con el repositorio: no se descargan durante el uso. Licencias SIL Open Font License en `assets/fonts/LICENSE-*.txt`.

## Imágenes y atribuciones

- Avatares, identidad simplificada y cinco ilustraciones abstractas de paisaje/espacio: recursos originales del laboratorio, generados con `tools/generate_assets.py` usando Python estándar (sin dependencias). Los títulos se superponen como texto Flutter para mantener legibilidad. Los cinco fondos se reutilizan en el catálogo.
- Fotografías remotas: [Unsplash](https://unsplash.com/license), servidas desde `images.unsplash.com`. Se utilizan paisajes y espacio como ambientación de historias ficticias; no son pósteres oficiales ni identifican una producción real.
- IDs de las cinco fotografías: `photo-1446776811953-b23d57bd21aa`, `photo-1518837695005-2083093ee35b`, `photo-1470770841072-f978cf4d019e`, `photo-1464822759023-fed622ff2c3b`, `photo-1441974231531-c6227db76b6e`. Las URLs completas están en `data/catalog.dart`. Se reconoce a sus autores colaboradores de Unsplash; el CDN no proporciona su identidad y no se atribuyen nombres no comprobados.
- Las cinco URLs se verificaron el 7 de noviembre de 2026: HTTP 200 y `Access-Control-Allow-Origin: *`. Esto comprueba disponibilidad/CORS en esa fecha, no disponibilidad futura. La interfaz conserva imágenes locales si fallan.
- Fuentes: [Google Fonts](https://github.com/google/fonts), directorios `ofl/bebasneue`, `ofl/montserrat` y `ofl/inter`; se incluyen sus licencias originales.
- Iconos: Material Icons incluidos por Flutter. Netflix se cita como referencia visual académica; no se usan videos, catálogos privados ni recursos oficiales de sus producciones.

## Instalación y ejecución manual

Desde la carpeta del proyecto:

```bash
flutter pub get
flutter run -d chrome
```

La ejecución y las capturas quedan a cargo de la desarrolladora. Durante la implementación **no se ejecutó la aplicación, no se abrió Chrome y no se levantó ningún servidor**.

Para regenerar únicamente las imágenes locales:

```bash
python3tools/generate_assets.py
```

## Validación técnica

```bash
flutter pub get
dart format lib test
flutter analyze
flutter test
flutter build web
```

Resultados del 7 de noviembre de 2026:

- Dependencias resueltas correctamente.
- Formato aplicado.
- Análisis sin incidencias.
- **5 pruebas aprobadas**: catálogo/búsqueda; favoritos por perfil; flujo completo a 320 px; flujo completo a 1440 px; respaldo de imagen remota fallida.
- Compilación web generada en `build/web` (incluido el dry run de compatibilidad Wasm). No se abrió ni sirvió la compilación.

Los dos flujos de widgets comprueban perfiles, Inicio, búsqueda, selección de detalle, favoritos, diálogo simulado, ausencia de resultados, limpieza, lista guardada y cambio de perfil. Las solicitudes de red están bloqueadas por el entorno de pruebas de Flutter y reciben HTTP 400: las pruebas usan el respaldo local, sin necesitar Internet. Esto no sustituye una revisión visual manual de Chrome ni prueba todos los tamaños o escalas de texto.

## Evidencias y entrega académica

Ver [evidencias/README.md](evidencias/README.md) para la lista de capturas pendientes. No se incluyen capturas inventadas. La rúbrica indica entrega grupal mediante Canvas y nombre `labxy`; confirmar el número de laboratorio y los integrantes al preparar la entrega. No se sube ningún archivo a Canvas desde esta implementación.

## Historial de desarrollo

Se conserva el commit inicial `53ea539`. Las etapas se agrupan en recursos/tema, catálogo/estado, pantallas/componentes, integración/pruebas y documentación. Se publican en `origin/main` sin reescribir historial. Los identificadores concretos se consultan con:

```bash
git log --oneline --reverse 53ea539..HEAD
git status --short
git rev-parse HEAD
git ls-remote origin refs/heads/main
```

El informe final de la sesión enumera los commits y la verificación de publicación.

## Limitaciones y mejoras futuras

Implementado: cinco pantallas, catálogo local, filtros, favoritos por perfil durante la sesión, rutas, tres fuentes locales, carga remota con respaldo y compilación web.

Limitaciones: reproducción y opciones de cuenta simuladas; sin autenticación ni persistencia; fondos originales reutilizados entre títulos; sin verificación visual realizada por el agente, por solicitud expresa. Las fotografías dependen de un servicio externo, aunque existe respaldo. La búsqueda distingue tildes y las preferencias del catálogo se reinician al abandonar la pestaña Buscar.

Posibles mejoras futuras: persistencia local por perfil, ilustraciones únicas por título, búsqueda sin tildes, edición real de perfiles, pruebas adicionales de accesibilidad y revisión en dispositivos físicos. Ninguna de estas mejoras se presenta como implementada.
