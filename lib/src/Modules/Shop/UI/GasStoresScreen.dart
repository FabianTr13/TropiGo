import 'dart:async';
import 'dart:collection';
import 'package:TropiGo/src/Modules/Shop/Widget/AppBar/NavBar.dart';
import 'package:TropiGo/src/Modules/Shop/Widget/Granel/GoogleMap.dart';
import 'package:TropiGo/src/Multimedia/Images.dart';
import 'package:TropiGo/src/Services/GasVehicularService.dart';
import 'package:TropiGo/src/Widgets/ButtonRoundBorder.dart';
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
      appBar: NavBar(
        withActions: false,
        automaticallyImplyLeading: false,
        logo: GasVehicularImg,
        sizeLogo: 100,
      ),
      body: GoogleMapView(),
      bottomNavigationBar: Container(
        height: 80,
        child: Center(
          child: ButtonRoundBorder(
            text: "Back Inicio",
            callback: () => Navigator.pop(context),
            backgroundColor: Colors.red,
            width: 2,
            fontSize: 22,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
