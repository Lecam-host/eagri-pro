import 'package:equatable/equatable.dart';
import '../../data/models/user_model.dart';

class UserEntity extends Equatable{
   final User user;
   final Location region;
   final Location departement;
   final Location sousprefecture;
   final Location localite;

   const UserEntity({required this.user, required this.region, required this.departement, required this.sousprefecture, required this.localite});

   //copyWith
   @override
   List<Object> get props => [user, region, departement, sousprefecture, localite];
}