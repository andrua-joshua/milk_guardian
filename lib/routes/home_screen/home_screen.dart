import 'package:flutter/material.dart';
import 'package:milk_analysis/routes.dart';
import 'package:milk_analysis/routes/home_screen/widgets/home_screen_widgets.dart';
import 'package:milk_analysis/util/app_styles.dart';
import 'package:milk_analysis/util/custom_widget.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});

  @override
  _homeScreenState createState () => _homeScreenState();
  
}


class _homeScreenState extends State<HomeScreen>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  Colors.blue,
        title: const Text("Analyzer", style: AppStyle.titleStyle,),

        actions: [
          IconButton(
            onPressed: (){
              showDialog(
                      context: context, 
                      builder: (conetext){
                        return AlertDialog(
                          contentPadding: const EdgeInsets.all(0),
                          content: BTListDialog(
                            onConnected: (){
                              setState(() {
                                // isConnected = true;
                              });
                            },
                          ),
                        );
                      });
            }, 
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
                const CardedResultWidget(
                  firstLabel: "Milk pH", 
                  secondLabel: "Water", 
                  firstValue: "6.5 - 6.7", 
                  secondValue: "23%", 
                  firstColor: const Color.fromARGB(255, 228, 226, 226), 
                  secondColor: const Color.fromARGB(255, 228, 226, 226)),
                const SizedBox(height: 10,),
                ConeredButton(
                  label: "Analyze", 
                  txtColor: Colors.white, 
                  bgColor: Colors.blue, 
                  onClick: () => Navigator.pushNamed(context, RouteGenerator.resultScreen)),
                const SizedBox(height: 30,),
                SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Records", style: AppStyle.roomLabelStyle,),
                      IconButton(
                        onPressed: (){}, 
                        icon: const Icon(Icons.filter_list))
                    ],
                  ),
                ),
                const SizedBox(height: 10,),
                SizedBox(
                  child: Column(
                    children: List.generate(
                      5, (_)=> const UnitRecordWidget(label: "label")),
                  ),
                )
              ],
            ),
          ),
          )),
    );
  }
} 