import 'package:TropiGo/src/Modules/Shop/Bloc/GranelBloc.dart';
import 'package:http/http.dart' as http;

class GranelService {
  Future<void> sendEmail() async {
    String url = "http://apitropigas.hol.es/app/sendmail.php";

    var body = granelBlocInstance.getGranel().getGranelMail();

    Map<String, String> headers = {
      "Content-Type": "application/x-www-form-urlencoded"
    };
    print(body);
    http.post(url, headers: headers, body: body).then((response) {
      // print(json.decode(response.body));
    });
  }
}
