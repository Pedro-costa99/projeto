import 'dart:html';

import 'package:agclinic_front_web/controle_de_acesso/bloc/controle_acesso_bloc.dart';
import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:angular_forms/angular_forms.dart';

import 'package:agclinic_front_web/utils/utils.dart';
import 'package:agclinic_front_web/routes/routes.dart';
import 'package:agclinic_front_web/componentes/business_entities/usuario.dart';


@Component(
  selector: 'navbar',
  templateUrl: 'navbar.html',
  styleUrls: ['navbar.css'],
  directives: [coreDirectives, routerDirectives, formDirectives],
  exports: [RoutePaths, Routes]
)
class Navbar extends OnInit{

  @ViewChild('navBurger')
  Element navBurger; // Referência do botão "hamburguer" do arquivo html
  @ViewChild('navMenu')
  Element navMenu; // Referência do menu do arquivo html

  Usuario usr = Usuario.naoInicializado();

  final Router _router; // Variável do angular responsável pelo roteamento

  Utils utils; // Classe utils que será injetada na class utilizando a injeção de dependência do angular

  Navbar(this._router, this.utils); // Construtor

  @override
  void ngOnInit() { // Ao iniciar o componente, verificar se existe o token na memória do navegador para ver se o usuário está ou não logado


  }

  toggleNavbar() { // Método responsável para mostrar ou não os botões no modo mobile
    this.navBurger.classes.toggle('is-active');
    this.navMenu.classes.toggle('is-active');
  }

  solicitaLogout(){ // Método responsável pelo logoff do usuário
    var controleAcessoBloc = ControleAccessoBloc.instancia;
    controleAcessoBloc.add(SolicitarLogout());
  }

  testePainel() async {
    await _router.navigate(RoutePaths.login.toUrl());
  }

}
