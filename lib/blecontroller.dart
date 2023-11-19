import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'dart:async';
import 'package:get/get.dart';
import 'package:location_permissions/location_permissions.dart';

class BleController {
  final flutterReactiveBle = FlutterReactiveBle();
  late StreamSubscription<ConnectionStateUpdate>connection;
  late QualifiedCharacteristic characteristic;
  RxString tensao = ''.obs;
  RxString status = 'not connected'.obs;

  void connect() async {

    flutterReactiveBle.connectToDevice(
      id: '04:A3:16:A8:70:67',
      connectionTimeout: const Duration(seconds: 2),
    ).listen((connectionState) {
      // Handle connection state updates
    }, onError: (Object error) {
      // Handle a possible error
    });

    status.value = 'connecting...';
    connection = flutterReactiveBle.connectToDevice(id: '04:A3:16:A8:70:67').listen((state) async {
      if (state.connectionState == DeviceConnectionState.connected) {
        status.value = 'connected!';

        final characteristic = QualifiedCharacteristic(
            serviceId: Uuid.parse("0000ffe0-0000-1000-8000-00805f9b34fb"),
            characteristicId: Uuid.parse(
                "0000ffe1-0000-1000-8000-00805f9b34fb"),
            deviceId: '04:A3:16:A8:70:67');
        final response = await flutterReactiveBle.readCharacteristic(
            characteristic);

        flutterReactiveBle.subscribeToCharacteristic(characteristic).listen((
            data) {
          tensao.value = String.fromCharCodes(data);
          print (tensao);
        });
      }
    }
    );}}