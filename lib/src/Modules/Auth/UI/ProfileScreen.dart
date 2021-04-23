import 'package:TropiGo/src/Modules/Auth/Bloc/AuthBloc.dart';
import 'package:TropiGo/src/Modules/Auth/Bloc/SignupBloc.dart';
import 'package:TropiGo/src/Modules/Auth/Models/City.dart';
import 'package:TropiGo/src/Multimedia/Images.dart';
import 'package:TropiGo/src/Multimedia/TropiColors.dart';
import 'package:TropiGo/src/Services/AuthService.dart';
import 'package:TropiGo/src/Services/ShopService.dart';
import 'package:TropiGo/src/Utils/BoxGradient.dart';
import 'package:TropiGo/src/Utils/CalendarPicker.dart';
import 'package:TropiGo/src/Widgets/AppBar/NavBar.dart';
import 'package:TropiGo/src/Widgets/ButtonLargeSubmit.dart';
import 'package:TropiGo/src/Widgets/ImageHeader.dart';
import 'package:TropiGo/src/Widgets/InputTextbox.dart';
import 'package:TropiGo/src/Widgets/RadialButton.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class ProfileScreen extends StatefulWidget {
  final String getCity;
  const ProfileScreen({Key key, @required this.getCity}) : super(key: key);
  @override
  _ProfileScreenState createState() => new _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isLoading = false;
  FocusNode _focusNameNode;
  FocusNode _focusPassNode;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController dateCtl = TextEditingController();
  String cityId = "";
  String cityName;

  @override
  void initState() {
    super.initState();
    _focusNameNode = FocusNode();
    _getCurrent();
    cityName = widget.getCity ?? "Elige tu ciudad";
  }

  @override
  void dispose() {
    super.dispose();
    _focusNameNode.dispose();
  }

  @override
  Widget build(BuildContext context) => Container(child: _updateProfile());

  Future<void> _getCurrent() async {
    setState(() {
      isLoading = true;
    });

    var user = await AuthService().getCurrentUser();
    setState(() {
      isLoading = false;
    });

    if (user.uid != null) {
      signupBlocInstance.changeUId(user.uid);
      signupBlocInstance.changNewName(user.name);
      signupBlocInstance.changeColony(user.colony);
      signupBlocInstance.changeNewPhoneNumber(user.phoneNumber);
      signupBlocInstance.changeNewBirthDay(user.birthDate);
      signupBlocInstance.changeNewSex(user.sexo);
      signupBlocInstance.changeEmail(user.email);
      _nameController.text = user.name;
      _phoneController.text = user.phoneNumber;
      dateCtl.text = user.birthDate;

      setState(() {
        cityName = user.cityName ?? "Elige tu ciudad";
      });
    } else {
      showToast("Ocurrio un error al obtener perfil");
      Navigator.pop(context);
    }
  }

  _doSave() async {
    setState(() {
      isLoading = true;
    });

    AuthService().updateUser();

    setState(() {
      isLoading = false;
    });

    showToast("Datos Actualizados", backgroundColor: Colors.blue);
    Navigator.pop(context);
  }

  _changeSex(String value) {
    signupBlocInstance.changeNewSex(value);
  }

  _changeBirthDay() async {
    var date = await CalendarPicker().showPicker(context);
    if (date != null) {
      dateCtl.text = formatDate(date, [dd, ' ', MM, ' ', yyyy]);
      signupBlocInstance.changeNewBirthDay(dateCtl.text);
    }
  }

  Widget _updateProfile() => Scaffold(
      appBar: navBar(withActions: false, automaticallyImplyLeading: false),
      body: ModalProgressHUD(
          inAsyncCall: isLoading,
          opacity: 0.5,
          color: Colors.orangeAccent,
          progressIndicator: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.orange)),
          child: Container(
              decoration: boxGradient(),
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                  child: Form(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                    ImageHeader(
                        title: "Mi Perfil",
                        image: ProfileImg,
                        underLine: true,
                        size: 80),
                    InputTextbox(
                        title: "Nombre",
                        hintText: '',
                        focusNode: _focusNameNode,
                        onChange: signupBlocInstance.changNewName,
                        stream: signupBlocInstance.newName,
                        nextFocus: _focusPassNode,
                        controller: _nameController,
                        colorLines: Colors.white),
                    InputTextbox(
                        title: "Teléfono",
                        hintText: '',
                        keyboardType: TextInputType.number,
                        onChange: signupBlocInstance.changeNewPhoneNumber,
                        stream: signupBlocInstance.newPhoneNumber,
                        focusNode: _focusPassNode,
                        controller: _phoneController,
                        colorLines: Colors.white),
                    Container(
                        alignment: Alignment.bottomLeft,
                        margin: EdgeInsets.only(left: 20),
                        child: Text("Sexo",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 18, color: TropiColors.white))),
                    RadialButton(
                        stream: signupBlocInstance.newsexo,
                        title: "Masculino",
                        value: "m",
                        callback: _changeSex),
                    RadialButton(
                        stream: signupBlocInstance.newsexo,
                        title: "Femenino",
                        value: "f",
                        callback: _changeSex),
                    Container(
                        margin: EdgeInsets.only(left: 20),
                        child: Text("Ciudad",
                            style: TextStyle(
                                fontSize: 18, color: TropiColors.white))),
                    GestureDetector(
                        child: Container(
                            margin:
                                EdgeInsets.only(left: 20, bottom: 10, top: 15),
                            width: MediaQuery.of(context).size.width,
                            alignment: Alignment.centerRight,
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(cityName ?? "",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: TropiColors.white)),
                                  Icon(Icons.arrow_drop_down)
                                ])),
                        onTap: () => {_buildingCitiesModal(context)}),
                    InputTextbox(
                        controller: dateCtl,
                        title: "Fecha de nacimiento",
                        hintText: '',
                        stream: signupBlocInstance.newBirthDay,
                        onChange: signupBlocInstance.changeNewBirthDay,
                        colorLines: Colors.white,
                        onTap: _changeBirthDay,
                        allowEdit: true),
                    SizedBox(height: 20),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        child: ButtonLargeSubmit(
                            text: "GUARDAR",
                            nullText: "Rellena los campos",
                            callback: _doSave,
                            stream: authBlocInstance.submitValidLogin))
                  ]))))));

  void _buildingCitiesModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) => Container(
            color: Color(0xFF737373),
            child: Container(
                height: 600,
                child: buildCityModal(),
                decoration: boxGradient())));
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
