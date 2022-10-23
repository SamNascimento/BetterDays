class Diario {
  final int? idDiario;
  final int idUsuario;
  final String? dataRegistro;
  final String titulo;
  final String nota;

  Diario({
    required this.idUsuario,
    required this.titulo,
    required this.nota,
    this.dataRegistro,
    this.idDiario,
  });

  @override
  String toString() =>
      'Diário {idDiario: $idDiario, idUsuario: $idUsuario, dataRegistro: $dataRegistro, titulo: $titulo, nota: $nota}';

  // Transforma um JSON na classe e captura seus valores
  Diario.fromJson(Map<String, dynamic> json)
      : idDiario = json['idDiario'],
        idUsuario = json['idUsuario'],
        dataRegistro = json['dataRegistro'],
        titulo = json['titulo'],
        nota = json['nota'];

  // Transforma a classe em um JSON
  Map<String, dynamic> toJson() => {
        'idUsuario': idUsuario,
        'titulo': titulo,
        'nota': nota,
      };
}
