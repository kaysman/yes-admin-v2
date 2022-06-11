import 'package:admin_v2/Data/services/app.service.dart';
import 'package:admin_v2/Data/services/local_storage.service.dart';
import 'package:admin_v2/environment.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EnvironmentBloc extends Cubit<AppEnvironment?> {
  EnvironmentBloc() : super(AppService.instance.env);

  toggleAppEnv() async {
    // update disk
    var disk = await (LocalStorage.instance as Future<LocalStorage>);
    var env =
        (state == AppEnvironment.dev) ? AppEnvironment.prd : AppEnvironment.dev;
    disk.env = (env == AppEnvironment.dev) ? 'dev' : 'prd';
    // update accessor
    await AppService.instance.setEnvironment();
    emit(AppService.instance.env);
  }
}

// Global app settings like (DEV or PRD) and (LIGHT or DARK)
// class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
//   AppRepository _appRepository;
//   AppEnvironment env;
//   AppTheme theme;

//   ThemeBloc(this._appRepository, {this.env, this.theme}) : super(ThemeSet());

//   @override
//   Stream<ThemeState> mapEventToState(ThemeEvent event) async* {
//     if (event is SwapTheme) {
//       yield SwappingTheme();
//       if (event.theme != null) {
//         this.theme = event.theme;
//       }
//       if (event.env != null) {
//         var disk = await LocalStorage.instance;
//         var env = (this.env == AppEnvironment.dev)
//             ? AppEnvironment.prd
//             : AppEnvironment.dev;
//         disk.env = (env == AppEnvironment.dev) ? 'dev' : 'prd';
//         await AppService.instance.setEnvironment();
//         this.env = this._appRepository.env;
//       }
//       yield ThemeSet();
//     }
//   }
// }

// abstract class ThemeEvent {}

// class SwapTheme extends ThemeEvent {
//   AppTheme theme;
//   AppEnvironment env;
//   SwapTheme({this.theme, this.env});
// }

// abstract class ThemeState {}

// class ThemeSet extends ThemeState {}

// class SwappingTheme extends ThemeState {}
