import 'dart:async';
import 'dart:collection';
import 'package:TropiGo/src/Modules/Shop/Widget/Granel/GoogleMap.dart';
import 'package:TropiGo/src/Services/GasVehicularService.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GasStoresScreen extends StatefulWidget {
  @override
  State<GasStoresScreen> createState() => GasStoreState();
}

class GasStoreState extends State<GasStoresScreen> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = HashSet<Marker>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMapView(),
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
