import 'package:flutter/material.dart';
import 'package:milk_analysis/bloc/respository/data_respository.dart';
import 'package:milk_analysis/provider/record_provider.dart';
import 'package:milk_analysis/provider/user_provider.dart';
import 'package:milk_analysis/routes.dart';
import 'package:milk_analysis/routes/home_screen/widgets/home_screen_widgets.dart';
import 'package:milk_analysis/routes/statistics_screen/widgets/widgets.dart';
import 'package:milk_analysis/util/app_colors.dart';
import 'package:milk_analysis/util/app_styles.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:milk_analysis/bloc/modules/record_module.dart';

class StatisticsScreen extends StatefulWidget{

  const StatisticsScreen({super.key});


  @override
  StatisticsScreenState createState ()=> StatisticsScreenState(); 
}


class StatisticsScreenState extends State<StatisticsScreen>{

  int currentIndex = 0;

  List<String> dates = [
    "Weekly",
    "Monthly",
    "Yearly"
  ];

  bool isSelected = false;
  int selectedIndex = 0;

  final List<ChartData> chartData = [
            ChartData('Normal Milk', 25, Color.fromRGBO(9,0,136,1)),
            ChartData('Urea', 38, Color.fromRGBO(147,0,119,1)),
            ChartData('Formalin (Formaldehyde Solution)', 34, Color.fromRGBO(228,0,124,1)),
            ChartData('Caustic Soda (Sodium Hydroxide, NaOH)', 52, Color.fromRGBO(8, 75, 17, 1)),
            ChartData('Detergent in milk', 52, Color.fromRGBO(79, 63, 138, 1)),
            ChartData('Unboiled Water', 52, Color.fromRGBO(87, 23, 3, 1))
        ];

  @override
  Widget build(BuildContext context) {
    return Consumer2<RecordProvider, UserProvider>(
                  builder:(context, valueR, valueU, child)=>Scaffold(
      appBar: AppBar(
        title: const Text(
          "Report",
          style: AppStyle.titleBlackTextStyle,
        ),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: SingleChildScrollView(
            child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                const SizedBox(height: 10,),
                SizedBox(
                  child: slider(),
                ),
                const SizedBox(height: 20,),
                Center(
                child: Container(
                    child: FutureBuilder(
                      future: generateChartData(valueU), 
                      builder:(context, snapshotx) {
                        if(snapshotx.hasData){
                          return SfCircularChart(
                              series: <CircularSeries>[
                                  // Renders doughnut chart
                                  DoughnutSeries<ChartData, String>(
                                    explode: true,
                                    onPointTap: (x){
                                      
                                      setState(() {
                                        selectedIndex = x.pointIndex??0;
                                        isSelected = true; 
                                        print(">>>>>>> Index of selected: ${x.pointIndex}");
                                      });
                                    },
                                      dataSource: snapshotx.data,
                                      pointColorMapper:(ChartData data,  _) => data.color,
                                      xValueMapper: (ChartData data, _) => data.x,
                                      yValueMapper: (ChartData data, _) => data.y
                                  )
                              ]
                          );
                        }

                        return const Center(child: Text("Loading...."),);
                      },)
                )
                ),
                SizedBox(
                  height: 50,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        chartData.length, 
                        (x)=> Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child:GestureDetector(
                          onTap: (){
                            setState(() {
                              selectedIndex = x;
                              isSelected = true;
                            });
                          },
                          child: Row(
                            children: [
                              Container(
                                height: 27,
                                width: 8,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: chartData[x].color
                                ),
                              ),
                              const SizedBox(width: 5,),
                              Text( chartData[x].x , style: AppStyle.roomLabelStyle,
                                maxLines: 1, overflow: TextOverflow.ellipsis,),
                              const SizedBox(width: 10,),
                            ],
                          ),
                        ))),
                    ),
                  ),
                ),
                const SizedBox(height: 15,),
                SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 35,
                        width: 3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: isSelected? chartData[selectedIndex].color: Colors.grey
                        ),
                      ),
                      const SizedBox(width: 5,),
                      Expanded(
                        child:Text( isSelected? chartData[selectedIndex].x :"Records", style: AppStyle.roomLabelStyle,
                        maxLines: 1, overflow: TextOverflow.ellipsis,)),
                      const SizedBox(width: 10,),
                      IconButton(
                        onPressed: (){}, 
                        icon: const Icon(Icons.filter_list))
                    ],
                  ),
                ),
                SizedBox(
                  child: FutureBuilder(
                    future: isSelected? filteredRecord(selectedIndex, 
                    valueU): valueR.recordBaseRepo.getAllRecords(userProvider:  valueU), 
                    builder:(context, snapshot) {
                      return Column(
                      children: List.generate(
                        snapshot.data?.length??0, 
                        (index)=> GestureDetector(
                          onTap: () => Navigator.pushNamed(context, RouteGenerator.recordScreen, arguments: snapshot.data![index]),
                          child:UnitRecordWidget(record: snapshot.data![index]))),
                    );
                    },),
                  )

            ],
          )),
          )),
    ));
  }


  Widget slider() => SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: List.generate(
        dates.length, 
        (x)=> unitItem(
          (){

            setState(() {
              currentIndex = x;
            });
          }, 
          x, dates[x])),
    ),
  );

  Widget unitItem(
    Function() callback,
    final int index,
    final String txt
  ) => GestureDetector(
    onTap: ()=> callback(),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: index == currentIndex?
          AppColors.primaryColor: null,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Center(
        child: Text(
        txt,
        style: index==currentIndex?
         AppStyle.normalBlackTextStyle: AppStyle.normalGreyTextStyle,
      )),
    ),
  );

  Future<List<Record>> filteredRecord(
    int index,
    UserProvider provider
  ) async{

    List<Record> records = [];
    final dataRepo = DataRespository();

    for(var i =0; i<provider.user!.records.length; i++){
      if(
        dataRepo.getByPhRange(ph: provider.user!.records[i].pH)?.label
        == chartData[index].x
      ){
        records.add(provider.user!.records[i]);
      }
    }

    print("::::::::> Records in ${chartData[index].x}:  > $records");

    return records;
  }

  Future<List<ChartData>> generateChartData (UserProvider provider)async{

    List<ChartData> data = [];

    for(var x =0; x<chartData.length; x++){
      int count = 0;
      final dataRepo = DataRespository();

      for(var i =0; i<provider.user!.records.length; i++){
        if(
          dataRepo.getByPhRange(ph: provider.user!.records[i].pH)?.label
          == chartData[x].x
        ){
          count++;
        }
      }

      data.add(ChartData(chartData[x].x, count*1.0, chartData[x].color));
      count = 0;
      
    }
    return data;
  }


}