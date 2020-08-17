class Signup {
  final String email;
  final String name;
  final String phoneNumber;
  final String password;
  final String rePassword;

  Signup({
    this.email,
    this.name,
    this.phoneNumber,
    this.password,
    this.rePassword,
  });

  Map<String, dynamic> toJson() => {
        'name': this.name,
        'phone': this.phoneNumber,
        'provider': "firebase",
        'userInDelivering': false,
      };
}
