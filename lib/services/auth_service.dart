// Importa la biblioteca de Firebase Authentication para manejar la autenticación de usuarios.
import 'package:firebase_auth/firebase_auth.dart';
// Importa la biblioteca de Google Sign-In para manejar la autenticación con Google.
import 'package:google_sign_in/google_sign_in.dart';

// Clase que encapsula los métodos de autenticación.
class AuthService {
  // Instancia de FirebaseAuth para interactuar con los servicios de autenticación de Firebase.
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // 🔹 Obtener el usuario actual
  // Propiedad que devuelve el usuario actualmente autenticado, si existe.
  User? get currentUser => _auth.currentUser;

  // 🔹 Registro con email y contraseña
  // Método para registrar un nuevo usuario utilizando un correo electrónico y una contraseña.
  Future<User?> registerWithEmail(String email, String password) async {
    try {
      // Crea un nuevo usuario en Firebase con el email y contraseña proporcionados.
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      // Devuelve el usuario registrado.
      return userCredential.user;
    } catch (e) {
      // Si ocurre un error, lo imprime en la consola y devuelve null.
      print('Error en registro: $e');
      return null;
    }
  }

  // 🔹 Inicio de sesión con email y contraseña
  // Método para iniciar sesión con un correo electrónico y una contraseña.
  Future<User?> loginWithEmail(String email, String password) async {
    try {
      // Inicia sesión en Firebase con el email y contraseña proporcionados.
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Devuelve el usuario autenticado.
      return userCredential.user;
    } catch (e) {
      // Si ocurre un error, lo imprime en la consola y devuelve null.
      print('Error en login: $e');
      return null;
    }
  }

  // 🔹 Inicio de sesión con Google
  // Método para iniciar sesión utilizando una cuenta de Google.
  Future<User?> signInWithGoogle() async {
    try {
      // Muestra la ventana de inicio de sesión de Google al usuario.
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      // Si el usuario cancela el inicio de sesión, devuelve null.
      if (googleUser == null) return null;

      // Obtiene las credenciales de autenticación de Google.
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      // Crea un objeto de credenciales de Firebase a partir de las credenciales de Google.
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Inicia sesión en Firebase con las credenciales de Google.
      UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );
      // Devuelve el usuario autenticado.
      return userCredential.user;
    } catch (e) {
      // Si ocurre un error, lo imprime en la consola y devuelve null.
      print('Error en Google Sign-In: $e');
      return null;
    }
  }

  // 🔹 Cerrar sesión
  // Método para cerrar sesión del usuario actual.
  Future<void> signOut() async {
    // Cierra sesión en Firebase.
    await _auth.signOut();
    // Cierra sesión en Google.
    await GoogleSignIn().signOut();
  }
}
