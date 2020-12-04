import 'package:meta/meta.dart';

/// Armazena os estados dos campos do formulário de login e seus estados.
class UsuarioLogin{
  
  final bool emailEstaValido;
  final bool senhaEstaValida;
  final bool estaLogando;
  final bool estaLogado;
  final bool estaComFalha;
  final String mensagemErro;

  UsuarioLogin({
    @required this.emailEstaValido, 
    @required this.senhaEstaValida, 
    @required this.estaLogando, 
    @required this.estaLogado, 
    @required this.estaComFalha, 
    @required this.mensagemErro
  });

  /// Determina os valores dos atributos para um login não inicializado.
  factory UsuarioLogin.naoInicializado(){
    return UsuarioLogin(
      emailEstaValido: false, 
      senhaEstaValida: false, 
      estaLogando: false, 
      estaLogado: false, 
      estaComFalha: false, 
      mensagemErro: ''      
    );
  }

  /// Determina os valores dos atributos para um login em execução.
  factory UsuarioLogin.logando(){
    return UsuarioLogin(
      emailEstaValido: true, 
      senhaEstaValida: true, 
      estaLogando: true, 
      estaLogado: false, 
      estaComFalha: false, 
      mensagemErro: ''      
    );
  }

  /// Determina os valores dos atributos para um login realizado com sucesso
  factory UsuarioLogin.logado(){
    return UsuarioLogin(
      emailEstaValido: true, 
      senhaEstaValida: true, 
      estaLogando: false, 
      estaLogado: true, 
      estaComFalha: false, 
      mensagemErro: ''      
    );
  }

  /// Determina os valores dos atributos para um login realizado com erro
  factory UsuarioLogin.falhado(String msgemErro){
    return UsuarioLogin(
      emailEstaValido: true, 
      senhaEstaValida: true, 
      estaLogando: false, 
      estaLogado: true, 
      estaComFalha: false, 
      mensagemErro: msgemErro      
    );
  }

  /// Determina os valores dos atributos para um login com Reset Solicitado
  factory UsuarioLogin.senhaResetada(){
    return UsuarioLogin(
      emailEstaValido: true, 
      senhaEstaValida: false, 
      estaLogando: false, 
      estaLogado: false, 
      estaComFalha: false, 
      mensagemErro: ''      
    );
  }

  /// Determina os valores dos atributos para um login com Reset Solicitado
  factory UsuarioLogin.resetSenhaFalhado(String msgemErro){
    return UsuarioLogin(
      emailEstaValido: true, 
      senhaEstaValida: false, 
      estaLogando: false, 
      estaLogado: false, 
      estaComFalha: true, 
      mensagemErro: msgemErro      
    );
  }
  

}