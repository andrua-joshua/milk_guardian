import 'package:flutter/material.dart';
import 'package:milk_analysis/bloc/respository/records_repository/record_repository_base.dart';
import 'package:milk_analysis/bloc/respository/records_repository/record_repository_local.dart';

class RecordProvider with ChangeNotifier{

  RecordProvider._(RecordRepositoryBase recordRepo): recordBaseRepo = recordRepo; 

  factory RecordProvider(RecordRepositoryBase recordRepo) => RecordProvider._(recordRepo);

  final RecordRepositoryBase recordBaseRepo;


  void notifyAll() => notifyListeners();
}