import 'dart:async';
import 'package:flutter/material.dart';
import 'package:foodtek_app/core/constants/color.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../core/constants/svg.dart';
import 'package:foodtek_app/core/utils/converter.dart';
import 'package:foodtek_app/feature/cart/domain/entity/cart_entity.dart';
import '../../../checkout/presentation/view/checkout_screen.dart';

class TrackScreen extends StatefulWidget {
  final Function(LatLng?, String) onLocationSelected;
  final LatLng? initialLocation;
  final List<CartItem>? cartItems;

  const TrackScreen({
    super.key,
    required this.onLocationSelected,
    this.initialLocation,
    this.cartItems,
  });

  @override
  State<TrackScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<TrackScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  late BitmapDescriptor point;
  LatLng _selectedPosition = const LatLng(24.7136, 46.6753); // Default fallback
  Set<Marker> _markers = {};
  bool _isMapLoading = true;
  bool _locationPermissionGranted = false;
  String _selectedAddress = 'Select a location';

  @override
  void initState() {
    super.initState();
    _initializeMap();
  }

  Future<void> _initializeMap() async {
    try {
      await _requestLocationPermission();
      await getIcon();

      if (widget.initialLocation != null) {
        _selectedPosition = widget.initialLocation!;
        _updateMarker(_selectedPosition, 'Initial Location');
      }

      setState(() {
        _isMapLoading = false;
      });
    } catch (e) {
      print('MapScreen: Failed to initialize map. Error: $e');
      setState(() {
        _isMapLoading = false;
      });
    }
  }

  Future<void> _requestLocationPermission() async {
    final status = await Permission.locationWhenInUse.request();
    if (status.isGranted) {
      print('MapScreen: Location permission granted');
      setState(() {
        _locationPermissionGranted = true;
      });
    } else {
      print('MapScreen: Location permission denied');
      setState(() {
        _locationPermissionGranted = false;
      });
    }
  }

  Future<void> getIcon() async {
    try {
      point = await Converter.bitmapDescriptorFromSvgAsset(SVGs.arrowDown); // Fixed typo
      print('MapScreen: Icon loaded successfully');
    } catch (e) {
      print('MapScreen: Failed to load icon, using default marker. Error: $e');
      point = BitmapDescriptor.defaultMarker;
    }
  }

  void _updateMarker(LatLng position, String address) {
    setState(() {
      _selectedPosition = position;
      _selectedAddress = address;
      _markers = {
        Marker(
          markerId: const MarkerId('selected_location'),
          position: position,
          icon: point,
          infoWindow: InfoWindow(title: 'Selected Location', snippet: address),
        ),
      };
    });
  }

  String _generateLocationUrl(LatLng latLng) {
    return "https://www.google.com/maps?q=${latLng.latitude},${latLng.longitude}";
  }

  void _showSnackBar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isMapLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: widget.initialLocation ?? _selectedPosition,
                zoom: 10.0,
              ),
              markers: _markers,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
                print('MapScreen: Google Map created successfully');
              },
              myLocationEnabled: _locationPermissionGranted,
              myLocationButtonEnabled: _locationPermissionGranted,
              zoomControlsEnabled: false,
              onTap: (LatLng pos) {
                print('MapScreen: Tapped at Lat=${pos.latitude}, Lng=${pos.longitude}');
                _updateMarker(pos, 'Custom Location');
              },
            ),
          ),
          Positioned(
            left: 22,
            top: 72,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_back, color: Colors.black, size: 18),
              ),
            ),
          ),
          Positioned(
            left: 24,
            right: 24,
            bottom: 40,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.location_pin, color: COLORs.blue1, size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _selectedAddress,
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Text(
                      'Lat: ${_selectedPosition.latitude.toStringAsFixed(6)}, '
                          'Lng: ${_selectedPosition.longitude.toStringAsFixed(6)}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () {
                      if (_markers.isNotEmpty) {
                        final selectedLatLng = _selectedPosition;
                        final selectedLocationUrl = _generateLocationUrl(selectedLatLng);
                        print('MapScreen: Set Location - Lat=${selectedLatLng.latitude}, Lng=${selectedLatLng.longitude}');

                        // Call the callback and update MainScreen
                        widget.onLocationSelected(selectedLatLng, selectedLocationUrl);
                      } else {
                        print('MapScreen: No location selected');
                        _showSnackBar('Please select a location');
                      }
                    },
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: COLORs.blue1,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 2),
                          BoxShadow(color: COLORs.blue1, spreadRadius: 1),
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          "Set Location",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}