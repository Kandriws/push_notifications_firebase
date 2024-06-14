# Push Notifications App

## Descripción

Push Notifications App es un proyecto diseñado para probar notificaciones push utilizando Firebase. Este proyecto está construido con Flutter y hace uso de varias dependencias para gestionar la lógica de negocio, la navegación y la integración con Firebase.

## Tabla de Contenidos

- [Push Notifications App](#push-notifications-app)
  - [Descripción](#descripción)
  - [Tabla de Contenidos](#tabla-de-contenidos)
  - [Instalación](#instalación)
  - [Dependencias](#dependencias)
    - [Dependencias Principales](#dependencias-principales)
    - [Dependencias de Desarrollo](#dependencias-de-desarrollo)
  - [Estructura del Proyecto](#estructura-del-proyecto)
  - [Uso](#uso)
  - [Contribución](#contribución)

## Instalación

1. **Clona el repositorio:**

   ```bash
   git clone https://github.com/Kandriws/push_notifications_app.git
   cd push_notifications_app
   ```

2. **Instala las dependencias:**

   ```bash
   flutter pub get
   ```

3. **Configura Firebase:**

   - Sigue las [instrucciones oficiales de Firebase](https://firebase.flutter.dev/docs/overview) para configurar tu proyecto de Firebase con Flutter.
   - Asegúrate de añadir los archivos `google-services.json` (para Android) y `GoogleService-Info.plist` (para iOS) en los directorios correspondientes.

4. **Ejecuta la aplicación:**

   ```bash
   flutter run
   ```

## Dependencias

### Dependencias Principales

- **equatable**: ^2.0.5
  - Simplifica la comparación de objetos.
- **firebase_core**: ^3.1.0
  - Necesaria para la integración con Firebase.
- **firebase_messaging**: ^15.0.0
  - Permite el uso de notificaciones push con Firebase Cloud Messaging.
- **flutter**:
  - SDK de Flutter.
- **flutter_bloc**: ^8.1.5
  - Implementación del patrón BLoC (Business Logic Component).
- **go_router**: ^14.1.4
  - Solución de enrutamiento para Flutter.

### Dependencias de Desarrollo

- **flutter_lints**: ^3.0.0
  - Conjunto de reglas de linting recomendadas para Flutter.
- **flutter_test**:
  - SDK de Flutter para realizar pruebas.

## Estructura del Proyecto

La estructura básica del proyecto es la siguiente:

```
push_notifications_app/
├── android/
├── ios/
├── lib/
│   ├── blocs/
│   ├── models/
│   ├── repositories/
│   ├── screens/
│   ├── widgets/
│   └── main.dart
├── test/
├── pubspec.yaml
└── README.md
```

- **blocs/**: Contiene la lógica de negocio de la aplicación utilizando flutter_bloc.
- **models/**: Define los modelos de datos.
- **repositories/**: Maneja la interacción con fuentes de datos (Firebase, APIs, etc.).
- **screens/**: Contiene las diferentes pantallas de la aplicación.
- **widgets/**: Componentes reutilizables en la interfaz de usuario.
- **main.dart**: Punto de entrada de la aplicación.

## Uso

1. **Enviar Notificación de Prueba:**

   - Para probar las notificaciones push, puedes usar la consola de Firebase para enviar mensajes directamente a tu dispositivo registrado.

2. **Gestionar Notificaciones:**

   - La lógica para gestionar las notificaciones entrantes se encuentra en `lib/blocs/notification_bloc.dart`.

## Contribución

¡Las contribuciones son bienvenidas! Por favor, sigue estos pasos para contribuir al proyecto:

1. Realiza un fork del repositorio.
2. Crea una nueva rama (`git checkout -b feature/nueva-funcionalidad`).
3. Realiza los cambios necesarios y commitea (`git commit -am 'Añadir nueva funcionalidad'`).
4. Sube los cambios a tu repositorio (`git push origin feature/nueva-funcionalidad`).
5. Abre un Pull Request.

---

¡Gracias por usar Push Notifications App! Si tienes alguna pregunta o sugerencia, no dudes en abrir un issue o contactar al mantenedor del proyecto.


Guiado por curso de: `Fernando Herrera - Flutter cero a experto.`