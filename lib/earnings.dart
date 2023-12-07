import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:get/get.dart';
import 'blecontroller.dart';

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
                height: 30,
              ),
              //Economia de Energia
              const Text(
                'Economia de hoje:',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.w200,
                ),
              ),
              const SizedBox(
                height: 20,
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
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 147,
                    height: 19,
                    child: Text(
                      'Economia mensal:',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w300,
                        height: 0,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 125,
                    height: 19,
                    child: Text(
                      'Economia total:',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w300,
                        height: 0,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:[
                    SizedBox(
                      width: 112,
                      height: 42,
                      child: Text(
                        'R\$0,12',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontFamily: 'Open Sans',
                          fontWeight: FontWeight.w300,
                          height: 1,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 93,
                      height: 42,
                      child: Text(
                        'R\$0,6',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontFamily: 'Open Sans',
                          fontWeight: FontWeight.w300,
                          height: 1,
                        ),
                      ),
                    ),
                  ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    Container(
                      width: 312.92,
                      height: 51.32,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                    SizedBox(
                      width: 252,
                      height: 28,
                      child: Text(
                        'Insira o valor do kWh',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF9D9D9D),
                          fontSize: 24,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                    )
                  ],
              ),
            ]),
      ),
    );
  }
}
