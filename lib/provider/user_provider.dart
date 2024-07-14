import 'package:flutter/material.dart';
import 'package:milk_analysis/bloc/modules/user.dart';
import 'package:milk_analysis/bloc/respository/user_repository/user_repository_base.dart';

class UserProvider with ChangeNotifier{

  UserProvider._(UserRepositoryBase userRepository): userRepo = userRepository;

  factory UserProvider(UserRepositoryBase userRepository) => UserProvider._(userRepository);


  User? user;
  UserRepositoryBase userRepo;


  void notifyAll() => notifyListeners();

}