import 'dart:convert';

import 'package:milk_analysis/bloc/modules/record_module.dart';
import 'package:milk_analysis/bloc/respository/records_repository/record_repository_base.dart';
import 'package:milk_analysis/provider/user_provider.dart';
import 'package:milk_analysis/util/app_constants.dart';

import 'package:http/http.dart' as http;

class RecordsRepositoryApi implements RecordRepositoryBase {
  @override
  Future<int> deleteRecord({
    required Record record, 
    required int recordId, 
    required UserProvider userProvider}) async{
      
    final uri = Uri.parse("${AppConstants.deleteRecord}${recordId}");


    try{

      final res = await http.delete(
        uri
      );

      if(res.statusCode == 200){
        print(">>>>>>>>>>>>Record deleted succesfully......  ${res.statusCode}  ${res.body}");
        userProvider.notifyAll();
        return 1;
      }
      if(res.statusCode == 404){
        print(">>>>>>>>>>>>Record not found......  ${res.statusCode}  ${res.body}");
        return 0;
      }

    }catch(err){
      print(">>>>>>>>>>>>Error deleting the record: $err");
      return -1;
    }


    return -3;

  }

  @override
  Future<List<Record>> getAllRecords({
    required UserProvider userProvider}) async{

      final uri = Uri.parse("${AppConstants.getUserRecords}${userProvider.user!.id}");

      try{

        final res = await http.get(
          uri
        );

        if(res.statusCode == 200){
          print(">>>>>>>>>User records fetched successfully::  ${res.statusCode}  ${res.body}");

          final data = jsonDecode(res.body) as List<dynamic>;
          List<Record> records = [];

          for(var item in data){
            records.add(Record.fromJson(item));
          }

          return records;

        }

        if(res.statusCode == 404){
          print(">>>>>>>User not found:  ${res.statusCode}  ${res.body}");
          return [];
        }

        else{
          print(">>>>>>>Failed to fetch user's records:  ${res.statusCode}  ${res.body}");
          return [];
        }


      }catch(err){
        print(">>>>>>>>>>>>>>>>>>>>Error fetching user's records>    $err");
        return [];
      }

    
  }
  
  @override
  Future<Record?> saveRecord({
    required String summary, 
    required double pH, 
    required String healthImplications, 
    required UserProvider userProvider}) async{
    
    final uri = Uri.parse("${AppConstants.saveRecord}${userProvider.user!.id}");

    print("::::::::::::::>> Saving record... $pH $summary $healthImplications");

    final payload = 
    {
      "pH": pH,
      "summary": summary,
      "helthImplications": healthImplications
    };

    try{

      final res = await http.post(
        uri, 
        headers: {
          "Content-Type": "application/json"
        },
        body: jsonEncode(payload));


      if(res.statusCode == 201){
        print(">>>>>>>>>Record saved successfully:     ${res.statusCode} ${res.body}");

        final data = jsonDecode(res.body);
        return Record.fromJson(data);
      }else if(res.statusCode == 404){
        print(">>>>>>>>>User not found:     ${res.statusCode} ${res.body}");
        
      }else{
        print(">>>>>>>>>Failed to save record:     ${res.statusCode} ${res.body}");
      }

    }catch(err){
      print(">>>>>>>>>>>>Error saving the record:    $err");
    }

    return null;

  }



  
  

}