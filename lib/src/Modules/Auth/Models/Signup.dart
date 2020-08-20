class Signup {
  final String uID;
  final String email;
  final String name;
  final String phoneNumber;
  final String password;
  final String rePassword;

  //update
  final String newName;
  final String newPhoneNumber;

  Signup({
    this.uID,
    this.email,
    this.name,
    this.phoneNumber,
    this.password,
    this.rePassword,
    this.newName,
    this.newPhoneNumber,
  });

  Map<String, dynamic> singUptoJson() => {
        'name': this.name,
        'phone': this.phoneNumber,
        'provider': "firebase",
        'userInDelivering': false,
      };

  Map<String, dynamic> upDatetoJson() => {
        'name': this.newName,
        'phone': this.newPhoneNumber,
        'provider': "firebase",
        'userInDelivering': false,
      };
}
