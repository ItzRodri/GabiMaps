// Importa los paquetes necesarios para la aplicación.
import 'package:flutter/material.dart'; // Biblioteca principal de Flutter para construir la interfaz de usuario.
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Biblioteca para la gestión del estado con Riverpod.
import 'package:gabimaps/presentation/screens/notifications/error_screen.dart'; // Pantalla de error personalizada.
import 'services/firebase_service.dart'; // Servicio para inicializar Firebase.
import 'config/app_routes.dart'; // Configuración de las rutas de la aplicación.
import 'config/theme.dart'; // Configuración de los temas (light y dark).

// Función principal de la aplicación.
void main() async {
  // Asegura que los widgets de Flutter estén inicializados antes de ejecutar cualquier código.
  WidgetsFlutterBinding.ensureInitialized();
  // Inicializa Firebase utilizando el servicio definido en `firebase_service.dart`.
  await FirebaseService.initialize();

  // Ejecuta la aplicación y envuelve la raíz con `ProviderScope` para habilitar Riverpod.
  runApp(const ProviderScope(child: MyApp())); // 🔥 Riverpod envuelve la app
}

// Clase principal de la aplicación.
class MyApp extends StatelessWidget {
  const MyApp({super.key}); // Constructor de la clase.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:
          false, // Oculta la etiqueta de "debug" en la esquina superior derecha.
      title: 'Material App', // Título de la aplicación.
      initialRoute:
          AppRoutes
              .splash, // Ruta inicial de la aplicación (pantalla de splash).
      onGenerateRoute: (settings) {
        // Genera rutas dinámicamente según el nombre de la ruta solicitada.
        if (AppRoutes.routes.containsKey(settings.name)) {
          // Si la ruta existe en `AppRoutes`, devuelve la pantalla correspondiente.
          return MaterialPageRoute(builder: AppRoutes.routes[settings.name]!);
        } else {
          // Si la ruta no existe, muestra la pantalla de error.
          return MaterialPageRoute(builder: (context) => ErrorScreen());
        }
      },
      theme: lightTheme, // Tema claro de la aplicación.
      darkTheme: darkTheme, // Tema oscuro de la aplicación.
      themeMode:
          ThemeMode
              .system, // Cambia entre light y dark según la configuración del sistema.
    );
  }
}
