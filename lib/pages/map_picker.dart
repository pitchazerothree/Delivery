import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPicker extends StatefulWidget {
  final Function(String) onLocationSelected;

  MapPicker({required this.onLocationSelected});

  @override
  _MapPickerState createState() => _MapPickerState();
}

class _MapPickerState extends State<MapPicker> {
  late GoogleMapController _controller;
  LatLng _selectedLocation =
      LatLng(13.7563, 100.5018); // Default location (Bangkok)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Location'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _selectedLocation,
          zoom: 14.0,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
        },
        onTap: (LatLng location) {
          setState(() {
            _selectedLocation = location;
          });
          // Update marker
          _controller.animateCamera(CameraUpdate.newLatLng(location));
        },
        markers: {
          Marker(
            markerId: MarkerId('selectedLocation'),
            position: _selectedLocation,
          ),
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          widget.onLocationSelected(
              'Lat: ${_selectedLocation.latitude}, Long: ${_selectedLocation.longitude}');
          Navigator.of(context).pop();
        },
        child: Icon(Icons.check),
      ),
    );
  }
}
