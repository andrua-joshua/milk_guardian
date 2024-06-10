import 'package:flutter/material.dart';
import 'package:milk_analysis/util/app_styles.dart';
import 'package:milk_analysis/util/custom_widget.dart';

class ResultScreen extends StatefulWidget{
  const ResultScreen({super.key});

  @override
  _resultScreenState createState () => _resultScreenState();
}


class _resultScreenState extends State<ResultScreen>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  Colors.blue,
        title: const Text("Analyzer", style: AppStyle.titleStyle,),

        actions: [
          IconButton(
            onPressed: (){}, 
            icon: Icon(Icons.more))
        ],
      ),
      body:  SafeArea(
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
                  color: const Color.fromARGB(255, 223, 223, 223),
                )),
                const SizedBox(height: 10,),
                AnalyzeButton(
                  label: "Analyze", 
                  txtColor: Colors.white, 
                  bgColor: Colors.blue, 
                  onClick: (){}),
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
                const CardedResultWidget(
                  firstLabel: "Milk pH", 
                  secondLabel: "Water", 
                  firstValue: "6.6", 
                  secondValue: "23%", 
                  firstColor: const Color.fromARGB(255, 228, 226, 226), 
                  secondColor: const Color.fromARGB(255, 228, 226, 226)),
                const SizedBox(height: 10,),
                const Text("Summary", style: AppStyle.sensorDataStyle,),
                const SizedBox(
                  child: ListedResultWidget(
                    data: [
                      "This is all spoilt milk, this is more than important to use thsi dfkdfkjsdfjsnfkjnskjcnsljdfn d This is all spoilt milk, this is more than important to use thsi dfkdfkjsdfjsnfkjnskjcnsljdfn",
                      ]),
                ),

                const SizedBox(height: 10,),
                const Text("Health Implications", style: AppStyle.sensorDataStyle,),
                const SizedBox(
                  child: ListedResultWidget(
                    data: [
                      "This is all spoilt milk, this is more than important to use thsi dfkdfkjsdfjsnfkjnskjcnsljdfn d This is all spoilt milk, this is more than important to use thsi dfkdfkjsdfjsnfkjnskjcnsljdfn",
                      "This is all spoilt milk is all spoilt milk",
                      "This is all spoilt milk all spoilt milk is all spoilt milk is all spoilt milk",
                      "This is all spoilt milk milk all spoilt milk is all spoilt milk is all spoilt milk",
                      "This is all spoilt milk is all spoilt milk is all spoilt milk",
                      ]),
                )
              ],
            ),
          ),
          )),
    );
  }
}