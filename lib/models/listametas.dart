class ListaMetas {
  final int? idMetas;
  final int idUsuario;
  final String? dataRegistro;
  final String titulo;
  final String descricao;
  final bool isConcluido;

  ListaMetas({
    required this.idUsuario,
    required this.titulo,
    required this.descricao,
    required this.isConcluido,
    this.idMetas,
    this.dataRegistro,
  });

  @override
  String toString() =>
      'Diário {idMetas: $idMetas, idUsuario: $idUsuario, dataRegistro: $dataRegistro, titulo: $titulo, descricao: $descricao, isConcluido: $isConcluido}';

  // Transforma um JSON na classe e captura seus valores
  ListaMetas.fromJson(Map<String, dynamic> json)
      : idMetas = json['idMetas'],
        idUsuario = json['idUsuario'],
        dataRegistro = json['dataRegistro'],
        titulo = json['titulo'],
        descricao = json['descricao'],
        isConcluido = json['isConcluido'];

  // Transforma a classe em um JSON
  Map<String, dynamic> toJson() => {
        'idUsuario': idUsuario,
        'titulo': titulo,
        'descricao': descricao,
      };
}
