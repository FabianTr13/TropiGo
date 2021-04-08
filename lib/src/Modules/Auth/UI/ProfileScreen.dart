import 'package:TropiGo/src/Modules/Auth/Bloc/AuthBloc.dart';
import 'package:TropiGo/src/Modules/Auth/Bloc/SignupBloc.dart';
import 'package:TropiGo/src/Multimedia/Images.dart';
import 'package:TropiGo/src/Multimedia/TropiColors.dart';
import 'package:TropiGo/src/Services/AuthService.dart';
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

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _updateProfile(),
    );
  }

  @override
  void initState() {
    super.initState();
    _focusNameNode = FocusNode();
    _getCurrent();
  }

  @override
  void dispose() {
    super.dispose();
    _focusNameNode.dispose();
  }

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
      signupBlocInstance.changeNewPhoneNumber(user.phoneNumber);
      signupBlocInstance.changeNewBirthDay(user.birthDate);
      signupBlocInstance.changeNewSex(user.sexo);
      signupBlocInstance.changeEmail(user.email);
      _nameController.text = user.name;
      _phoneController.text = user.phoneNumber;
      dateCtl.text = user.birthDate;
    } else {
      showToast("Ocurrio un error al obtener perfil");
      Navigator.pop(context);
    }
  }

  _doSave() async {
    setState(
      () {
        isLoading = true;
      },
    );

    AuthService().updateUser();

    setState(() {
      isLoading = false;
    });

    showToast(
      "Datos Actualizados",
      backgroundColor: Colors.blue,
    );

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

  Widget _updateProfile() {
    return new Scaffold(
      appBar: navBar(
        withActions: false,
        automaticallyImplyLeading: false,
      ),
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        opacity: 0.5,
        color: Colors.orangeAccent,
        progressIndicator: CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(Colors.orange),
        ),
        child: SingleChildScrollView(
          child: Container(
            decoration: boxGradient(),
            height: MediaQuery.of(context).size.height,
            child: Form(
              child: new Column(
                children: [
                  ImageHeader(
                    title: "Mi Perfil",
                    image: ProfileImg,
                    underLine: true,
                    size: 80,
                  ),
                  InputTextbox(
                    title: "Nombre",
                    hintText: '',
                    focusNode: _focusNameNode,
                    onChange: signupBlocInstance.changNewName,
                    stream: signupBlocInstance.newName,
                    nextFocus: _focusPassNode,
                    controller: _nameController,
                    colorLines: Colors.white,
                  ),
                  InputTextbox(
                    title: "Teléfono",
                    hintText: '',
                    keyboardType: TextInputType.number,
                    onChange: signupBlocInstance.changeNewPhoneNumber,
                    stream: signupBlocInstance.newPhoneNumber,
                    focusNode: _focusPassNode,
                    controller: _phoneController,
                    colorLines: Colors.white,
                  ),
                  Container(
                    alignment: Alignment.bottomLeft,
                    margin: EdgeInsets.only(left: 20),
                    child: Text(
                      "sexo",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: TropiColors.white,
                      ),
                    ),
                  ),
                  RadialButton(
                    stream: signupBlocInstance.newsexo,
                    title: "Masculino",
                    value: "m",
                    callback: _changeSex,
                  ),
                  RadialButton(
                    stream: signupBlocInstance.newsexo,
                    title: "Femenino",
                    value: "f",
                    callback: _changeSex,
                  ),
                  InputTextbox(
                    controller: dateCtl,
                    title: "Fecha de nacimiento",
                    hintText: '',
                    stream: signupBlocInstance.newBirthDay,
                    onChange: signupBlocInstance.changeNewBirthDay,
                    colorLines: Colors.white,
                    onTap: _changeBirthDay,
                    allowEdit: true,
                  ),
                  Container(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.65,
                    child: ButtonLargeSubmit(
                      text: "GUARDAR",
                      nullText: "Rellena los campos",
                      callback: _doSave,
                      stream: authBlocInstance.submitValidLogin,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
