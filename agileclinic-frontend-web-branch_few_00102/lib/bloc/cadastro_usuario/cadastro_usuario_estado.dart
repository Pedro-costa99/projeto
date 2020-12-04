part of 'cadastro_usuario_bloc.dart';


abstract class CadastroUsuarioEstado extends Equatable{

  const CadastroUsuarioEstado();

  @override
  List<Object> get props => [];

}

class CadastroNaoIniciado extends CadastroUsuarioEstado{

    @override
  List<Object> get props => [];  
}


class EmailJaCadastrado extends CadastroUsuarioEstado{

    @override
  List<Object> get props => [];  
}

class EmailNaoCadastrado extends CadastroUsuarioEstado{

    @override
  List<Object> get props => [];  
}

class UsuarioCadastrado extends CadastroUsuarioEstado{

    @override
  List<Object> get props => [];  
}

class UsuarioNaoCadastrado extends CadastroUsuarioEstado{

    @override
  List<Object> get props => [];  
}