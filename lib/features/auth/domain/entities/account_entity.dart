import 'package:equatable/equatable.dart';

class AccountEntity extends Equatable {
  final int id;
  final String? token;
  final String? userName;
  final String? firebaseToken;
  final String? lastName;
  final String? firstName;
  final String? number;
  final String? photo;
  final bool? isConnected;
  final String? gender;
  final String? birthdate;
  final List<String>? scopes = [];
  final double? rate;

  AccountEntity({
  required  this.id,
    this.token,
    this.userName,
    this.firebaseToken,
    this.lastName,
    this.firstName,
    this.number,
    this.photo,
    this.isConnected,
    this.gender,
    this.birthdate,
    this.rate,
  });

  // copyWith
  AccountEntity copyWith({
    int? id,
    String? token,
    String? userName,
    String? firebaseToken,
    String? lastName,
    String? firstName,
    String? number,
    String? photo,
    bool? isConnected,
    String? gender,
    String? birthdate,
    double? rate,
  }) {
    return AccountEntity(
      id: id ?? this.id,
      token: token ?? this.token,
      userName: userName ?? this.userName,
      firebaseToken: firebaseToken ?? this.firebaseToken,
      lastName: lastName ?? this.lastName,
      firstName: firstName ?? this.firstName,
      number: number ?? this.number,
      photo: photo ?? this.photo,
      isConnected: isConnected ?? this.isConnected,
      gender: gender ?? this.gender,
      birthdate: birthdate ?? this.birthdate,
      rate: rate ?? this.rate,
    );
  }

  factory AccountEntity.fromJson(Map<String, dynamic> json) {
    return AccountEntity(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      birthdate: json['birthdate'],
      firebaseToken: json['firebaseToken'],
      gender: json['gender'],
      isConnected: json['isConnected'],
      number: json['number'],
      photo: json['photo'],
      token: json['token'],
      rate: json['rate'],
      userName: json['userName'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'birthdate': birthdate,
        'firebaseToken': firebaseToken,
        'gender': gender,
        'isConnected': isConnected,
        'number': number,
        'photo': photo,
        'token': token,
        'rate': rate,
        'userName': userName,
      };

  @override
  List<Object?> get props => [
        id,
        token,
        userName,
        firebaseToken,
        lastName,
        firstName,
        number,
        photo,
        isConnected,
        gender,
        birthdate,
        rate,
      ];
}
