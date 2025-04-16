// Define una entidad que representa una ubicación.
class LocationEntity {
  // Identificador único de la ubicación.
  final String id;
  // Nombre de la ubicación.
  final String name;
  // Latitud de la ubicación.
  final double latitude;
  // Longitud de la ubicación.
  final double longitude;
  // Dirección opcional de la ubicación.
  final String? address;

  // Constructor de la clase `LocationEntity`.
  // Los campos `id`, `name`, `latitude` y `longitude` son obligatorios.
  // El campo `address` es opcional.
  LocationEntity({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    this.address,
  });
}
