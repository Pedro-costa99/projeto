import 'dart:convert';

/// Usuário que está acessando o sistema.
/// 
/// Armazena os atributos do usuário que está acessando o sistema.
class Usuario{

  /// identificação do usuário
  int _id = 0;

  /// nome do usuário
  String _nomeUsuario = '';

  /// emai do usuário
  String _email = '';

  /// token de acesso recebido do servidor de autenticação
  String _token = '';

  /// senha de acesso ao sistema
  String _senha = '';

  /// telefone de cadastro do usuário
  String _telefone = '';

 

  /// profissao do usuario
  String _profissao = '';


  /// Conselho
  String _conselho = '';


  /// Número do Conselho
  String _codigoConselho = '';


  /// Flag para habilite salvar ou não o token de conexão
  bool _manterConectado = false;

  /// Construtor padrão que defini o usuário com atributos iniciais
  Usuario.naoInicializado();

  int get id{
    return _id;
  }

  set id (int id){
    _id = id;
  }

  String get nomeUsuario{
    return _nomeUsuario;
  }

  set nomeUsuario (String nomeUsuario){
    _nomeUsuario = nomeUsuario;
  }

  String get email{
    return _email;
  }

  set email (String email){
    _email = email;
  }


  String get token{
    return _token;
  }

  set token(String token){
    _token = token;
  }

  String get senha{
    return _senha;
  }

  set senha(String senha){
    _senha = senha;
  }

  bool get manterConectado{
    return _manterConectado;
  }

  set manterConectado(bool manterConectado){
    _manterConectado = manterConectado;
  }

  String get codigoConselho{
    return _codigoConselho;
  }

  set codigoConselho(String codigoConselho){
    _codigoConselho = codigoConselho;
  }

  String get conselho{
    return _conselho;
  }

  set conselho(String conselho){
    _conselho = conselho;
  }
    String get profissao{
    return _profissao;
  }

  set profissao(String profissao){
    _profissao = profissao;
  }

  String get telefone{
    return _telefone;
  }

  set telefone(String telefone){
    _telefone = telefone;
  }

  /// Cria objeto a partir de objeto Jason.
  Usuario.fromJSON(String jsonString) {
    Map usuarioStorage = json.decode(jsonString);
    _id = int.tryParse(usuarioStorage['id']);
    _nomeUsuario = usuarioStorage['nomeUsuario'];
    _email = usuarioStorage['email'];
    _token = usuarioStorage['token'];
    _senha = usuarioStorage['senha'];
    _manterConectado  = usuarioStorage['manterConectado'];
  }

  /// Converte o objeto em um objeto Jason
  String get jsonString =>
  json.encode(
  {
    'id': _id.toString(),
    'nomeUsuario': _nomeUsuario,
    'email': _email,
    'senha': _senha,
    'token': _token,
    'manterConectado': _manterConectado,    
  });  

}