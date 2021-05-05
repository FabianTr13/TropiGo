class UserProfile {
  final String uid;
  final String email;
  final String name;
  final String phoneNumber;
  final String cityId;
  final String colony;
  final String cityName;
  final String sexo;
  final String birthDate;
  final String provider;
  final bool userInDelivering;

  UserProfile(
      {this.uid,
      this.email,
      this.name,
      this.phoneNumber,
      this.sexo,
      this.cityId,
      this.colony,
      this.cityName,
      this.birthDate,
      this.provider,
      this.userInDelivering});
}
