/// Bibliotecas externas
import 'dart:html' hide Client;
import 'dart:async';
import 'package:agclinic_front_web/componentes/business_entities/usuario_login.dart';
import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:angular_forms/angular_forms.dart';

/// bibliotecas internas
import 'package:agclinic_front_web/routes/routes.dart';
import 'package:agclinic_front_web/routes/route_paths.dart';
import 'package:agclinic_front_web/controle_de_acesso/validadores_acesso.dart';
import 'package:agclinic_front_web/controle_de_acesso/bloc/controle_acesso_bloc.dart';

/// Gerencia os eventos da tela de login do sistema.
/// 
@Component(
  selector: 'login-page',
  templateUrl: 'login.html',
  styleUrls: ['login.css'],
  directives: [coreDirectives, routerDirectives, formDirectives],
  exports: [RoutePaths, Routes],
)
class Login implements OnActivate {

  /// Executado após a árvore DOM estar completamente carredada
  @override
  void onActivate(RouterState previous, RouterState current) {

    /// chama função de validação de email a cada tecla digitada
    var inputEmail = document.getElementById('emailu');
    inputEmail.onKeyUp.listen(validaEmail);   

    /// chama função de validação de email a cada tecla digitada
    var inputEmailReset = document.getElementById('emailur');
    inputEmailReset.onKeyUp.listen(validaEmailReset);     

    /// chama função de validação de senha a cada tecla digitada
    var inputSenha = document.getElementById('senhaId');
    inputSenha.onKeyUp.listen(validaSenha);

    /// chama função para controlar de manutenção do usuário conectado
    var checkConectado = document.getElementById('switchConectado');
    checkConectado.onChange.listen(controlaConectado);

    /// Necessário essa configuração aqui, devido ao processo de carga dos ícones
    /// do font awesome dificultar a sua estilização através do css
    configuraStiloPrepandInput();

    alternaLoginReset('login');

  }

  /// controla a manutenção do usuário logado no sistema
  bool manterConectado = false;

  /// controla se o email é valido.
  bool inputEmailValido = false;

  /// controla se o email é valido do form Reset de Senha.
  bool inputEmailValidoReset = false;  

  /// Controla de a senha é válida.
  bool inputSenhaValido = false;

  /// Elemento modal que mostra as mesagens de erro ao realizar o Login.
  @ViewChild('modalRespLogin')
  Element modalRespLogin;

  @ViewChild('modalRespReset')
  Element modalRespReset;
   
  /// Rotas da aplicação
  final Router _router; 

  /// Email digitado pelo usuário
  String email;

    /// Email digitado pelo usuário para o reset de senha
  String emailReset;

  /// Senha digitada pelo usuário
  String senha;

 final controleAcessoBloc = ControleAccessoBloc.instancia;

  /// Construtor que recebe [Router] como parâmetro
  Login(this._router);

  /// Realiza o login na aplicação.
  ///
  /// É executado quando o usuário clica no botão de Login
  /// [_loginBloc] é o objeto Bloc responsável pela implementação das regras de negócio
  void efetuarLogin() async{ 

    controleAcessoBloc.usuario.email = email;
    controleAcessoBloc.usuario.senha = senha;

    var mostroModalMsg = false;    

    var contatorLoopListen = 0;

    controleAcessoBloc.add(SolicitarLogin());
    controleAcessoBloc.listen((state)async{
      if (state is Logado && !mostroModalMsg && contatorLoopListen != 0){
        mostroModalMsg = true;
        await controleAcessoBloc.router.navigate(RoutePaths.painel.toUrl());
      } else if (state is LoginFalhado && !mostroModalMsg && contatorLoopListen != 0){
        mostroModalMsg = true;
        /// Objeto [LoginUsuario]
        var loginUsuario = state.props[1] as UsuarioLogin;
        await mostraModalErro(loginUsuario.mensagemErro);
      }
      contatorLoopListen++;
    });
  }

 /// Realiza o login na aplicação.
  ///
  /// É executado quando o usuário clica no botão de Login
  /// [_loginBloc] é o objeto Bloc responsável pela implementação das regras de negócio
  void resetSenha() async{ 

    controleAcessoBloc.usuario.email = emailReset;

    var mostroModalMsg = false;

    var contatorLoopListen = 0;

    controleAcessoBloc.add(SolicitarResetSenha());
       
    controleAcessoBloc.listen(
      (state)async{
        if (state is SenhaResetada && !mostroModalMsg && contatorLoopListen != 0){
           mostroModalMsg = true;
           contatorLoopListen = 0;
          await mostraModalReset('Nova senha enviada para o email cadastrado!', false);
        } else if (state is ResetSenhaFalahado  && !mostroModalMsg && contatorLoopListen != 0){
          /// Objeto [LoginUsuario]
          mostroModalMsg = true;
          contatorLoopListen = 0;
          var loginUsuario = state.props[1] as UsuarioLogin;
          await mostraModalReset(loginUsuario.mensagemErro, true);
        }
        contatorLoopListen++;
      },
    );
 


  }


