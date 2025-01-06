import 'package:equatable/equatable.dart';
import '../../data/models/user_model.dart';

class UserEntity extends Equatable{
   final User user;
   final DepartementUserModel region;
   final DepartementUserModel departement;
   final DepartementUserModel sousprefecture;
   final DepartementUserModel localite;

   const UserEntity({required this.user, required this.region, required this.departement, required this.sousprefecture, required this.localite});

   //copyWith
   @override
   List<Object> get props => [user, region, departement, sousprefecture, localite];
}