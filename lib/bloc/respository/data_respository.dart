import 'package:milk_analysis/bloc/data_module.dart';
import 'package:milk_analysis/bloc/modules/data_module.dart';
import 'package:milk_analysis/util/data.dart';

class DataRespository{

  ///
  ///fetch all the data
  ///
  
  DataModule? getByPhRange({required double ph}){
    
    DataModule? data;

    Data.data.forEach((x){
      double min = x["range"]['min'];
      double max = x["range"]['max'];

      print("::::::Dat min and max:  $min : $max");

      if(ph>=min && ph<=max){

        print(" X>>X>X>X>X>X>X>X>>>>>>>>>>>> The value is a \"${x["label"]}\"");
        data = DataModule.fromJson(x);

        
      }
    });

    return data;
  }

}