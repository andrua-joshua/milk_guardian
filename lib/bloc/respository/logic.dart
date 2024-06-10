import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class AppBluetoothLogic{

  static BluetoothDevice? connectedDevice;

  static Future<void> sendOne({required int pin, required int state}) async {
     ///turnon the bluetooth
    List<BluetoothService> servicez = await connectedDevice!.discoverServices();
    
        servicez.forEach((service) {
        final chtcs = service.characteristics;
        debugPrint(":::::::>>>>Drillox Characteristics:  $chtcs");

        for(var xtic in chtcs){
          debugPrint("::::::>>>  Xtic(): ${xtic.properties.write}");
          if(xtic.properties.write ==true){    
            xtic.write([pin, state], withoutResponse: false).then((value) 
              => debugPrint("::::>>>>> Sending completed"));
            
          }
        }
    });
  }



  static Future<void> sendBulk({required List<int> pins, required int state}) async {
    ///turnoff the bluetooth
    
    List<BluetoothService> servicez = await connectedDevice!.discoverServices();
    
        servicez.forEach((service) {
        final chtcs = service.characteristics;
        debugPrint(":::::::>>>>Drillox Characteristics:  $chtcs");

        BluetoothCharacteristic? xt;
        for(var xtic in chtcs){
          debugPrint("::::::>>>  Xtic(): ${xtic.properties.write}");
          if(xtic.properties.write ==true){
            
            pins.forEach((pin) {
              xtic.write([pin,state]).then((value) 
              => debugPrint("::::>>>>> Sending completed:  {$pin, $state}"));
             });
            
          }
        }

        
        
    });
  }

  static Future<void> readOn(int pin) async {

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
