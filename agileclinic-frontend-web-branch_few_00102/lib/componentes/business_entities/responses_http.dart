/// Token de autenticação recebido do sistema de autenticação
class ResponseTokenAutenticacao {
  /// identificação do usuário 
  final int id;

  /// Token de acesso.
  final String access_token;

  /// Token de refresh.
  final String refresh_token;

  ResponseTokenAutenticacao({this.id, this.access_token, this.refresh_token});

  /// Cria objeto a partir do objeto jason.
  factory ResponseTokenAutenticacao.fromJson(Map<String, dynamic> json) {
    return ResponseTokenAutenticacao(
      access_token: json['access_token'],
      refresh_token: json['refresh_token'],
    );
  }
}