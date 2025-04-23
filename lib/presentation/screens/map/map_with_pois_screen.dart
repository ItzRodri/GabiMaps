import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../domain/entities/location.dart';
import '../../providers/location_provider.dart';

class MapWithPoisScreen extends ConsumerStatefulWidget {
  const MapWithPoisScreen({super.key});

  @override
  _MapWithPoisScreenState createState() => _MapWithPoisScreenState();
}

class _MapWithPoisScreenState extends ConsumerState<MapWithPoisScreen> {
  GoogleMapController? _mapController;
  LatLng? _currentLocation;
  double _currentZoom = 17.0;

  final List<LatLng> _campusCoords = [
    LatLng(-17.772803, -63.198984),
    LatLng(-17.776430, -63.198903),
    LatLng(-17.777354, -63.198049),
    LatLng(-17.778274, -63.197524),
    LatLng(-17.778323, -63.196483),
    LatLng(-17.779093, -63.193923),
    LatLng(-17.775195, -63.192777),
    LatLng(-17.774840, -63.193088),
    LatLng(-17.774325, -63.193001),
    LatLng(-17.773947, -63.194258),
    LatLng(-17.773407, -63.194180),
    LatLng(-17.772803, -63.198983),
  ];

  Set<Polygon> get _campusPolygon => {
    Polygon(
      polygonId: const PolygonId('campus'),
      points: _campusCoords,
      strokeColor: Colors.blue,
      strokeWidth: 2,
      fillColor: Colors.blue.withOpacity(0.2),
    ),
  };

  Future<bool> _requestLocationPermission() async {
    PermissionStatus status = await Permission.location.request();
    return status.isGranted;
  }

  Future<void> _fetchCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );
      LatLng current = LatLng(position.latitude, position.longitude);
      setState(() {
        _currentLocation = current;
      });
      _mapController?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: current, zoom: 15),
        ),
      );
    } catch (e) {
      debugPrint('Error obteniendo ubicación actual: $e');
    }
  }

  Set<Marker> _crearMarcadoresPorCapa(List<LocationEntity> ubicaciones) {
    int capaActual;
    if (_currentZoom < 17) {
      capaActual = 1;
    } else if (_currentZoom < 19) {
      capaActual = 2;
    } else {
      capaActual = 3;
    }

    final filtradas = ubicaciones.where((loc) => loc.layer == capaActual);

    return filtradas.map((loc) {
      return Marker(
        markerId: MarkerId(loc.id),
        position: LatLng(loc.latitude, loc.longitude),
        infoWindow: InfoWindow(title: loc.name, snippet: loc.address ?? ''),
      );
    }).toSet();
  }

  @override
  void initState() {
    super.initState();
    _requestLocationPermission().then((granted) {
      if (granted) _fetchCurrentLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
    final locationsAsync = ref.watch(locationListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Mapa con ubicaciones')),
      body: locationsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data:
            (ubicaciones) => GoogleMap(
              initialCameraPosition: CameraPosition(
                target: _currentLocation ?? const LatLng(-17.7825, -63.1815),
                zoom: 15,
              ),
              minMaxZoomPreference: const MinMaxZoomPreference(15, 22.0),
              markers: _crearMarcadoresPorCapa(ubicaciones),
              polygons: _campusPolygon,
              onMapCreated: (controller) => _mapController = controller,
              myLocationEnabled: true,
              onCameraMove: (position) {
                setState(() {
                  _currentZoom = position.zoom;
                });
              },
              onTap: (_) {},
            ),
      ),
    );
  }
}
