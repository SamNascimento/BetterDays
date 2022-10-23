import 'dart:async';

import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

class PomodoroScreen extends StatefulWidget {
  const PomodoroScreen({Key? key}) : super(key: key);

  @override
  State<PomodoroScreen> createState() => _PomodoroScreenState();
}

class _PomodoroScreenState extends State<PomodoroScreen> {
  Timer? contagemRegressiva;

  // Seta o tempo inicial da contagem
  int hora = 0;
  int minuto = 40;
  int segundos = 30;

  Duration duracao = const Duration();
  Duration duracaoZerada = const Duration(hours: 0, minutes: 0, seconds: 0);

  // Começa a contagem regressiva
  void comecarContagem() {
    contagemRegressiva =
        Timer.periodic(const Duration(seconds: 1), (Timer timer) => setContagem());
  }

  // Para a contagem
  void pararContagem() {
    setState(() => contagemRegressiva!.cancel());
  }

  // Acompanha a contagem para verificar se a mesma já chegou a zero, e para ela nessas condições
  void setContagem() {
    setState(() {
      if (duracao == duracaoZerada) {
        setState(() {
          contagemRegressiva!.cancel();
          vibrarAlerta();
          tocarAlerta();
        });
      } else {
        setState((){
          segundos --;

          duracao = Duration(seconds: segundos);
        });
      }
    });
  }

  // Executa alerta vribatório quando a contagem zera
  void vibrarAlerta() async {
    if (await Vibration.hasVibrator() ?? false) {
      if (await Vibration.hasCustomVibrationsSupport() ?? false) {
        Vibration.vibrate(pattern: [500, 1000, 500, 2000]);
      } else {
        Vibration.vibrate();
        await Future.delayed(const Duration(milliseconds: 500));
        Vibration.vibrate();
        await Future.delayed(const Duration(milliseconds: 500));
        Vibration.vibrate();
      }
    }
  }

  // Executa alerta sonoro, caso o celular não esteja no silencioso, quando a contagem zera
  void tocarAlerta() async {
    FlutterRingtonePlayer.play(
      android: AndroidSounds.notification,
      ios: IosSounds.glass,
      looping: true,
      volume: 1.0,
      asAlarm: false,
    );

    await Future.delayed(const Duration(seconds: 2));

    FlutterRingtonePlayer.stop();
  }

  @override
  Widget build(BuildContext context) {
    duracao = Duration(hours: hora, minutes: minuto, seconds: segundos);

    // Pega o valor da contagem em forma de String para ser exibido e dar feedback ao usuário
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final horaString = strDigits(duracao.inHours.remainder(24));
    final minutoString = strDigits(duracao.inMinutes.remainder(60));
    final segundosString = strDigits(duracao.inSeconds.remainder(60));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF304FFE),
        title: const Text('Pomodoro'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(48.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() => hora++);
                        },
                        icon: const Icon(
                          Icons.keyboard_arrow_up,
                          size: 32,
                        ),
                      ),
                      Text(
                        horaString,
                        style: const TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() => hora--);
                        },
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          size: 32,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() => minuto++);
                        },
                        icon: const Icon(
                          Icons.keyboard_arrow_up,
                          size: 32,
                        ),
                      ),
                      Text(
                        minutoString,
                        style: const TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() => minuto--);
                        },
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          size: 32,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() => segundos++);
                        },
                        icon: const Icon(
                          Icons.keyboard_arrow_up,
                          size: 32,
                        ),
                      ),
                      Text(
                        segundosString,
                        style: const TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() => segundos--);
                        },
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          size: 32,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                // Botão que inicia a contagem caso essa já não esteja iniciada
                onPressed: () {
                  if (contagemRegressiva != null) {
                    if (contagemRegressiva!.isActive) {
                      null;
                    } else{
                      comecarContagem();
                    }
                  } else {
                    comecarContagem();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5BB319),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                  textStyle: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                child: const Text('INICIAR'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              // Para a contagem
              child: ElevatedButton(
                onPressed: (){
                  if (contagemRegressiva == null || contagemRegressiva!.isActive) {
                    pararContagem();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5BB319),
                  padding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                  textStyle: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                child: const Text('PARAR'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
