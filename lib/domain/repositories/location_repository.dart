// Importa la entidad `LocationEntity`, que representa una ubicación.
import '../entities/location.dart';

// Define un repositorio abstracto para manejar las operaciones relacionadas con ubicaciones.
abstract class LocationRepository {
  // Método abstracto para obtener una lista de ubicaciones cercanas.
  // Recibe como parámetros la latitud y longitud actuales.
  Future<List<LocationEntity>> getNearbyLocations(
    double latitude, // Latitud de la ubicación actual.
    double longitude, // Longitud de la ubicación actual.
  );

  // Método abstracto para guardar una ubicación.
  // Recibe como parámetro una instancia de `LocationEntity`.
  Future<void> saveLocation(LocationEntity location);
}
