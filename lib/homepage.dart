import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:get/get.dart';
import 'blecontroller.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final flutterReactiveBle = FlutterReactiveBle();
  final BleController c = Get.put(BleController());

  int temp = 43;

  @override
  Widget build(BuildContext context) {
    print('Build');

    return Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
              Container(
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
                        height: 52,
                      ),
                      //Temperatura
                      const Text(
                        'Temperatura Interna',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 55,
                            height: 53,
                            child: Image.asset('assets/images/temperature.png'),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(0),
                            child: Text('$temp º',
                                style: const TextStyle(
                                  fontSize: 48,
                                  fontWeight: FontWeight.w200,
                                  color: Colors.white,
                                )),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 45,
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
                              left: 77,
                              top: 50,
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: ' Hoje\n\n\n',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w300,
                                        height: 0,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' Wh',
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
                              left: 35,
                              top: 76,
                              child: Obx(
                                () => Text(
                                  '- ${c.today.toStringAsFixed(2)} -',
                                  style: const TextStyle(
                                      fontSize: 48,
                                      height: 0,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w300,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 54,
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
                              () => Text(
                                'Gerando agora: ${c.potencia} W',
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
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Obx(
                                () => Text(
                                  'Eficiência Elétrica: ${c.eff.toStringAsFixed(2)} %',
                                  style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w200,
                                      color: Colors.white),
                                ),
                              ),
                            ),

                          ]),
                      const SizedBox(
                        height: 44,
                      ),
                    ]),
              ),
            ])));
  }
}
