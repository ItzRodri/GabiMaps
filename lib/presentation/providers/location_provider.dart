import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/usecases/location_usecases.dart';
import '../../data/repositories/location_repository_impl.dart';
import '../../domain/entities/location.dart';

// Proveedor de Firestore
final firebaseFirestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

// Proveedor del repositorio (ahora recibe Firestore correctamente)
final locationRepositoryProvider = Provider<LocationRepositoryImpl>((ref) {
  final firestore = ref.watch(firebaseFirestoreProvider);
  return LocationRepositoryImpl(firestore); // 🔹 **Ahora pasamos Firestore**
});

// Proveedores de casos de uso
final saveLocationProvider = Provider<SaveLocation>((ref) {
  final repository = ref.watch(locationRepositoryProvider);
  return SaveLocation(repository);
});

final getNearbyLocationsProvider = Provider<GetNearbyLocations>((ref) {
  final repository = ref.watch(locationRepositoryProvider);
  return GetNearbyLocations(repository);
});

final locationListProvider = FutureProvider<List<LocationEntity>>((ref) async {
  final getNearbyLocations = ref.watch(getNearbyLocationsProvider);
  // Por ahora no usamos lat/lng porque el repositorio no los filtra
  return await getNearbyLocations(0, 0);
});
