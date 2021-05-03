import 'package:TropiGo/src/Modules/Contact/Models/Contact.dart';
import 'package:firebase_database/firebase_database.dart';

class ContactService {
  final databaseReference =
      FirebaseDatabase.instance.reference().child("ajustes");

  Future<Contact> getSetting() async {
    final data = await databaseReference.once();

    if (data.value != null) {
      return Contact(
          tel: 'tel:' + data.value["tel"].toString(),
          email: 'mailto:' + data.value["email"].toString(),
          chat: 'https://wa.me/' + data.value["chat"].toString());
    } else {
      return Contact();
    }
  }
}
