import 'dart:async';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapView extends StatefulWidget {
  GoogleMapView({Key key}) : super(key: key);

  @override
  _GoogleMapViewState createState() => _GoogleMapViewState();
}

class _GoogleMapViewState extends State<GoogleMapView> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = HashSet<Marker>();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(15.506150, -88.026935),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _kGooglePlex,
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
    );
  }
}
