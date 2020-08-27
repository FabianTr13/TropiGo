import 'package:TropiGo/src/Modules/Shop/Bloc/ModelsBloc/GpsStores.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GasVehicularService {
  final _fireStore = FirebaseFirestore.instance;

  Future<List<GpsStores>> getStores() async {
    var documents = await _fireStore.collection('gasvehicular').get();

    List<GpsStores> stores = documents.docs
        .map<GpsStores>((item) => new GpsStores(item.data()))
        .toList();

    return stores;
  }
}
