import 'package:milk_analysis/bloc/modules/user.dart';
import 'package:milk_analysis/provider/user_provider.dart';

abstract interface class UserRepositoryBase{

  Future<User?> signUp({
    required String username,
    required String phone,
    required String email,
    required String password,
    required UserProvider provider
  });


  Future<User?> login({
    required String email,
    required String password,
    required UserProvider provider
  });


  Future<User?> updateUser({
    required String username,
    required String phone,
    required String email,
    required String password,
    required UserProvider provider
  });


}