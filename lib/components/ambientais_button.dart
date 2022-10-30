import 'package:flutter/material.dart';

// Cria um card com as informações de algum exercício
class AmbientaisButton extends StatelessWidget {
  final String nome;
  final Function onClick;

  const AmbientaisButton({
    Key? key,
    required this.nome,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Material(
        color: const Color(0xFF5BB319),
        borderRadius: BorderRadius.circular(24),
        child: InkWell(
          onTap: () => onClick(),
          child: SizedBox(
            width: 300,
            height: 150,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      nome,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.clip,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
