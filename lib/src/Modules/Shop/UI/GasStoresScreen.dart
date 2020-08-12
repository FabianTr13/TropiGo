import 'dart:async';
import 'dart:collection';
import 'package:TropiGo/src/Modules/Shop/UI/HomeShop.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GasStoresScreen extends StatefulWidget {
  @override
  State<GasStoresScreen> createState() => GasStoreState();
}

class GasStoreState extends State<GasStoresScreen> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = HashSet<Marker>();

  static final CameraPosition _SanPedroSulaPoint = CameraPosition(
    target: LatLng(15.506150, -88.026935),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _SanPedroSulaPoint,
        markers: _markers,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);

          setState(() {
            _markers.add(Marker(
              markerId: MarkerId("0"),
              position: LatLng(15.506150, -88.026935),
              infoWindow: InfoWindow(
                title: "San Francsico",
                snippet: "An Interesting city",
              ),
            ));
          });
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pop(context),
        label: Text('Back Inicio'),
        icon: Icon(Icons.arrow_back),
        backgroundColor: Colors.orange,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
