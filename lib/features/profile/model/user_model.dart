import 'dart:convert';

class UserModel {
  String id;
  String email;
  String password;
  String firstName;
  String lastName;
  String profilePhoto;
  DateTime dateOfBirth;
  int gender;
  DateTime joinDate;

  UserModel({
    required this.id,
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.profilePhoto,
    required this.dateOfBirth,
    required this.gender,
    required this.joinDate,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'password': password,
      'first_name': firstName,
      'last_name': lastName,
      'profile_photo': profilePhoto,
      'date_of_birth': dateOfBirth.toIso8601String(),
      'gender': gender,
      'join_date': joinDate.toIso8601String(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      firstName: map['first_name'] as String,
      lastName: map['last_name'] as String,
      profilePhoto: map['profile_photo'] as String,
      dateOfBirth: DateTime.parse(map['date_of_birth']).toUtc(),
      gender: map['gender'] as int,
      joinDate: DateTime.parse(map['join_date']).toUtc(),
    );
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'password': password,
        'first_name': firstName,
        'last_name': lastName,
        'profile_photo': profilePhoto,
        'date_of_birth': dateOfBirth.toIso8601String(),
        'gender': gender,
        'join_date': joinDate.toIso8601String(),
      };
  //String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class UserTokensModel {
  String accessToken;
  String refreshToken;
  String idToken;

  UserTokensModel({
    required this.accessToken,
    required this.refreshToken,
    required this.idToken,
  });
  factory UserTokensModel.fromMap(Map<String, dynamic> map) {
    return UserTokensModel(
      accessToken: map['access_token'] as String,
      refreshToken: map['refresh_token'] as String,
      idToken: map['id_token'] as String,
    );
  }
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'access_token': accessToken,
      'refresh_token': refreshToken,
      'id_token': idToken,
    };
  }
}
