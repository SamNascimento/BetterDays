import 'package:flutter/material.dart';

// Cria um card com as informações de algum exercício
class ExerciciosButton extends StatelessWidget {
  final String image;
  final String nome;
  final Function onClick;
  final BoxFit boxFit;

  const ExerciciosButton({
    Key? key,
    required this.image,
    required this.nome,
    required this.boxFit,
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
                  SizedBox(
                    width: 200,
                    height: 100,
                    child: Image.asset(
                      image,
                      fit: boxFit,
                    ),
                  ),
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
