import 'package:admin_v2/Data/services/auth-service.dart';
import 'package:admin_v2/Presentation/Blocs/auth/auth.bloc.dart';
import 'package:admin_v2/Presentation/screens/login/bloc/login.state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Cubit<LoginState> {
  final AuthBloc authBloc;
  LoginBloc(this.authBloc) : super(LoginState());

  login(String phone, String password) async {
    emit(state.copyWith(status: LoginStatus.loading));
    try {
      // var res = await AuthService.login(phone, password);

      // authBloc.setAuthLoggedIn(phone, password);
      emit(state.copyWith(status: LoginStatus.idle));
    } catch (_) {
      emit(state.copyWith(status: LoginStatus.error));
    }
  }

  // logOut() async {
  //   try {
  //     await authBloc.setlogOut();
  //   } catch (_) {
  //     throw _;
  //   }
  // }
}
