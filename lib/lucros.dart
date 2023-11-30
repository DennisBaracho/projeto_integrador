import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:get/get.dart';
import 'blecontroller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Profit(),
    );
  }
}

class Profit extends StatefulWidget {
  const Profit({super.key});

  @override
  State<Profit> createState() => _ProfitState();
}

class _ProfitState extends State<Profit> {
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
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 56,
                    height: 37,
                    child: Image.asset('assets/images/profit.png'),
                  ),
                ],
              ),
              const SizedBox(
                height: 44,
              ),
              //Economia de Energia
              const Text(
                'Economia de hoje:',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.w200,
                ),
              ),


              //Medidor de Wh hoje
              SizedBox(
                width: 213,
                height: 209,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        width: 213,
                        height: 209,
                        decoration: const ShapeDecoration(
                          gradient: LinearGradient(
                            begin: Alignment(-0.00, -1.00),
                            end: Alignment(0, 1),
                            colors: [
                              Color.fromRGBO(255, 255, 255, 0.5),
                              Color.fromRGBO(255, 255, 255, 0.5)
                            ],
                          ),
                          shape: OvalBorder(),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 7,
                      top: 8,
                      child: Container(
                        width: 200,
                        height: 193,
                        decoration: const ShapeDecoration(
                          gradient: LinearGradient(
                            begin: Alignment(-0.00, -1.00),
                            end: Alignment(0, 1),
                            colors: [
                              Color.fromRGBO(54, 52, 144, 0.7),
                              Color.fromRGBO(20, 20, 180, 0.7)
                            ],
                          ),
                          shape: OvalBorder(),
                        ),
                      ),
                    ),
                    const Positioned(
                      left: 40,
                      top: 50,
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: ' 3.4Wh\n\n\n',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w300,
                                height: 0,
                              ),
                            ),
                            TextSpan(
                              text: ' 0,635R\$/kWh',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w300,
                                height: 0,
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Positioned(
                      left: 20,
                      top: 73,
                      child: Text(
                        'R\$0,002',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 48,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w300,
                          height: 0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 19,
              ),
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
                          () =>
                          Text(
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
              Obx(() =>
                  Container(
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
