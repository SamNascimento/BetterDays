class ListaMetas {
  final int? idMetas;
  final int idUsuario;
  final DateTime dataRegistro;
  final String titulo;
  final String descricao;
  final bool isConcluido;

  ListaMetas(
      {required this.idUsuario,
      required this.dataRegistro,
      required this.titulo,
      required this.descricao,
      required this.isConcluido,
      this.idMetas});

  @override
  String toString() =>
      'Diário {idMetas: $idMetas, idUsuario: $idUsuario, dataRegistro: $dataRegistro, titulo: $titulo, descricao: $descricao, isConcluido: $isConcluido}';

  ListaMetas.fromJson(Map<String, dynamic> json)
      : idMetas = json['idMetas'],
        idUsuario = json['idUsuario'],
        dataRegistro = json['dataRegistro'],
        titulo = json['titulo'],
        descricao = json['descricao'],
        isConcluido = json['isConcluido'];

  Map<String, dynamic> toJson() => {
        'idUsuario': idUsuario,
        'dataRegistro': dataRegistro,
        'titulo': titulo,
        'descricao': descricao,
        'isConcluido': isConcluido,
      };
}
