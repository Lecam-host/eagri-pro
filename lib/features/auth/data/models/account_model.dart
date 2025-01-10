
import '../../domain/entities/account_entity.dart';

class AccountModel extends AccountEntity {
  AccountModel(
      {required super.id,
      super.firstName,
      super.lastName,
      super.birthdate,
      super.firebaseToken,
      super.gender,
      super.isConnected,
      super.number,
      super.photo,
      super.token,
      super.rate,
      super.userName});

  factory AccountModel.fromJson(Map<String, dynamic> json) {
    return AccountModel(
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
}
