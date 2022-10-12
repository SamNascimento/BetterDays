class Usuario {
  final int? idUsuario;
  final String? nome;
  final String loginUsuario;
  final String senhaUsuario;

  Usuario(
      {required this.loginUsuario,
      required this.senhaUsuario,
      this.idUsuario,
      this.nome});

  @override
  String toString() =>
      'Usuário {idUsuario: $idUsuario, nome: $nome, loginUsuario: $loginUsuario, senhaUsuario: $senhaUsuario}';

  Usuario.fromJson(Map<String, dynamic> json)
      : idUsuario = json['idUsuario'],
        nome = json['nome'],
        loginUsuario = json['loginUsuario'],
        senhaUsuario = '';

  Map<String, dynamic> toJson() => {
        'nome': nome,
        'loginUsuario': loginUsuario,
        'senhaUsuario': senhaUsuario,
      };
}
