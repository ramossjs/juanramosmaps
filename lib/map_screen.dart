import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static const _defaultCenter = LatLng(28.6139, 77.2090);
  static const _defaultZoom = 13.0;

  final MapController _mapController = MapController();
  LatLng _center = _defaultCenter;
  bool _isLocating = false;

  Future<void> _getCurrentLocation() async {
    if (_isLocating) {
      return;
    }

    setState(() {
      _isLocating = true;
    });

    try {
      if (!await Geolocator.isLocationServiceEnabled()) {
        _showMessage('Los servicios de ubicación están desactivados.');
        return;
      }

      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied) {
        _showMessage('El permiso de ubicación fue denegado.');
        return;
      }

      if (permission == LocationPermission.deniedForever) {
        _showMessage(
          'El permiso está denegado permanentemente. Actívalo en Ajustes.',
        );
        return;
      }

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      final location = LatLng(position.latitude, position.longitude);

      if (!mounted) {
        return;
      }

      setState(() {
        _center = location;
      });
      _mapController.move(location, _defaultZoom);
    } on LocationServiceDisabledException {
      _showMessage('Los servicios de ubicación están desactivados.');
    } on PermissionDefinitionsNotFoundException {
      _showMessage('La app no tiene configurado el permiso de ubicación.');
    } catch (error) {
      _showMessage('No se pudo obtener tu ubicación: $error');
    } finally {
      if (mounted) {
        setState(() {
          _isLocating = false;
        });
      }
    }
  }

  void _showMessage(String message) {
    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OpenStreetMap'),
        backgroundColor: const Color(0xFF2F8D46),
        foregroundColor: Colors.white,
      ),
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          initialCenter: _center,
          initialZoom: _defaultZoom,
          interactionOptions: const InteractionOptions(
            flags: InteractiveFlag.all,
          ),
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.maps_and_geolocation',
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: _center,
                width: 52,
                height: 52,
                child: const Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 46,
                ),
              ),
            ],
          ),
          RichAttributionWidget(
            attributions: [
              TextSourceAttribution('OpenStreetMap contributors', onTap: () {}),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _isLocating ? null : _getCurrentLocation,
        tooltip: 'Obtener ubicación',
        backgroundColor: const Color(0xFF2F8D46),
        foregroundColor: Colors.white,
        child: _isLocating
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2.5,
                ),
              )
            : const Icon(Icons.my_location),
      ),
    );
  }
}
