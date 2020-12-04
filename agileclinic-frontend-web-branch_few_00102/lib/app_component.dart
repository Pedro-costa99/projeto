import 'package:agclinic_front_web/controle_de_acesso/bloc/controle_acesso_bloc.dart';
import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

import 'package:agclinic_front_web/routes/routes.dart';
import 'package:agclinic_front_web/utils/utils.dart';

@Component(
  selector: 'my-app',
  styleUrls: ['app_component.css'],
  templateUrl: 'app_component.html',
  directives: [coreDirectives, routerDirectives],
  exports: [Routes],
  providers: [ClassProvider(Utils)],  
)
class AppComponent implements OnInit{

  /// Contém as rotas para os componentes.
  final Router _router;

  /// Controla o acesso ao sistema.
  final controleAccessoBloc = ControleAccessoBloc.instancia;

  /// Construtor da classe.
  /// 
  /// Recebe [_router] que contém a lista e rotas de acesso aos componentes da aplicação.
  AppComponent(this._router);

  
  /// Segunda Etapa do ciclo de vida do código executada, executada após todas as variáveis
  /// de entrada da classe forem criadas e definidas.
  @override
  void ngOnInit() {

    //var usrRep = UsuarioRepositorio();
    //usrRep.limpaAutenticacaoUsuario();


    /// Define as rotas a serem utilizada no objeto bloc.
    controleAccessoBloc.router = _router;

    /// Executa o processo de início da aplicação.
    controleAccessoBloc.add(IniciarAplicacao());
  }
}
