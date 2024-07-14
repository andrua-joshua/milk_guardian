import 'package:milk_analysis/bloc/modules/record_module.dart';

class User{

  final int id;
  final String username;
  final String email;
  final String phone;
  final List<Record> records;

  User({
    required this.id,
    required this.email,
    required this.phone,
    required this.username,
    required this.records
  });

  factory User.fromJson(Map<String, dynamic> json)
    {

      final data = json['records'] as List;
      List<Record> _records =  [];
      for(var record in data){
        _records.add(
          Record.fromJson(record)
        );
      }

      return User(
        id: json['id'],
        email: json["email"], 
        phone: json['phone'], 
        username: json["username"],
        records: _records
      );
    }

  Map toJson()
    => {
      'id':id,
      "email":email,
      "phone": phone,
      "username": username
    };

}