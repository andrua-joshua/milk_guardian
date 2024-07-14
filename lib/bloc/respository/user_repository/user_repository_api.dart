import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:milk_analysis/bloc/modules/user.dart';
import 'package:milk_analysis/bloc/respository/user_repository/user_repository_base.dart';
import 'package:milk_analysis/provider/user_provider.dart';
import 'package:milk_analysis/util/app_constants.dart';

import 'package:http/http.dart' as http;

class UserRepositoryApi implements UserRepositoryBase{
  @override
  Future<User?> login({
    required String email, 
    required String password, 
    required UserProvider provider}) async {

      final uri = Uri.parse(AppConstants.login);

      final payload = {
        "email":email,
        "password": password
      };

      try{

        final res = await http.post(
          uri,
          headers:{
            "Content-Type": "application/json"
          },
          body: jsonEncode(payload));

        if(res.statusCode == 201){
          print(">>>>>> Login successful:  ${res.body} ${res.body}");
          final data = jsonDecode(res.body);

          return User.fromJson(data);

        }
        if(res.statusCode == 404){
          print(">>>>>> User with email not found:  ${res.body} ${res.body}");
        }
        if(res.statusCode == 400){
          print(">>>>>> Invalid password:  ${res.body} ${res.body}");
        }

      }catch(err){
        print(">>>>>> Error logging in :   $err");
      }

    return null;
    
  }

  @override
  Future<User?> signUp({
    required String username, 
    required String phone, 
    required String email, 
    required String password, 
    required UserProvider provider}) async{
    
      final uri = Uri.parse(AppConstants.signup);

      final payload = {
        "username": username,
        "phone": phone,
        "email":email,
        "password": password
      };

      try{

        final res = await http.post(
          uri,
          headers:{
            "Content-Type": "application/json"
          },
          body: jsonEncode(payload));

        if(res.statusCode == 201){
          print(">>>>>> Signup successful:  ${res.body} ${res.body}");
          final data = jsonDecode(res.body);

          return User.fromJson(data);

        }
        if(res.statusCode == 404){
          print(">>>>>> User with email not found:  ${res.body} ${res.body}");
        }
        if(res.statusCode == 400){
          print(">>>>>> Invalid password:  ${res.body} ${res.body}");
        }

      }catch(err){
        print(">>>>>> Error signing up:   $err");
      }

    return null;
  }

  @override
  Future<User?> updateUser({
    required String username, 
    required String phone, 
    required String email, 
    required String password, 
    required UserProvider provider}) async{
    
    final uri = Uri.parse("${AppConstants.updateUser}${provider.user!.id}");

      final payload = {
        "username": username,
        "phone": phone,
        "email":email,
        "password": password
      };

      try{

        final res = await http.post(
          uri,
          headers:{
            "Content-Type": "application/json"
          },
          body: jsonEncode(payload));

        if(res.statusCode == 201){
          print(">>>>>> user Update successful:  ${res.body} ${res.body}");
          final data = jsonDecode(res.body);

          return User.fromJson(data);

        }
        if(res.statusCode == 404){
          print(">>>>>> User with email not found:  ${res.body} ${res.body}");
        }
        if(res.statusCode == 400){
          print(">>>>>> Invalid password:  ${res.body} ${res.body}");
        }

      }catch(err){
        print(">>>>>> Error updating user :   $err");
      }

    return null;

  }

  
}