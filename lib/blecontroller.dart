import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'dart:async';
import 'package:get/get.dart';

class BleController {
  final flutterReactiveBle = FlutterReactiveBle();
  late StreamSubscription<ConnectionStateUpdate> connection;
  late QualifiedCharacteristic characteristic;
  RxDouble potencia = 0.0.obs;
  RxString status = 'not connected'.obs;
  RxDouble eff = 0.0.obs;
  RxDouble somah = 0.0.obs;
  RxDouble somamin = 0.0.obs;
  RxDouble todayh = 0.0.obs;
  RxDouble todaymin = 0.0.obs;
  RxDouble percent = 0.0.obs;
  RxInt countmin = 0.obs;
  RxInt counth = 0.obs;

  void connect() async {
    flutterReactiveBle
        .connectToDevice(
      id: '04:A3:16:A8:70:67',
      connectionTimeout: const Duration(seconds: 2),
    )
        .listen((connectionState) {
      // Analisa o estado da conexão
    }, onError: (Object error) {
      // Controla possíveis Erros
    });

    status.value = 'connecting...';
    connection = flutterReactiveBle
        .connectToDevice(id: '04:A3:16:A8:70:67')
        .listen((state) async {
      if (state.connectionState == DeviceConnectionState.connected) {
        status.value = 'connected!';

        final characteristic = QualifiedCharacteristic(
            serviceId: Uuid.parse("0000ffe0-0000-1000-8000-00805f9b34fb"),
            characteristicId:
                Uuid.parse("0000ffe1-0000-1000-8000-00805f9b34fb"),
            deviceId: '04:A3:16:A8:70:67');
        final response =
            await flutterReactiveBle.readCharacteristic(characteristic);

        flutterReactiveBle
            .subscribeToCharacteristic(characteristic)
            .listen((data) {
          //Obtendo valor de potência
          potencia.value = double.parse(String.fromCharCodes(data));
          //Calculando eficiência elétrica
          eff.value = (potencia.value * 100) / 3.3;

          //Somando os valores de potência para descobrir o Wh
          somah.value = potencia.value + potencia.value;
          countmin++;
          //Para obter o valor de Wh, são realizadas 1200 medições
          todayh.value = somah.value / 1200;
          if (counth > 1200) {
            todayh.value = 0.0;
          }

          //Somando os valores de potência para descobrir o Wmin
          somamin.value = potencia.value + potencia.value;
          countmin++;
          //Para obter o valor de Wmin, são realizadas 20 medições
          todaymin.value = somamin.value / 20;
          if (countmin > 20) {
            todaymin.value = 0.0;
          }
        });
      }
    });
  }
}
