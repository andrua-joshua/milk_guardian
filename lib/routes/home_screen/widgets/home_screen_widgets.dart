import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:milk_analysis/bloc/modules/record_module.dart';
import 'package:milk_analysis/bloc/respository/logic.dart';
import 'package:milk_analysis/bloc/respository/records_repository/record_repository_local.dart';
import 'package:milk_analysis/provider/record_provider.dart';
import 'package:milk_analysis/provider/user_provider.dart';
import 'package:milk_analysis/routes.dart';
import 'package:milk_analysis/util/app_styles.dart';
import 'package:provider/provider.dart';

class UnitRecordWidget extends StatelessWidget{
  final Record record;
  const UnitRecordWidget({super.key, required this.record});

  @override
  Widget build(BuildContext context) {
    
    return Consumer2<RecordProvider, UserProvider>(
      builder:(context, valueR, valueU, child) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: GestureDetector(
        // onTap: () => Navigator.pushNamed(context, RouteGenerator.recordScreen),
        child:Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(record.createdAt , style: AppStyle.sensorDataStyle,),
          const SizedBox(width: 10,),
          GestureDetector(
            onTapDown: (pos){
              final offset = pos.globalPosition;

              showMenu(
                context: context, 
                position: RelativeRect.fromLTRB(
                  offset.dx, 
                  offset.dy, 
                  MediaQuery.of(context).size.width - offset.dx,
                        MediaQuery.of(context).size.height - offset.dy), 
                items: [
                  // const PopupMenuItem(
                  //         child: SizedBox(
                  //           child: Row(
                  //             children: [
                  //               Icon(Icons.save_alt, size: 20,),
                  //               SizedBox(width: 5,),
                  //               Text('Download as PDF')
                  //             ],
                  //           ),
                  //         )),
                      PopupMenuItem(
                          child: GestureDetector(
                            onTap: (){
                              deleteRecord(recordId: record.id, 
                              userProvider: valueU, 
                              provider: valueR);
                              // valueU.notifyAll();
                            },
                            child: const SizedBox(
                            child: Row(
                              children: [
                                Icon(Icons.delete_forever, color: Colors.red, size: 20,),
                                SizedBox(width: 5,),
                                Text('Delete chat')
                              ],
                            ),
                          ),
                          )),
                ]);
            },
            child: Icon(Icons.more_vert),
          )
        ],
      )),),);
  }

  Future<void> deleteRecord({
    required int recordId,
    required UserProvider userProvider,
    required RecordProvider provider
  })async{
    final res =  await provider.recordBaseRepo.deleteRecord(
      record: record, recordId: recordId, 
      userProvider: userProvider);

    if(res == 1){
      Fluttertoast.showToast(msg: "Record deleted successfully");
    }else{
      Fluttertoast.showToast(msg: "Failed to delete record");
    }
  }

}



class BTListDialog extends StatefulWidget{
  final Function() onConnected;
  const BTListDialog({super.key, required this.onConnected});

  @override
  BTListDialogState createState () => BTListDialogState();
  
}


class BTListDialogState extends State<BTListDialog>{
  

  @override
  Widget build(BuildContext context){
    return Container(
      height: 220,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10)
        )
      ),

      padding: const EdgeInsets.all(10),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(child:Text("Connected BT Devices", style: AppStyle.titleStyle,)),
          const Divider(thickness: 1, color: Colors.blueAccent,),
          const SizedBox(height: 10,),
          Expanded(
            child: SingleChildScrollView(
              child: FutureBuilder(
                future: AppBluetoothLogic.bondedDevices(), 
                builder:(context, snapshot) {
                  
                  if(snapshot.hasData){
                    debugPrint("Drillox--prints::: ${snapshot.data!.length}");
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                      snapshot.data!.length, 
                      (index) => UnitBTDeviceItem(
                        btDevice: snapshot.data![index] as BluetoothDevice, 
                        index: index,
                        onConnected:()=> widget.onConnected(),)),
                    );
                  }

                  if(snapshot.hasError){
                    debugPrint(":::::>> ErrorObj::  ${snapshot.error}");
                    return Center(child:Text("Error, Check your BT ${snapshot.error}"));
                  }

                  return const Center(child: CircularProgressIndicator(color: Colors.blueAccent,),);
                },),
            ))
        ],
      ),
    );
  }
}



class UnitBTDeviceItem extends StatelessWidget{
  final BluetoothDevice btDevice;
  final int index;
  final Function() onConnected;
  const UnitBTDeviceItem({
    required this.index,
    required this.onConnected,
    required this.btDevice,
    super.key
  });


  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: ()async{
        Navigator.pop(context);
        showDialog(context: context, 
        builder:(context) {
          
          return AlertDialog(
            title: const Text("Connecting to Device"),
            contentPadding: const EdgeInsets.all(10),
            content: FutureBuilder(
                future: AppBluetoothLogic.setDevice(btDevice),
                 builder: (context, snapshot){
                  if(snapshot.hasData){
                    onConnected();
                    return Text("Connected to ${btDevice.platformName} Successfully!");
                  }
                  if(snapshot.hasError){
                    print("The Error : ${snapshot.error.toString()}");
                    return Text("Error: ${snapshot.error.toString()}");
                  }
                  return const CircleAvatar(
                    child: CircularProgressIndicator(color: Colors.blue, strokeWidth: 5,));
                 },
            ),
          );
        },);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        child: Text(btDevice.platformName),
      ),
    );
  }
}