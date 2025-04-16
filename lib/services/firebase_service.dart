// Importa la biblioteca de Firebase Core, que es necesaria para inicializar Firebase en la aplicación.
import 'package:firebase_core/firebase_core.dart';
// Importa las opciones de configuración de Firebase generadas automáticamente.
import '../config/firebase_options.dart';

// Clase que encapsula la inicialización de Firebase.
class FirebaseService {
  // Método estático para inicializar Firebase.
  static Future<void> initialize() async {
    // Inicializa Firebase utilizando las opciones específicas de la plataforma actual.
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}
