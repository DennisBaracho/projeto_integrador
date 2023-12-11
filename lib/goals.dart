import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class Goals extends StatefulWidget {
  const Goals({super.key});

  @override
  State<Goals> createState() => _GoalsState();
}

class _GoalsState extends State<Goals> {
  final _valor = TextEditingController();
  final _wh = TextEditingController();
  double meta = 0;
  double hoje = 0;
  double percent = 0.0;
  double progress = 0.0;
  DateTime data = DateTime.now();

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
                          height: 100,
                        ),
                        //Temperatura
                        Text(
                          DateFormat("dd/MM/yyyy")
                              .format(data),
                          style: TextStyle(
                            fontSize: 40,
                            color: Colors.white,
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                        const SizedBox(
                          height: 48,
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
                         Text(
                          '${progress.toStringAsFixed(2)}%',
                          style: TextStyle(
                            fontSize: 48,
                            color: Colors.white,
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                        const SizedBox(
                          height: 26,
                        ),
                        CircularPercentIndicator(
                          radius: 110.0,
                          lineWidth: 10.0,
                          percent: percent,
                          progressColor: Colors.white,
                          backgroundColor: Color(0xFFFFFFF),
                          center: const Icon(
                            Icons.sunny,
                            size: 100.0,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 45,
                                height: 46.22,
                                child: Image.asset('assets/images/metas.png'),
                              ),
                              Padding(
                                padding: EdgeInsets.all(5),
                                child: Text(
                                  ' Meta: $meta Wh',
                                  style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w200,
                                      color: Colors.white),
                                ),
                              ),
                            ]),
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: Form(
                            child: TextFormField(
                                key: Key('goals'),
                                controller: _valor,
                                style: const TextStyle(fontSize: 22),
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelText: 'Modificar Meta',
                                  suffix: Text(
                                    'Wh',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Informe o valor da meta';
                                  } else if (double.parse(value) < 0) {
                                    return 'Meta mínima é 1Wh';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  setState(() {
                                    meta = (value.isEmpty)
                                        ? 0
                                        : double.parse(value) / 10;
                                    percent = hoje/meta;
                                  });
                                }),
                          ),
                        ),
                  Padding(
                      padding: EdgeInsets.all(10),
                      child: Form(
                        child: TextFormField(
                            key: Key('goals'),
                            controller: _wh,
                            style: const TextStyle(fontSize: 22),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              filled: true,
                              fillColor: Colors.white,
                              labelText: 'Insira Wh',
                              suffix: Text(
                                'Wh',
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Informe o valor da meta';
                              } else if (double.parse(value) < 0) {
                                return 'Meta mínima é 1Wh';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                hoje = (value.isEmpty)
                                    ? 0
                                    : double.parse(value) / 10;
                                percent = hoje/meta;
                                progress = percent*100;
                              });
                            }),
                      ),
                  )]))
            ]),
      ),
    );
  }
}
