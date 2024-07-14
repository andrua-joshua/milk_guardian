import 'package:flutter/material.dart';
import 'package:milk_analysis/bloc/respository/data_respository.dart';

class DataProvider with ChangeNotifier{

  final DataRespository dataRespository = DataRespository();

}