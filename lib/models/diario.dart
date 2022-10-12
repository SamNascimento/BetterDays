class Diario {
  final int? idDiario;
  final int idUsuario;
  final DateTime dataRegistro;
  final String titulo;
  final String nota;

  Diario(
      {required this.idUsuario,
      required this.dataRegistro,
      required this.titulo,
      required this.nota,
      this.idDiario});

  @override
  String toString() =>
      'Diário {idDiario: $idDiario, idUsuario: $idUsuario, dataRegistro: $dataRegistro, titulo: $titulo, nota: $nota}';

  Diario.fromJson(Map<String, dynamic> json)
      : idDiario = json['idDiario'],
        idUsuario = json['idUsuario'],
        dataRegistro = json['dataRegistro'],
        titulo = json['titulo'],
        nota = json['nota'];

  Map<String, dynamic> toJson() => {
        'idUsuario': idUsuario,
        'dataRegistro': dataRegistro,
        'titulo': titulo,
        'nota': nota,
      };
}
