import 'package:TropiGo/src/Modules/Shop/Bloc/ModelsBloc/GpsStores.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GasVehicularService {
  final _fireStore = Firestore.instance;

  Future<List<GpsStores>> getStores() async {
    List<GpsStores> stores = [];
    var documents = await _fireStore.collection('gasvehicular').getDocuments();
    documents.documents.forEach((element) {
      stores.add(GpsStores(
        lat: double.parse(element.data['lat']),
        log: double.parse(element.data['log']),
        titulo: element.data['titulo'],
      ));
    });
    return stores;
  }
}
