// import 'dart:convert';
// import 'dart:io';

// import 'package:milk_analysis/bloc/modules/record_module.dart';
// import 'package:milk_analysis/bloc/respository/records_repository/record_repository_base.dart';
// import 'package:path_provider/path_provider.dart';

// class RecordRepositoryLocal implements RecordRepositoryBase{




//   @override
//   Future<void> deleteRecord({required Record record}) async{
//     final records = await getAllRecords();
//     for(int i=0; i<records.length; i++){
//       if(records[i].date == record.date){
//         records.removeAt(i);
//       }
//     }    

//     final savablelist = [];
//     for(var item in records){
//       savablelist.add(item.toJson());
//     }


//     final _fl = await localRecordsFile();
//     await _fl.writeAsString(jsonEncode(savablelist), flush: true);
//   }

//   @override
//   Future<List<Record>> getAllRecords() async{
//     final _fl = await localRecordsFile();
//     final dataString = await _fl.readAsString();


//     if(dataString.isNotEmpty){
//       List<Record> records = [];
//       for(var item in (jsonDecode(dataString) as List<dynamic>)){
//         records.add(Record.fromJson(item as Map<String, dynamic>));
//       }

//       return records;
//     }else{
//       return [];
//     }
//   }

//   @override
//   Future<void> saveRecord({required Record record}) async{
//     final records = await getAllRecords();
//     records.add(record);
//     final savablelist = [];
//     for(var item in records){
//       savablelist.add(item.toJson());
//     }


//     final _fl = await localRecordsFile();
//     await _fl.writeAsString(jsonEncode(savablelist), flush: true);
    
//   }



//   Future<File> localRecordsFile () async{
//     final directory = await getApplicationDocumentsDirectory();
//     final file = File("${directory.path}/records.json");
//     if(!file.existsSync()){
//       await file.create();
//       await file.writeAsString(jsonEncode(List));
//     }
//     return file;

//   }

  
// }