import 'package:admin_v2/Data/models/credentials.dart';
import 'package:admin_v2/Data/models/user.dart';

enum AuthStatus { authenticated, unauthenticated }

enum IdentityStatus { idle, loading, error }

class AuthState {
  final AuthStatus? status;
  final Credentials? credentials;
  final IdentityStatus? identityStatus;
  final UserIdentity? identity;

  AuthState(
      {this.status, this.credentials, this.identityStatus, this.identity});

  AuthState.authenticated(Credentials? credentials)
      : credentials = credentials,
        status = AuthStatus.authenticated,
        identityStatus = IdentityStatus.loading,
        identity = null;

  AuthState.unauthenticated()
      : status = AuthStatus.unauthenticated,
        credentials = null,
        identityStatus = IdentityStatus.idle,
        identity = null;

  AuthState copyWith(
      {Credentials? auth,
      AuthStatus? status,
      UserIdentity? identity,
      IdentityStatus? identityStatus}) {
    return AuthState(
        credentials: credentials ?? this.credentials,
        status: status ?? this.status,
        identityStatus: identityStatus ?? this.identityStatus,
        identity: identity ?? this.identity);
  }
}
