class UserModel {
  final int idUser;
  final String nameUser;
  final String emailUser;
  final String adresseUser;
  final String role;
  final String password;

  UserModel({
    required this.idUser,
    required this.nameUser,
    required this.emailUser,
    required this.adresseUser,
    required this.role,
    required this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      idUser: json['idUser'],
      nameUser: json['nameUser'],
      emailUser: json['emailUser'],
      adresseUser: json['adresseUser'],
      role: json['role'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idUser': idUser,
      'nameUser': nameUser,
      'emailUser': emailUser,
      'adresseUser': adresseUser,
      'role': role,
      'password': password,
    };
  }
}
