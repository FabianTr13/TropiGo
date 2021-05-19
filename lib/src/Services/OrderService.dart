import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Orderbloc implements Bloc {
  saveOrderId(String orderId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('orderId', orderId);
  }

  Future<String> getOrderId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String getOrderId = prefs.getString("orderId");
    return getOrderId;
  }

  saveCityId(String cityId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('cityId', cityId);
  }

  Future<String> getCityId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String getCityId = prefs.getString("cityId");
    return getCityId;
  }

  saveCityName(String cityName) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('cityName', cityName);
  }

  Future<String> getCityName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String getCityName = prefs.getString("cityName");
    return getCityName;
  }

  @override
  void dispose() {}
}

final orderBloc = Orderbloc();
