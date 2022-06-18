import 'package:admin_v2/Data/models/credentials.dart';
import 'package:admin_v2/Data/services/api_client.dart';
import 'package:admin_v2/Data/services/app.service.dart';
import 'package:admin_v2/Data/services/auth-service.dart';
import 'package:admin_v2/Data/services/local_storage.service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_state.dart';

class AuthBloc extends Cubit<AuthState> {
  final AuthState initAppState;
  AuthBloc(this.initAppState) : super(initAppState) {
    if (this.initAppState.status == AuthStatus.authenticated) {
      this.loadIdentity();
    }
  }

  // {{baseUrl}}/auth/signup

  loadIdentity() async {
    emit(state.copyWith(identityStatus: IdentityStatus.loading));
    try {
      // test refresh
      // var identity = await TeamtimeService.getUserIdentity();
      // AppService.currentUserID.value = identity.userID;

      // FirebaseService.instance.setUser(identity.userID.toString());

      // emit(state.copyWith(
      //     identity: identity, identityStatus: IdentityStatus.idle));
    } catch (_) {
      print(_.toString());
      emit(state.copyWith(identityStatus: IdentityStatus.error));
    }
  }

  setAuthLoggedIn(Credentials credentials) async {
    try {
      var disk = (await LocalStorage.instance);
      disk?.credentials = credentials;
      ApiClient.setCredentials(credentials);
      emit(AuthState.authenticated(credentials));
      // await loadIdentity();
      // TeamtimeService.addUserDevice();
    } catch (_) {
      print(_.toString());
      setAuthLoggedOut();
    }
  }

  setAuthLoggedOut() async {
    if ((await LocalStorage.instance)!.credentials?.accessToken != null) {
      try {
        // TeamtimeService.signOut();
      } catch (_) {
        //
      }
    }
    ApiClient.setCredentials(null);
    AppService.instance.resetDisk();
    AppService.currentUserID.value = null;
    emit(AuthState.unauthenticated());
  }
}
