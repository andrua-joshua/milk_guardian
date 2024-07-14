import 'package:http/http.dart' as http;

class UserRepository{

  Future<bool> login({
    required String email,
    required String password
  }) async{

    final Map<String, dynamic> payload = {
      "username": email,
      "password": password
    };

    try{

      final res = await http.post(
        Uri.parse("https://authentication-1rnk.onrender.com/login"),
        body: payload
      );

      if(res.statusCode == 200 || res.statusCode==201 || res.statusCode == 302){
        print("Login Successful");
        return true;
      }else{
        print("Login failes:.......    ${res.body} ${res.statusCode}");
        return false;
      }

    }catch(err){
      print("Erro:   Login Failed:   $err");
      return false;
    }

  }



  Future<bool> signup({
    required String username,
    required String phone,
    required String email,
    required String password
  }) async{

    final Map<String, dynamic> payload = {
      "username": username,
      "phone": phone,
      "email": email,
      "password": password
    };

    try{

      final res = await http.post(
        Uri.parse("https://authentication-1rnk.onrender.com/signup"),
        body: payload
      );

      if(res.statusCode == 200 || res.statusCode==201 || res.statusCode == 302){
        print("signup successful");
        return true;
      }else{
        return false;
      }

    }catch(err){
      print("Error:  Login Failed  :   $err");
      return false;
    }

  }
}