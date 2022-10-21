import 'package:flutter/material.dart';

class AlarmButton extends StatelessWidget {
  final String nome;
  final Function onClick;

  const AlarmButton({Key? key, required this.nome, required this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFF5BB319),
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        onTap: () => onClick(),
        child: SizedBox(
          height: 100,
          width: 320,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    nome,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Text('D',
                          style:
                              TextStyle(color: Colors.white60, fontSize: 16)),
                      Text('S',
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                      Text('T',
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                      Text('Q',
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                      Text('Q',
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                      Text('S',
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                      Text('S',
                          style:
                              TextStyle(color: Colors.white60, fontSize: 16)),
                    ],
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('22:00',
                          style: TextStyle(color: Colors.white, fontSize: 32)),
                      Icon(Icons.nights_stay_outlined,
                          color: Colors.white, size: 24),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('05:00',
                          style: TextStyle(color: Colors.white, fontSize: 32)),
                      Icon(Icons.sunny, color: Colors.white, size: 24),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
