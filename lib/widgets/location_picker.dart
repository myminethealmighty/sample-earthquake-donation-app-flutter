// widgets/location_picker.dart
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class LocationPicker extends StatefulWidget {
  final Function(String) onLocationSelected;

  const LocationPicker({super.key, required this.onLocationSelected});

  @override
  State<LocationPicker> createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  final TextEditingController _locationController = TextEditingController();
  LatLng? _selectedLocation;

  void _openMapPicker() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Location'),
          content: SizedBox(
            width: double.maxFinite,
            height: 400,
            child: FlutterMap(
              options: MapOptions(
                center: LatLng(39.9334, 32.8597), // Center on Turkey
                zoom: 5.0,
                onTap: (tapPosition, point) {
                  setState(() {
                    _selectedLocation = point;
                  });
                },
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.app',
                ),
                if (_selectedLocation != null)
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: _selectedLocation!,
                        builder:
                            (ctx) => const Icon(
                              Icons.location_pin,
                              color: Colors.red,
                              size: 40,
                            ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (_selectedLocation != null) {
                  final locationName =
                      'Lat: ${_selectedLocation!.latitude.toStringAsFixed(4)}, Long: ${_selectedLocation!.longitude.toStringAsFixed(4)}';
                  _locationController.text = locationName;
                  widget.onLocationSelected(locationName);
                  Navigator.pop(context);
                }
              },
              child: const Text('Select'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _locationController,
      readOnly: true,
      decoration: InputDecoration(
        labelText: 'Location',
        border: const OutlineInputBorder(),
        prefixIcon: const Icon(Icons.location_on),
        suffixIcon: IconButton(
          icon: const Icon(Icons.map),
          onPressed: _openMapPicker,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select a location';
        }
        return null;
      },
    );
  }
}
