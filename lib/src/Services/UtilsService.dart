import 'package:TropiGo/src/Multimedia/Images.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UtilsService {
  final _fireStore = FirebaseStorage.instance.ref();

  Future<String> getImageStore(String imageName) async {
    final ref = _fireStore.child(imageName);
    final url = await ref.getDownloadURL();
    return url?.toString() ?? LogoImg;
  }

  saveAddress(String address) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('address', address);
  }

  Future<String> getAddress() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String getAddress = prefs.getString("address");
    return getAddress;
  }

  saveOrderId(String orderId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('orderId', orderId);
  }

  Future<String> getOrderId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String getOrderId = prefs.getString("orderId");
    return getOrderId;
  }
}
