import 'dart:async';
import 'dart:collection';
import 'package:TropiGo/src/Modules/Shop/Bloc/ModelsBloc/GpsStores.dart';
import 'package:TropiGo/src/Services/GasVehicularService.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_launcher/maps_launcher.dart';

class GoogleMapView extends StatefulWidget {
  const GoogleMapView({Key key}) : super(key: key);

  @override
  _GoogleMapViewState createState() => _GoogleMapViewState();
}

class _GoogleMapViewState extends State<GoogleMapView> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = HashSet<Marker>();

  callbackFuntion() async {
    var stores = await GasVehicularService().getStores();
    stores.asMap().forEach((index, GpsStores element) {
      setState(() {
        _markers.add(Marker(
            markerId: MarkerId(index.toString()),
            position: LatLng(element.lat, element.log),
            infoWindow: InfoWindow(title: element.titulo),
            onTap: () {
              MapsLauncher.launchCoordinates(
                  element.lat, element.log, 'Tropigas');
            }));
      });
    });
  }

  static final CameraPosition _kGooglePlex =
      CameraPosition(target: LatLng(15.506150, -88.026935), zoom: 14.4746);

  @override
  Widget build(BuildContext context) => Container(
      child: GoogleMap(
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          mapType: MapType.normal,
          initialCameraPosition: _kGooglePlex,
          markers: _markers,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
            callbackFuntion();
          }));
}
