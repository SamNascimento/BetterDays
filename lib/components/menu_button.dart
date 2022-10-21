import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  final IconData icone;
  final String nome;
  final Function onClick;

  const MenuButton(
      {Key? key,
        required this.icone,
        required this.nome,
        required this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFF7BFF17),
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        onTap: () => onClick(),
        child: SizedBox(
          height: 100,
          width: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icone,
                color: Colors.black,
                size: 48,
              ),
              Text(
                nome,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
