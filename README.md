# Documentación de la aplicación CASERITA-MARKET
producto del productor al consumidor

## ¿Qué hace esta aplicación?
Caserita Market es una app móvil para conectar productores con compradores. Permite:
- Registrar usuarios como **comprador** o **productor**.
- Iniciar sesión con correo y contraseña.
- Mostrar un dashboard personalizado según el rol:
  - Compradores ven precios y alertas IA.
  - Productores pueden publicar productos.
- Ver productos del mercado en tiempo real usando Firestore.
- Ver detalles de productos y enlaces de ubicación.
- Cerrar sesión desde el perfil.

## Estructura principal del proyecto

### Archivos clave
- `lib/main.dart`
  - Punto de entrada de la app.
  - Inicializa Firebase.
  - Selecciona `HomeScreen` o `LoginScreen` según el estado de autenticación.

- `lib/features/auth/controllers/auth_controller.dart`
  - Controlador de autenticación con Firebase Auth.
  - Gestiona login, registro y logout.
  - Guarda el rol de usuario (`comprador` o `productor`) en Firestore.

- `lib/features/auth/screens/login_screen.dart`
  - Pantalla de inicio de sesión.
  - Permite seleccionar si se ingresa como comprador o productor.

- `lib/features/auth/screens/register_screen.dart`
  - Pantalla de registro de usuario.
  - Recibe nombre, correo, contraseña y rol.

- `lib/features/home/home_screen.dart`
  - Pantalla principal después del login.
  - Muestra un dashboard de bienvenida con el rol del usuario.
  - Contiene navegación por pestañas según el rol.

### Módulos / carpetas principales
- `lib/features/auth/`
  - Funciones de autenticación y registro.
- `lib/features/home/`
  - Dashboard principal y navegación.
- `lib/features/products/`
  - Pantallas relacionadas a productos y mercado.
- `lib/features/profile/`
  - Pantalla de perfil y cierre de sesión.
- `lib/features/ai/`
  - Pantalla de alertas IA y análisis.
- `lib/features/map/`
  - Funcionalidad de mapas / ubicaciones.

## Estructura Del Codigo
caserita_market/
│
├── assets/
│   └── images/
│       └── logo_caserita.png          # 📸 Tu logo oficial (la Cholita)
│
├── lib/
│   ├── features/                      # 💡 Funcionalidades principales de la app
│   │   │
│   │   ├── ai/                        # 🤖 Módulo de Inteligencia Artificial
│   │   │   └── ai_analysis_screen.dart
│   │   │
│   │   ├── auth/                      # 🔐 Módulo de Seguridad y Accesos
│   │   │   ├── controllers/
│   │   │   │   └── auth_controller.dart
│   │   │   └── screens/
│   │   │       ├── login_screen.dart
│   │   │       ├── register_screen.dart # 🎯 ¡Ubicado aquí correctamente!
│   │   │       └── welcome_screen.dart   # 🌟 Tu nueva pantalla de presentación
│   │   │
│   │   ├── home/                      # 🏠 Menú Principal de la App
│   │   │   └── home_screen.dart        # 🧭 El Director de Orquesta (Pestañas)
│   │   │
│   │   ├── products/                  # 🥬 Módulo de Gestión de Productos
│   │   │   └── screens/
│   │   │       ├── product_list_screen.dart
│   │   │       └── register_product_screen.dart
│   │   │
│   │   └── profile/                   # 👤 Módulo del Perfil de Usuario
│   │       └── profile_screen.dart
│   │
│   ├── services/                      # 🌐 Servicios Externos e Infraestructura
│   │   └── gemini_service.dart         # 🔥 Tu conexión real con la IA de Google
│   │
│   ├── firebase_options.dart           # ⚙️ Llaves de conexión automática a Firebase
│   └── main.dart                       # 🚀 El motor de arranque de toda tu aplicación
│
└── pubspec.yaml                        # 📦 El archivo donde activaste el logo y los paquetes
## Tecnologías usadas
- **Flutter**: framework multiplataforma para UI.
- **Dart**: lenguaje de programación principal.
- **Firebase Auth**: autenticación de usuarios.
- **Firebase Firestore**: base de datos en tiempo real.
- **Provider**: gestión de estado.
- **url_launcher**: abrir enlaces externos (mapas).

## Flujo de navegación principal
1. Usuario abre la app.
2. Si no está autenticado, ve `LoginScreen`.
3. Si está autenticado, va a `HomeScreen`.
4. En el home se muestra una bienvenida con el rol actual.
5. El rol define qué pestañas ve el usuario:
   - `comprador`: Precios, Alerta IA, Perfil.
   - `productor`: Precios, Vender, Alerta IA, Perfil.

## Notas importantes
- El rol de usuario se guarda en Firestore en la colección `usuarios`.
- El login valida que el rol seleccionado coincida con el rol guardado.
- El dashboard muestra texto de bienvenida específico para comprador o productor.

## Consejos rápidos
- Para cambiar cómo se muestra el dashboard, edita `lib/features/home/home_screen.dart`.
- Para ajustar el login y los roles, edita `lib/features/auth/screens/login_screen.dart` y `lib/features/auth/controllers/auth_controller.dart`.
