import 'package:TropiGo/src/Modules/Shop/Widget/Granel/GoogleMap.dart';
import 'package:TropiGo/src/Multimedia/Images.dart';
import 'package:TropiGo/src/Widgets/AppBar/NavBar.dart';
import 'package:TropiGo/src/Widgets/ButtonIconCircle.dart';
import 'package:flutter/material.dart';

class GasStoresScreen extends StatefulWidget {
  @override
  State<GasStoresScreen> createState() => GasStoreState();
}

class GasStoreState extends State<GasStoresScreen> {
  // Completer<GoogleMapController> _controller = Completer();
  // Set<Marker> _markers = HashSet<Marker>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: navBar(
          withActions: false,
          automaticallyImplyLeading: false,
          logo: GasVehicularImg,
          sizeLogo: 100),
      body: GoogleMapView(),
      bottomNavigationBar: Container(
          height: 80,
          child: Center(
              child: ButtonIconCircle(
                  callback: () => Navigator.pop(context),
                  backgroundColor: Colors.red,
                  icon: Icons.arrow_back))),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
}
