import 'package:TropiGo/src/Modules/Tips/Bloc/TipsBloc.dart';
import 'package:TropiGo/src/Modules/Tips/Models/Tips.dart';
import 'package:TropiGo/src/Multimedia/Images.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UtilsService {
  final _fireStore = FirebaseStorage.instance.ref();

  Future<String> getImageStore(String imageName) async {
    final ref = _fireStore.child(imageName);
    var url = await ref.getDownloadURL();
    return url.toString() ?? LogoImg;
  }
}
