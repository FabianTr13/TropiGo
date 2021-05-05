import 'package:TropiGo/src/Modules/Auth/Bloc/SignupBloc.dart';
import 'package:TropiGo/src/Modules/Auth/Models/City.dart';
import 'package:TropiGo/src/Modules/Home/UI/HomeMenu.dart';
import 'package:TropiGo/src/Multimedia/Images.dart';
import 'package:TropiGo/src/Multimedia/TropiColors.dart';
import 'package:TropiGo/src/Services/AuthService.dart';
import 'package:TropiGo/src/Services/ShopService.dart';
import 'package:TropiGo/src/Utils/BoxGradient.dart';
import 'package:TropiGo/src/Utils/CalendarPicker.dart';
import 'package:TropiGo/src/Widgets/ButtonIconCircleSubmit.dart';
import 'package:TropiGo/src/Widgets/ImageHeader.dart';
import 'package:TropiGo/src/Widgets/InputTextbox.dart';
import 'package:TropiGo/src/Widgets/RadialButton.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<SignupScreen> {
  bool isLoading = false;
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _phoneFocusNode = FocusNode();
  final FocusNode _colonyFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _repasswordFocusNode = FocusNode();
  TextEditingController dateCtl = TextEditingController();
  String cityId = "";
  String cityName = "";

  @override
  void initState() {
    super.initState();
    cityId = "";
    cityName = "Elige tu ciudad";
  }

  @override
  void dispose() {
    super.dispose();
    _emailFocusNode.dispose();
    _nameFocusNode.dispose();
    _phoneFocusNode.dispose();
    _passwordFocusNode.dispose();
    _colonyFocusNode.dispose();
    _repasswordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      Container(height: MediaQuery.of(context).size.height, child: signup());

  Future<void> registerUser() async {
    setState(() {
      isLoading = true;
    });

    var authRequestDo = await AuthService().createUser();

    setState(() {
      isLoading = false;
    });

    if (authRequestDo.success) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => HomeMenu()),
          (Route<dynamic> route) => false);
    } else {
      showToast(authRequestDo.errorMessage, backgroundColor: Colors.red);
    }
  }

  _changeSex(String value) {
    signupBlocInstance.changeSexo(value);
  }

  _changeBirthDay() async {
    var date = await CalendarPicker().showPicker(context);
    if (date != null) {
      dateCtl.text = formatDate(date, [dd, ' ', MM, ' ', yyyy]);
      signupBlocInstance.changeBirthDate(dateCtl.text);
      FocusScope.of(context).requestFocus(_passwordFocusNode);
    }
  }

  Widget signup() => Scaffold(
      body: ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Container(
              decoration: boxGradient(),
              child: ListView(children: [
                ImageHeader(
                    image: ProfileImg,
                    title: "Crear Cuenta",
                    underLine: true,
                    size: 80),
                InputTextbox(
                    title: "Correo",
                    hintText: '',
                    keyboardType: TextInputType.emailAddress,
                    stream: signupBlocInstance.email,
                    onChange: signupBlocInstance.changeEmail,
                    focusNode: _emailFocusNode,
                    nextFocus: _nameFocusNode,
                    colorLines: Colors.white),
                InputTextbox(
                    title: "Nombre",
                    hintText: '',
                    stream: signupBlocInstance.name,
                    onChange: signupBlocInstance.changeName,
                    focusNode: _nameFocusNode,
                    nextFocus: _phoneFocusNode,
                    colorLines: Colors.white),
                InputTextbox(
                    title: "Teléfono",
                    hintText: '',
                    keyboardType: TextInputType.number,
                    stream: signupBlocInstance.phoneNumber,
                    onChange: signupBlocInstance.changePhoneNumber,
                    focusNode: _phoneFocusNode,
                    nextFocus: _passwordFocusNode,
                    colorLines: Colors.white),
                Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Text("Sexo",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: TropiColors.white))),
                RadialButton(
                    stream: signupBlocInstance.sexo,
                    title: "Masculino",
                    value: "m",
                    callback: _changeSex),
                RadialButton(
                    stream: signupBlocInstance.sexo,
                    title: "Femenino",
                    value: "f",
                    callback: _changeSex),
                Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Text("Ciudad",
                        style:
                            TextStyle(fontSize: 18, color: TropiColors.white))),
                Container(
                    margin: EdgeInsets.only(left: 20, bottom: 10, top: 15),
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(cityName ?? "",
                                  style: TextStyle(
                                      fontSize: 16, color: TropiColors.white)),
                              Icon(Icons.arrow_drop_down)
                            ]),
                        onTap: () => {_buildingCitiesModal(context)})),
                InputTextbox(
                    title: "Colonia",
                    hintText: '',
                    stream: signupBlocInstance.colony,
                    onChange: signupBlocInstance.changeColony,
                    focusNode: _colonyFocusNode,
                    nextFocus: _repasswordFocusNode,
                    colorLines: Colors.white),
                InputTextbox(
                    controller: dateCtl,
                    title: "Fecha de nacimiento",
                    hintText: '',
                    stream: signupBlocInstance.birthDay,
                    onChange: signupBlocInstance.changeBirthDate,
                    colorLines: Colors.white,
                    onTap: _changeBirthDay,
                    allowEdit: true),
                InputTextbox(
                    title: "Contraseña",
                    hintText: '',
                    obscureText: true,
                    stream: signupBlocInstance.password,
                    onChange: signupBlocInstance.changePassword,
                    focusNode: _passwordFocusNode,
                    nextFocus: _repasswordFocusNode,
                    colorLines: Colors.white),
                InputTextbox(
                    title: "Confirmar Contraseña",
                    hintText: '',
                    obscureText: true,
                    stream: signupBlocInstance.rePassword,
                    onChange: signupBlocInstance.changeRePassword,
                    focusNode: _repasswordFocusNode,
                    colorLines: Colors.white),
                SizedBox(height: 25),
                Center(
                    child: ButtonIconCircleSubmit(
                        nullText: "Rellene todos los campos",
                        callback: registerUser,
                        stream: signupBlocInstance.submitValidSignup))
              ]))));

  void _buildingCitiesModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) => Container(
            color: Color(0xFF737373),
            child: Container(
              height: 600,
              child: buildCityModal(),
              decoration: boxGradient(),
            )));
  }

  Widget buildCityModal() =>
      SingleChildScrollView(child: Container(child: getCities()));

  FutureBuilder<List<City>> getCities() => FutureBuilder<List<City>>(
      future: ShopService().getCities(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }

        final List<City> cities = snapshot.data;
        if (cities.length > 0) {
          return _buildCities(cities);
        } else {
          return Container();
        }
      });

  Widget _buildCities(List<City> cities) => ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: cities.length,
      itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            Navigator.pop(context);
            setState(() {
              cityId = cities[index].codCiudad;
              cityName = cities[index].nombre;
              ShopService().saveCityId(cities[index].codCiudad);
              ShopService().saveCityName(cities[index].nombre);
            });
          },
          child: _buildCityButton(cities[index])));

  Widget _buildCityButton(City city) => Container(
      alignment: Alignment.center,
      height: 45,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
      padding: EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Text(city.nombre ?? "",
          style: TextStyle(color: Colors.black, fontSize: 17)));
}
