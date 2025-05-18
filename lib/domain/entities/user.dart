class User {
  final int? idUser;
  final String nameUser;
  final String emailUser;
  final String adresseUser;
  final String role;
  final String password;

  User({
    this.idUser,
    required this.nameUser,
    required this.emailUser,
    required this.adresseUser,
    required this.role,
    required this.password,
  });
}
