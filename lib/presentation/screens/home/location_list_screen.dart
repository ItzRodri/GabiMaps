// location_list_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/location.dart';
import '../../providers/location_provider.dart';

class LocationListScreen extends ConsumerWidget {
  const LocationListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationsAsync = ref.watch(locationListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Ubicaciones Guardadas')),
      body: locationsAsync.when(
        data:
            (locations) => ListView.builder(
              itemCount: locations.length,
              itemBuilder: (context, index) {
                final loc = locations[index];
                return ListTile(
                  title: Text(loc.name),
                  subtitle: Text(loc.address ?? 'Dirección no disponible'),
                  trailing: Text('${loc.latitude}, ${loc.longitude}'),
                  onTap: () {
                    // Puedes enviar datos al screen de detalles si lo deseas
                    Navigator.pushNamed(
                      context,
                      '/locationDetails',
                      arguments: loc,
                    );
                  },
                );
              },
            ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
