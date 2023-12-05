import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:get/get.dart';
import 'blecontroller.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Goals extends StatefulWidget {
  const Goals({super.key});

  @override
  State<Goals> createState() => _GoalsState();
}

class _GoalsState extends State<Goals> {
  final flutterReactiveBle = FlutterReactiveBle();
  final BleController c = Get.put(BleController());

  int Wh = 0;
  int temp = 43;
  int eff = 75;
  double today = 3.4;

  @override
  Widget build(BuildContext context) {
    print('Build');

    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 100,
              ),
              //Temperatura
              const Text(
                '05/09/2023',
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                  fontWeight: FontWeight.w200,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [],
              ),
              const SizedBox(
                height: 44,
              ),
              //Economia de Energia
              const Text(
                'Progresso:',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.w200,
                ),
              ),
              const Text(
                '53%',
                style: TextStyle(
                  fontSize: 48,
                  color: Colors.white,
                  fontWeight: FontWeight.w200,
                ),
              ),
        CircularPercentIndicator(
            radius: 100.0,
            lineWidth: 10.0,
            percent: 0.3,
          progressColor: Colors.white,
         backgroundColor: Color(0xFF6B56B9),
            center: Icon(
              Icons.thunderstorm,
              size: 50.0,
              color: Colors.blue,
            ),),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 45,
                    height: 46.22,
                    child: Image.asset('assets/images/power.png'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Obx(
                      () => Text(
                        'Tensão: ${c.potencia} V',
                        style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w200,
                            color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 45,
              ),
              Obx(() => Container(
                  child: c.status != 'connected!'
                      ? TextButton(
                          onPressed: c.connect,
                          child: Image.asset(
                            'assets/images/bluetooth.png',
                          ))
                      : null)),
              const SizedBox(
                height: 33,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    'Eficiência Elétrica: $eff%',
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w200,
                        color: Colors.white),
                  ),
                ),
              ]),
            ]),
      ),
    );
  }
}