  /// Mostra o modal com erro se o login não for bem sucedido
  Future<void> mostraModalReset(String msgFailure, bool existeErro) async {
    modalRespReset.text = '';
    if (existeErro){
      modalRespReset.classes.add('alert-warning');
      modalRespReset.classes.remove('alert-success');
    } else{
      modalRespReset.classes.remove('alert-warning');
      modalRespReset.classes.add('alert-success');
    }
    modalRespReset.style
        ..display = 'block';  
    modalRespReset.text = msgFailure;
    await Future.delayed(const Duration(seconds : 3));
    modalRespReset.text = '';
    modalRespReset.style
        ..display = 'none';    

  }


  /// Mostra o modal com erro se o login não for bem sucedido
  Future<void> mostraModalErro(String msgFailure) async {
    modalRespLogin.style
        ..display = 'block';  
    modalRespLogin.text = msgFailure;
    await Future.delayed(const Duration(seconds : 3));
    modalRespLogin.style
        ..display = 'none';    
  }

  /// Verifica se o email passado é válido
  void validaEmail(Event e){
    var inputEmail = (document.getElementById('emailu') as InputElement);
    var iconCheckEmail = document.getElementById('icon-check-email');
    var emailValido = Validadores.isValidEmail(inputEmail.value);
    inputEmailValido = alternaAtivacaoEmail(emailValido, inputEmail, iconCheckEmail);
  }

  /// Verifica se o email passado é válido
  void validaEmailReset(Event e){
    var inputEmailReset = (document.getElementById('emailur') as InputElement);
    var iconCheckEmailReset = document.getElementById('icon-check-emailr');
    var emailValidoReset = Validadores.isValidEmail(inputEmailReset.value);
    inputEmailValidoReset = alternaAtivacaoEmail(emailValidoReset, inputEmailReset, iconCheckEmailReset);
  }


  bool alternaAtivacaoEmail(bool emailValidoSel, InputElement inputEmailSel, Element iconCheckEmailSel){
    if (emailValidoSel){
      inputEmailSel.classes.add('is-valid');
      return true;
    } else{
      inputEmailSel.classes.remove('is-valid');
      return false;
    }
  }

  /// Verifica se a senha passada é válida
  void validaSenha(Event e){
    var inputSenha = (document.getElementById('senhaId') as InputElement);
    if (inputSenha.value.length > 3){
      inputSenha.classes.add('is-valid');
      inputSenhaValido = true;
    } else{
      inputSenha.classes.remove('is-valid');
      inputSenhaValido = false;
    }
  }


  void alternaLoginReset(String telaDestino){

    var formLogin = document.getElementById('formLogin');

    var formReset = document.getElementById('formReset');

    var itemLinkLogin = document.getElementById('item-link-login');

    var itemLinkReset = document.getElementById('iten-link-reset');

    if (telaDestino == 'login'){
      formLogin.style
        ..display = 'block';
      formReset.style
        ..display = 'none';  
      itemLinkLogin.classes.add('item-link-login-ativo');        
      itemLinkLogin.classes.remove('item-link-login-desativo');
      itemLinkReset.classes.remove('item-link-login-ativo');        
      itemLinkReset.classes.add('item-link-login-desativo');        
    } else{
      formLogin.style
        ..display = 'none';
      formReset.style
        ..display = 'block';              
      itemLinkReset.classes.add('item-link-login-ativo');        
      itemLinkReset.classes.remove('item-link-login-desativo');   
      itemLinkLogin.classes.remove('item-link-login-ativo');        
      itemLinkLogin.classes.add('item-link-login-desativo');           
    }

  }

  /// Controla se o usuário vai permanecer conectado no sistema
  void controlaConectado(Event e){
    controleAcessoBloc.usuario.manterConectado = controleAcessoBloc.usuario.manterConectado == false ? true : false;
  }

    /// Configura o estilo dos ícones do fonte awesome no prepand dos inputs
    /// 
    /// Necessário essa configuração aqui, devido ao processo de carga dos ícones
    /// do font awesome dificultar a sua estilização através do css
    void configuraStiloPrepandInput(){
      var prePandInput = document.getElementsByClassName('input-group-text');
      for (var elemento in prePandInput){
        var elem = elemento as Element;
        elem.style.backgroundColor = '#1bd16c';
        elem.style.borderColor = '#1bd16c';
        elem.style.border = '1px solid transparent';
      }
    }


}

