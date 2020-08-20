import 'package:TropiGo/src/Modules/Tips/Bloc/TipsBloc.dart';
import 'package:TropiGo/src/Modules/Tips/Models/Tips.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TipsServise {
  final _fireStore = Firestore.instance;

  Future<Tips> getTips() async {
    Tips tips;
    await _fireStore
        .collection('tropitips')
        .document("6RAbSny0o7bqKFBtpQG6")
        .get()
        .then(
      (value) {
        try {
          tips = Tips(
            description: value.data['descripcion'],
            title: value.data['titulo'],
          );
          tipsBlocInstance.changeTips(tips);
        } catch (e) {}
      },
    );
    return tips;
  }
}
