import 'package:admin_v2/Data/models/user/login/login.model.dart';
import 'package:admin_v2/Data/models/user/register/register-user.model.dart';
import 'package:admin_v2/Data/services/auth-service.dart';
import 'package:admin_v2/Presentation/Blocs/auth/auth.bloc.dart';
import 'package:admin_v2/Presentation/screens/login/bloc/login.state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Cubit<LoginState> {
  final AuthBloc authBloc;
  LoginBloc(this.authBloc) : super(LoginState());

  login(LoginDTO data) async {
    emit(state.copyWith(status: LoginStatus.loading));
    try {
      var res = await AuthService.login(data);
      authBloc.setAuthLoggedIn(res);
      emit(state.copyWith(status: LoginStatus.idle));
    } catch (_) {
      emit(state.copyWith(status: LoginStatus.error));
    }
  }

  register(RegisterUserDTO data) async {
    emit(state.copyWith(status: LoginStatus.loading));
    try {
      var res = await AuthService.register(data);
      authBloc.setAuthLoggedIn(res);
      emit(state.copyWith(status: LoginStatus.idle));
    } catch (_) {
      emit(state.copyWith(status: LoginStatus.error));
    }
  }

  logOut() async {
    try {
      await authBloc.setAuthLoggedOut();
    } catch (_) {
      throw _;
    }
  }
}
