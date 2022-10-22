import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';

class AlarmeScreen extends StatelessWidget {
  const AlarmeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF304FFE),
          title: const Text('Better Days'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: ElevatedButton(
                  onPressed: FlutterAlarmClock.showAlarms,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5BB319),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                    textStyle: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  child: const Text('CRIAR ALARME'),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(24.0),
                child: Text(
                  'Recomendamos que defina um horário fixo para deitar na cama todos os dias, '
                  'assim como um horário fixo para acordar, regulando assim seus hormônios e fazendo '
                  'seu sono render mais',
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
        ));
  }
}
