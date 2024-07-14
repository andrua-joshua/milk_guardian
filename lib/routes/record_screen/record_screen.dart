import 'dart:math';

import 'package:flutter/material.dart';
import 'package:milk_analysis/bloc/respository/data_respository.dart';
import 'package:milk_analysis/provider/data_provider.dart';
import 'package:milk_analysis/util/app_styles.dart';
import 'package:milk_analysis/util/custom_widget.dart';
import 'package:milk_analysis/bloc/modules/record_module.dart';
import 'package:provider/provider.dart';

class RecordScreen extends StatelessWidget{
  final Record record;
  const RecordScreen({super.key, required this.record});

  

  @override
  Widget build(BuildContext context) {

    final List<double> pHValues = [
    6.7,
    6.4,
    6.6,
    7.7,
    9.8,
  ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor:  Colors.blue,
        title: const Text("Record", style: AppStyle.titleStyle,),
      
        actions: [
          IconButton(
            onPressed: (){ }, 
            icon: Icon(Icons.more))
        ],
      ),
      body:  Consumer<DataProvider>(
        builder:(context, value, child) {
          
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
                  firstValue: record.pH.toStringAsFixed(2), 
                  secondValue: "6.8", 
                  firstColor: const Color.fromARGB(255, 228, 226, 226), 
                  secondColor: const Color.fromARGB(255, 228, 226, 226)),

                const SizedBox(height: 15,),
                Text( DataRespository().getByPhRange(ph: record.pH)?.label??"Unknown" , style: AppStyle.normalBoldBlackTextStyle,),
                const SizedBox(height: 7,),
                const Text("Summary", style: AppStyle.normalBoldBlackTextStyle,),
                SizedBox(
                  child: ListedResultWidget(
                    data: [
                      record.summary
                      //value.dataRespository.getByPhRange(ph: 11)?.summary??"Unknown"
                      ]),
                ),

                const SizedBox(height: 10,),
                const Text("Health Implications", style: AppStyle.normalBoldBlackTextStyle,),
                SizedBox(
                  child: ListedResultWidget(
                    data: [
                      record.healthImplications
                      //value.dataRespository.getByPhRange(ph: 11)?.healthImplications??"Unknown"
                      ]),
                )
              ],
            ),
          ),
          ));
        },),
    );
  }
}