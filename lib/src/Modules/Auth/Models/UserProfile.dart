class UserProfile {
  final String uid;
  final String email;
  final String name;
  final String phoneNumber;
  final String provider;
  final bool userInDelivering;

  UserProfile({
    this.uid,
    this.email,
    this.name,
    this.phoneNumber,
    this.provider,
    this.userInDelivering,
  });
}
