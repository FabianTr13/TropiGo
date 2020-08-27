import 'package:TropiGo/src/Modules/Tips/Bloc/TipsBloc.dart';
import 'package:TropiGo/src/Modules/Tips/Models/Tips.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TipsServise {
  final _fireStore = FirebaseFirestore.instance;

  Future<List<Tips>> getTips() async {
    List<Tips> tips = List<Tips>();
    await _fireStore.collection('tropitips').get().then(
      (value) {
        try {
          tips = value.docs.map((item) => new Tips(item.data())).toList();
          tipsBlocInstance.changeTips(tips);
        } catch (e) {}
      },
    );
    return tips;
  }
}
