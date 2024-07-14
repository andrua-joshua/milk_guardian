import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:milk_analysis/bloc/modules/data_module.dart';
import 'package:milk_analysis/bloc/respository/data_respository.dart';
import 'package:milk_analysis/bloc/respository/logic.dart';
import 'package:milk_analysis/provider/data_provider.dart';
import 'package:milk_analysis/provider/record_provider.dart';
import 'package:milk_analysis/provider/user_provider.dart';
import 'package:milk_analysis/util/app_styles.dart';
import 'package:milk_analysis/util/custom_widget.dart';
import 'package:provider/provider.dart';

class ResultScreen extends StatefulWidget{
  const ResultScreen({super.key});

  @override
  _resultScreenState createState () => _resultScreenState();
}


class _resultScreenState extends State<ResultScreen>{

  bool isLoading = false;
  double? pH;

  DataModule? dataValue;


  @override
  Widget build(BuildContext context) {
    return Consumer2<RecordProvider, UserProvider>(
      builder:(context, valueR, valueU,child) => Scaffold(
      appBar: AppBar(
        backgroundColor:  Colors.blue,
        title: const Text("Analyzer", style: AppStyle.titleStyle,),

        actions: [
          IconButton(
            onPressed: ()async{
              if(pH!=null){
                final res = await valueR.recordBaseRepo.saveRecord(
                  summary: dataValue!.summary,
                  healthImplications: dataValue!.healthImplications,
                  userProvider: valueU,
                  pH: pH??0);
                valueR.notifyAll();
                valueU.notifyAll();

              Fluttertoast.showToast(
                msg:res!=null? "Record saved": "Record not saved");

              }
            }, 
            icon: const Icon(Icons.save))
        ],
      ),
      body:  Consumer<DataProvider>(
        builder: (context, valuex, child) {
          
          return SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20,),
                Center(
                  child:Container(
                    constraints: const BoxConstraints.expand(height: 200),
                    decoration: const BoxDecoration(
                      color:Color.fromARGB(255, 238, 236, 236),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/images/image.jpeg"))
                    )
                )),
                const SizedBox(height: 10,),
                AnalyzeButton(
                  label: "Analyze", 
                  txtColor: Colors.white, 
                  bgColor: Colors.blue, 
                  onClick: () async{
                    setState(() {
                      isLoading = true;
                    });
                    await Future.delayed(Duration(seconds: 1));
                    // await AppBluetoothLogic.sendOne(data: 1);
                    await _getpH();
                    setState(() {
                      isLoading = false;
                    });

                    await AppBluetoothLogic.sendOne(data: 1);
                    
                  }),
                const SizedBox(height: 30,),
                SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Results", style: AppStyle.roomLabelStyle,),
                      IconButton(
                        onPressed: (){}, 
                        icon: const Icon(Icons.filter_list))
                    ],
                  ),
                ),
                const SizedBox(height: 10,),
                CardedResultWidget(
                  firstLabel: "Result pH", 
                  secondLabel: "Normal pH", 
                  firstValue: pH!=null? pH!.toStringAsFixed(2): "null", 
                  secondValue: "6.8", 
                  firstColor: Color.fromARGB(255, 228, 226, 226), 
                  secondColor: Color.fromARGB(255, 228, 226, 226)),
                const SizedBox(height: 15,),
                Text(dataValue?.label??"Unknown", style: AppStyle.normalBoldBlackTextStyle,),
                const SizedBox(height: 7,),
                const Text("Summary", style: AppStyle.normalBoldBlackTextStyle,),
                pH!=null? SizedBox(
                  child: ListedResultWidget(
                    data: [
                      dataValue?.summary??"Unknown"
                      //value.dataRespository.getByPhRange(ph: 7.0)?.summary??"Unkown",
                      ]),
                ): const SizedBox(
                  height: 100,
                  child: Center(
                    child: Text(
                      "Analyze to get result", style: AppStyle.roomLabelStyle,),
                  ),
                ),

                const SizedBox(height: 10,),
                const Text("Health Implications", style: AppStyle.normalBoldBlackTextStyle,),
                pH!=null?SizedBox(
                  child: ListedResultWidget(
                    data: [
                      dataValue?.healthImplications??"Unknown"
                      //value.dataRespository.getByPhRange(ph: 7.0)?.healthImplications??"Unkown"
                      ]),
                ):const SizedBox(
                  height: 100,
                  child: Center(
                    child: Text(
                      "Analyze to get result", style: AppStyle.roomLabelStyle,),
                  ),
                )
              ],
            ),
          ),
          ));
        },
      ),
    ),);
  }


  Future<void> _getpH() async{
    final readPh = Random();
    const double min  = 4.7;
    const int max = 12;

    double mult = 0.0+readPh.nextDouble();
    while(mult>1.0){
      mult = readPh.nextDouble().toDouble();
    }

    double _pH = min+(readPh.nextInt(max)*1.0) +mult;

    while(_pH>max){
      _pH = min+readPh.nextDouble().toDouble();
    }

    dataValue = DataRespository().getByPhRange(ph: _pH);

    setState(() {
      pH = _pH;
    });

  }
}