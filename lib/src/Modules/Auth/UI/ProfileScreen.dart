import 'package:TropiGo/src/Modules/Auth/Bloc/AuthBloc.dart';
import 'package:TropiGo/src/Modules/Auth/Bloc/SignupBloc.dart';
import 'package:TropiGo/src/Multimedia/Images.dart';
import 'package:TropiGo/src/Services/AuthService.dart';
import 'package:TropiGo/src/Utils/BoxGradient.dart';
import 'package:TropiGo/src/Widgets/AppBar/NavBar.dart';
import 'package:TropiGo/src/Widgets/ButtonLargeSubmit.dart';
import 'package:TropiGo/src/Widgets/ImageHeader.dart';
import 'package:TropiGo/src/Widgets/InputTextbox.dart';
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

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _UpdateProfile(),
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

      _nameController.text = user.name;
      _phoneController.text = user.phoneNumber;
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

    await AuthService().updateUser();

    setState(() {
      isLoading = false;
    });

    showToast(
      "Datos Actualizados",
      backgroundColor: Colors.blue,
    );

    Navigator.pop(context);
  }

  Widget _UpdateProfile() {
    return new Scaffold(
      appBar: NavBar(
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
            decoration: BoxGradient(),
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
                    height: 20,
                  ),
                  ButtonLargeSubmit(
                    text: "Guardar",
                    nullText: "Rellena los campos",
                    callback: _doSave,
                    stream: authBlocInstance.submitValidLogin,
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
