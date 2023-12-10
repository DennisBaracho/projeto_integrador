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
  final _valor = TextEditingController();
  double lucro = 0;

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
                              text: '3.4Wh\n\n\n',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w300,
                                height: 0,
                              ),
                            ),
                            TextSpan(
                              text: '0,635R\$/kWh',
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
                      left: 14,
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
                    width: 143,
                    height: 19,
                    child: Text(
                      'Mensal:',
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
                    width: 100,
                    height: 19,
                    child: Text(
                      'Total:',
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
                      width: 110,
                      height: 42,
                      child: Text(
                        'R\$0,12',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontFamily: 'Open Sans',
                          fontWeight: FontWeight.w300,
                          height: 1,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                      height: 0,
                    ),
                    SizedBox(
                      width: 110,
                      height: 42,
                      child: Text(
                        'R\$0,60',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontFamily: 'Open Sans',
                          fontWeight: FontWeight.w300,
                          height: 1,
                        ),
                      ),
                    ),
                  ],
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Form(
                  child: TextFormField(
                      key: Key('earnings'),
                      controller: _valor,
                      style: const TextStyle(fontSize: 22),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Informe o valor do kWh',
                        suffix: Text(
                          'Wh',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Informe o valor do kWh';
                        } else if (double.parse(value) < 0) {
                          return 'Valor mínimo é 1 real';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          lucro = (value.isEmpty)
                              ? 0
                              : double.parse(value)/10;
                        });
                      }),
                ),
              ),
            ]),
      ),
    );
  }
}
