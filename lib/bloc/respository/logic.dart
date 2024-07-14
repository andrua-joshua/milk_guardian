import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class AppBluetoothLogic{

  static BluetoothDevice? connectedDevice;

  static Future<void> sendOne({required int data}) async {
     ///turnon the bluetooth
    List<BluetoothService> servicez = await connectedDevice!.discoverServices();
    
        servicez.forEach((service) {
        final chtcs = service.characteristics;
        debugPrint(":::::::>>>>Drillox Service:  $service");

        for(var xtic in chtcs){
          // debugPrint("::::::>>>  Xtic(): ${xtic.properties.write}");

          
          if(xtic.properties.write){    
            print("\n::::::::::::::>>>>>The service that allows Write Options :  $service\n\n");
            xtic.write([data], withoutResponse: false).then((value) 
              {
                debugPrint("::::>>>>> Sending completed:  $data");
                
                readPh().then((x)
                => debugPrint("::::>>>>> Reading completed:  $x"));
                });
            print(":::>>>> Xtick read: ${xtic.properties.read}");
            
          }
          xtic.setNotifyValue(true).then((x){
            print("Done setting the value...............");
            xtic.value.listen((event) {
                  print("=========> Data from the waiting Update..d (${xtic.characteristicUuid}) >>> $event");
                },);
          });
          
        }
    });
  }




  static Future<List<int>> readPh() async {
    List<BluetoothService> servicez = await connectedDevice!.discoverServices();
    List<int> value = [];    
        servicez.forEach((service) {
        final chtcs = service.characteristics;
        // debugPrint(":::::::>>>>Drillox Characteristics:  $chtcs");

        for(var xtic in chtcs){
          // debugPrint("::::::>>>  Xtic(): ${xtic.properties.write}");
          if(xtic.properties.read){    
            // xtic.write([data], withoutResponse: false).then((value) 
            //   => debugPrint("::::>>>>> Sending completed:  $data"));
            
             xtic.read().then((data){
              value = data;
              print(":::::Value>>>>::::>>>>>>>>>> ${String.fromCharCodes(data)}");
              print(":::::Value As Array>>>>::::>>>>>>>>>> $data");
             });
            print(":::>>>> Xtick read: ${xtic.properties.read}");
            print(":::>>>> Xtick read Data: $value");

            
            
          }
        }

    });


        return value;
  }


  static Future<List<BluetoothDevice>> bondedDevices()async{
     return await FlutterBluePlus.bondedDevices;
  }

  static Future<void> setDevice(BluetoothDevice device)async{
    // await device.createBond();
    debugPrint(">>>Connecting to ${device.platformName} Service List::> ${device.servicesList}");
    
    await device.connect();
    debugPrint(">>>Connected Successfully to ${device.platformName}");
    connectedDevice = device;
     debugPrint(">>>${device.platformName} added as connected device!");
  }

}






/**
 * 
 * 1. create an arry that holds two values [pin, state]
 * 2. populate the arry with the data coming from the ble module
 * 3. check if the the array is well populated with the correct data
 *    3.1. change the state of the load or device on pin specified by 
 *        the value at the firstIndex of the populated arry to the state
 *        specified by the value a the secondindex of the arry.
 *    3.2. now clear the arry
 * 
 **/ 
