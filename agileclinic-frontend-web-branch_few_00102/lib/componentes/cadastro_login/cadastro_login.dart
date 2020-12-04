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
  selector: 'cadastro-login-page',
  templateUrl: 'cadastro_login.html',
  styleUrls: ['cadastro_login.css'],
  directives: [coreDirectives, routerDirectives, formDirectives],
  exports: [RoutePaths, Routes],
)
class CadastroLogin implements OnActivate {

  /// Executado após a árvore DOM estar completamente carredada
  @override
  void onActivate(RouterState previous, RouterState current) {

    /// chama função de validação de email a cada tecla digitada
    var inputEmail = document.getElementById('emailu');
    inputEmail.onKeyUp.listen(validaEmail);   


  }


  /// controla se o email é valido.
  bool inputEmailValido = false;

  /// Controla de a senha é válida.
  bool inputSenhaValido = false;

  /// Elemento modal que mostra as mesagens de erro ao realizar o Login.
  @ViewChild('modalRespLogin')
  Element modalRespLogin;

    /// Rotas da aplicação
  final Router _router; 

  /// Email digitado pelo usuário
  String email;

  /// Senha digitada pelo usuário
  String senha;

 final controleAcessoBloc = ControleAccessoBloc.instancia;

  /// Construtor que recebe [Router] como parâmetro
  CadastroLogin(this._router);

  /// Verifica se o email passado já existe.
  ///
  /// É executado quando o usuário clica no botão de Login
  /// [_loginBloc] é o objeto Bloc responsável pela implementação das regras de negócio
  void verificaEmail() async{ 

    controleAcessoBloc.usuario.email = email;

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

   void alternaTelaCadastro(String telaDestino){

    var formCadastroEmail = document.getElementById('form-cadastro-email');

    var formCadastroDados = document.getElementById('form-cadastro-dados');

    var formCadastroPerfil = document.getElementById('form-cadastro-profissional');

    var itemLinkEmail = document.getElementById('item-link-email');

    var itemLinkDados = document.getElementById('item-link-dados');

    var itemLinkPerfil = document.getElementById('item-link-perfil');

    if (telaDestino == 'email'){
      formCadastroEmail.style.display = 'block';
      formCadastroDados.style.display = 'none';  
      formCadastroPerfil.style.display = 'none';  
      itemLinkEmail.classes.add('item-link-login-ativo');        
      itemLinkEmail.classes.remove('item-link-login-desativo');
      itemLinkDados.classes.remove('item-link-login-ativo');        
      itemLinkDados.classes.add('item-link-login-desativo');        
      itemLinkPerfil.classes.remove('item-link-login-ativo');        
      itemLinkPerfil.classes.add('item-link-login-desativo');        
    } else if(telaDestino == 'dados'){
      formCadastroEmail.style.display = 'none';
      formCadastroDados.style.display = 'block';  
      formCadastroPerfil.style.display = 'none';  
      formCadastroPerfil.classes.add('item-link-login-ativo');        
      itemLinkDados.classes.add('item-link-login-ativo');        
      itemLinkDados.classes.remove('item-link-login-desativo');
      itemLinkEmail.classes.remove('item-link-login-ativo');        
      itemLinkEmail.classes.add('item-link-login-desativo');        
      itemLinkPerfil.classes.remove('item-link-login-ativo');        
      itemLinkPerfil.classes.add('item-link-login-desativo');  
    } else if(telaDestino == 'perfil'){
      formCadastroEmail.style.display = 'none';
      formCadastroDados.style.display = 'none';  
      formCadastroPerfil.style.display = 'block';  
      itemLinkPerfil.classes.add('item-link-login-ativo');        
      itemLinkPerfil.classes.remove('item-link-login-desativo');
      itemLinkDados.classes.remove('item-link-login-ativo');        
      itemLinkDados.classes.add('item-link-login-desativo');        
      itemLinkEmail.classes.remove('item-link-login-ativo');        
      itemLinkEmail.classes.add('item-link-login-desativo');  
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

