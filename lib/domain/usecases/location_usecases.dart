// Importa la entidad `LocationEntity`, que representa una ubicación.
import '../entities/location.dart';
// Importa el repositorio `LocationRepository`, que define las operaciones relacionadas con ubicaciones.
import '../repositories/location_repository.dart';

// Caso de uso para obtener ubicaciones cercanas.
class GetNearbyLocations {
  // Repositorio que se utiliza para acceder a los datos de ubicaciones.
  final LocationRepository repository;

  // Constructor que recibe el repositorio como dependencia.
  GetNearbyLocations(this.repository);

  // Método que ejecuta el caso de uso.
  // Llama al método `getNearbyLocations` del repositorio con las coordenadas proporcionadas.
  Future<List<LocationEntity>> call(double latitude, double longitude) {
    return repository.getNearbyLocations(latitude, longitude);
  }
}

// Caso de uso para guardar una ubicación.
class SaveLocation {
  // Repositorio que se utiliza para guardar los datos de ubicaciones.
  final LocationRepository repository;

  // Constructor que recibe el repositorio como dependencia.
  SaveLocation(this.repository);

  // Método que ejecuta el caso de uso.
  // Llama al método `saveLocation` del repositorio con la ubicación proporcionada.
  Future<void> call(LocationEntity location) {
    return repository.saveLocation(location);
  }
}

// Clase que agrupa los casos de uso relacionados con ubicaciones.
class LocationUseCases {
  // Caso de uso para obtener ubicaciones cercanas.
  final GetNearbyLocations getNearbyLocations;
  // Caso de uso para guardar una ubicación.
  final SaveLocation saveLocation;

  // Constructor que inicializa los casos de uso.
  LocationUseCases({
    required this.getNearbyLocations,
    required this.saveLocation,
  });
}
