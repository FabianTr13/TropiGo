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
          value.docs.forEach(
            (element) {
              var tip = Tips(
                title: element.data()['titulo'],
                description: element.data()['descripcion'],
              );
              tips.add(tip);
              tips.add(
                new Tips(
                  title: "sss",
                  description: element.data()['descripcion'],
                ),
              );
            },
          );
          tipsBlocInstance.changeTips(tips);
        } catch (e) {}
      },
    );
    return tips;
  }
}
