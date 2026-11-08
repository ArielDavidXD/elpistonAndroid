El Pistón
Aplicación móvil para la gestión de un taller automotriz, desarrollada con Flutter. Permite administrar clientes, vehículos, órdenes de servicio, mecánicos, repuestos, pagos y reportes.
Tecnologías
- Flutter y Dart.
- Drift y SQLite para guardar los datos localmente.
- go_router para la navegación.
- Material 3 para la interfaz.
Decisiones de diseño
- Funcionamiento offline: los datos se almacenan en SQLite en el dispositivo, por lo que la aplicación no necesita conexión a Internet.
- Arquitectura MVVM: se separan las pantallas, los ViewModels y la lógica de la aplicación para mantener el código organizado.
- Persistencia con Drift: se utiliza una base de datos relacional para representar las relaciones entre clientes, vehículos, órdenes, repuestos y pagos.
- Patrón repositorio: permite separar la lógica de la aplicación del sistema de almacenamiento y facilita las pruebas.
- Interfaz Material 3: se utiliza un diseño común en toda la aplicación, con tema claro y oscuro.
- Navegación con estado: las secciones principales conservan su estado al cambiar entre ellas.
Capturas
La carpeta capturas/ contiene imágenes de la aplicación en funcionamiento.
Ejecución
Se necesita tener Flutter y el SDK de Android instalados. Desde la carpeta del proyecto, ejecutar:
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
Autor
Ariel David Marín