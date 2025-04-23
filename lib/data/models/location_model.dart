import '../../domain/entities/location.dart';

class LocationModel extends LocationEntity {
  LocationModel({
    required super.id,
    required super.name,
    required super.latitude,
    required super.longitude,
    super.address,
    required super.layer,
  });

  factory LocationModel.fromMap(Map<String, dynamic> map) {
    return LocationModel(
      id: map['id'],
      name: map['name'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      address: map['address'],
      layer: map['layer'], //capa
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
      'layer': layer,
    };
  }
}
