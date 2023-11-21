import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'dart:async';
import 'package:get/get.dart';

class BleController {
  final flutterReactiveBle =
      FlutterReactiveBle(); //Iniciando o Flutter Reactive BLE
  //Criando variáveis de conexão, característica, status e potência
  late StreamSubscription<ConnectionStateUpdate> conexao;
  late QualifiedCharacteristic characteristic;
  RxString potencia = ''.obs;
  RxString status = 'desconectado'.obs;

  //Função que realiza a conexão ao dispositivo BLE
  void conectar() async {
    flutterReactiveBle
        .connectToDevice(
      id: '04:A3:16:A8:70:67',
      connectionTimeout: const Duration(seconds: 2),
    )
        .listen((connectionState) {
      // Analisa o estado da conexão
    }, onError: (Object error) {
      // Lida com possíveis erros
    });

    // Avalia se os dispositivos já se conectaram
    status.value = 'conectando...';
    conexao = flutterReactiveBle
        .connectToDevice(id: '04:A3:16:A8:70:67')
        .listen((state) async {

      // Se já conectado, começa a ler a característica
      if (state.connectionState == DeviceConnectionState.connected) {
        status.value = 'conectado!';
        final caracteristica = QualifiedCharacteristic(
            serviceId: Uuid.parse("0000ffe0-0000-1000-8000-00805f9b34fb"),
            characteristicId:
                Uuid.parse("0000ffe1-0000-1000-8000-00805f9b34fb"),
            deviceId: '04:A3:16:A8:70:67');
        final resposta =
            await flutterReactiveBle.readCharacteristic(caracteristica);

        // Mantém a característica sempre atualizada
        flutterReactiveBle
            .subscribeToCharacteristic(caracteristica)
            .listen((data) {
          potencia.value = String.fromCharCodes(data);
          print(potencia);
        });
      }
    });
  }
}
