import 'dart:async';
import 'dart:typed_data';
import 'package:TropiGo/src/Modules/Shop/Bloc/ShopCylinderBloc.dart';
import 'package:TropiGo/src/Multimedia/Images.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:maps_launcher/maps_launcher.dart';

class ViewMapShop extends StatefulWidget {
  const ViewMapShop({Key key}) : super(key: key);

  @override
  _ViewMapShopState createState() => _ViewMapShopState();
}

class _ViewMapShopState extends State<ViewMapShop> {
  Location _locationTracker = Location();
  Marker marker;
  Circle circle;
  GoogleMapController _controller;

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: initialLocation,
      markers: Set.of((marker != null) ? [marker] : []),
      circles: Set.of((circle != null) ? [circle] : []),
      onMapCreated: (GoogleMapController controller) {
        _controller = controller;
      });

  static final CameraPosition initialLocation =
      CameraPosition(target: LatLng(15.506150, -88.026935), zoom: 14.4746);

  Future<Uint8List> getMarker() async {
    ByteData byteData = await DefaultAssetBundle.of(context).load(DotImg);
    return byteData.buffer.asUint8List();
  }

  void updateMarkerAndCircle(LocationData newLocalData, Uint8List imageData) {
    shopCylinderBlocInstance.changePosition(newLocalData);

    LatLng latlng = LatLng(newLocalData.latitude, newLocalData.longitude);
    this.setState(() {
      marker = Marker(
          markerId: MarkerId("home"),
          position: latlng,
          rotation: newLocalData.heading,
          draggable: false,
          zIndex: 2,
          flat: true,
          anchor: Offset(0.5, 0.5),
          icon: BitmapDescriptor.fromBytes(imageData),
          onTap: () {
            MapsLauncher.launchCoordinates(37.4220041, -122.0862462);
          });
      circle = Circle(
          circleId: CircleId("Home"),
          radius: 20,
          zIndex: 1,
          strokeColor: Colors.blue,
          strokeWidth: 1,
          center: latlng,
          fillColor: Colors.blue.withAlpha(70));
    });

    _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        bearing: 192.8334901395799,
        target: LatLng(newLocalData.latitude, newLocalData.longitude),
        tilt: 0,
        zoom: 18.00)));
  }

  void getCurrentLocation() async {
    try {
      Uint8List imageData = await getMarker();
      var location = await _locationTracker.getLocation();

      updateMarkerAndCircle(location, imageData);
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        showToast("Se necesita acceso al gps para continuar");
      }
    }
  }
}
