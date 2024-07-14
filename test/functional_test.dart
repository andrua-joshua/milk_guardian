

import 'package:flutter_test/flutter_test.dart';
import 'package:milk_analysis/bloc/respository/data_respository.dart';

void main(){
  test("PH Range value fetching", (){
    double ph = 7.5;
    final data = DataRespository().getByPhRange(ph: ph);
    print("::> ${data!.summary}");
  });
}