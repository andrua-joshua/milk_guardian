import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:milk_analysis/provider/record_provider.dart';
import 'package:milk_analysis/provider/user_provider.dart';
import 'package:milk_analysis/routes.dart';
import 'package:milk_analysis/routes/home_screen/widgets/home_screen_widgets.dart';
import 'package:milk_analysis/util/app_colors.dart';
import 'package:milk_analysis/util/app_styles.dart';
import 'package:milk_analysis/util/buttons.dart';
import 'package:milk_analysis/util/custom_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});

  @override
  _homeScreenState createState () => _homeScreenState();
  
}


class _homeScreenState extends State<HomeScreen>{

  final List<String> dates = [
    "12 July, 2022",
    "13 June, 2022",
    "02 May, 2022",
    "12 May, 2022",
    "22 july, 2022",
  ];

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  Colors.blue,
        title: const Text("Analyzer", style: AppStyle.titleStyle,),
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: ()=> Navigator.pushNamed(context, RouteGenerator.profileScreen),
          child: const Padding(
          padding: EdgeInsets.all(10),
          child: CircleAvatar(
            radius: 15,
          ),
          ),
        ),
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
            icon: const Icon(Icons.more))
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
                    decoration: const BoxDecoration(
                      color:Color.fromARGB(255, 238, 236, 236),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/images/image.jpeg"))
                    ),
                )),
                
                const SizedBox(height: 10,),
                const CardedResultWidget(
                  firstLabel: "Milk pH", 
                  secondLabel: "Water", 
                  firstValue: "6.5 - 6.7", 
                  secondValue: "87%", 
                  firstColor: Color.fromARGB(255, 228, 226, 226), 
                  secondColor: Color.fromARGB(255, 228, 226, 226)),
                const SizedBox(height: 10,),
                ConeredButton(
                  label: "Analyze", 
                  txtColor: Colors.white, 
                  bgColor: Colors.blue, 
                  onClick: (){
                    if(FlutterBluePlus.connectedDevices.isNotEmpty){
                      Navigator.pushNamed(context, RouteGenerator.resultScreen);
                    }else{
                        showDialog(
                          context: context, 
                          builder:(context) => const AlertDialog(
                            titlePadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            title: Text(
                              "Bluetooth Device", 
                              style: AppStyle.titleBoldBlackTextStyle,
                              textAlign: TextAlign.center,),
                            content: Text(
                              "Connect bluetooth device before doing the analysis.", 
                              style: AppStyle.normalBlackTextStyle,
                              textAlign: TextAlign.center,
                            ),
                          ),);
                    }
                  }),
                const SizedBox(height: 10,),
                DOutlinedButton(
                  label: "Reports", 
                  btnHeight: 45, 
                  borderColor: AppColors.primaryColor, 
                  borderRadius: 20, 
                  textStyle: AppStyle.normalBlackTextStyle, 
                  onClick: ()=> Navigator.pushNamed(context, RouteGenerator.reportScreen)),
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
                Consumer2<RecordProvider, UserProvider>(
                  builder:(context, valueR, valueU, child) {
                    return SizedBox(
                  child: FutureBuilder(
                    future: valueR.recordBaseRepo.getAllRecords(userProvider:  valueU), 
                    builder:(context, snapshot) {
                      return Column(
                      children: List.generate(
                        snapshot.data?.length??0, 
                        (index)=> GestureDetector(
                          onTap: () => Navigator.pushNamed(context, RouteGenerator.recordScreen, arguments: snapshot.data![index]),
                          child:UnitRecordWidget(record: snapshot.data![index]))),
                    );
                    },),
                  );
                  },)
              ],
            ),
          ),
          )),
    );
  }
} 