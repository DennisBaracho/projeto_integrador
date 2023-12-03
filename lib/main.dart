import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:get/get.dart';
import 'blecontroller.dart';
import 'custom_icons_icons.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final flutterReactiveBle = FlutterReactiveBle();
  final BleController c = Get.put(BleController());

  int Wh = 0;
  int temp = 43;
  int eff = 75;
  double today = 3.4;
  int currentPageIndex = 0;
  NavigationDestinationLabelBehavior labelBehavior =
      NavigationDestinationLabelBehavior.alwaysShow;
  MaterialStateProperty<TextStyle?>? labelTextStyle;

  @override
  Widget build(BuildContext context) {
    print('Build');

    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          backgroundColor: const Color(0xff363490),
          labelTextStyle: MaterialStateProperty.all(
            const TextStyle(color: Colors.white),
          ),
        ),
        child: NavigationBar(
          selectedIndex: currentPageIndex,
          labelBehavior: labelBehavior,
          onDestinationSelected: (currentPageIndex) =>
              setState(() => currentPageIndex),
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home, color: Colors.white),
              label: 'Início',
            ),
            NavigationDestination(
              icon: Icon(CustomIcons.goals, color: Colors.white),
              label: 'Metas',
            ),
            NavigationDestination(
              icon: Icon(Icons.calendar_month_outlined, color: Colors.white),
              label: 'Relatórios',
            ),
            NavigationDestination(
              icon: Icon(Icons.wallet_outlined, color: Colors.white),
              label: "Lucro",
            ),
          ],
        ),
      ),
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
                      left: 42,
                      top: 76,
                      child: Text(
                        '- $today -',
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
