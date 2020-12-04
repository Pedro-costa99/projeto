// Bibliotecas externas
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:angular_router/angular_router.dart';

// Bibliotecas do projeto
import 'package:agclinic_front_web/componentes/business_entities/responses_http.dart';
import 'package:agclinic_front_web/componentes/business_entities/usuario.dart';
import 'package:agclinic_front_web/componentes/business_entities/usuario_login.dart';
import 'package:agclinic_front_web/controle_de_acesso/repositorio/usuarioRepositorio.dart';
import 'package:agclinic_front_web/routes/route_paths.dart';

// Parte da classe
part 'cadastro_usuario_estado.dart';
part 'cadastro_usuario_evento.dart';

class CadastroUsuario extends Bloc<CadastroUsuarioEvento, CadastroUsuarioEstado>{

  /// Usuário que está acessando o sistema
  var usuario = Usuario.naoInicializado();

  @override
  // TODO: implement initialState
  get initialState => CadastroNaoIniciado();

 
  @override
  Stream mapEventToState(event) async*{
    if (event is VerificaEmail){
      yield* _mapEstadoVerificaEmail();
    }    
    
  }

  Stream<CadastroUsuario> _mapEstadoVerificaEmail() async*{
    

  }


}

