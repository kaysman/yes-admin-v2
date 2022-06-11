// import 'dart:async';

// import 'package:connectivity/connectivity.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class ConnectivityBloc extends Cubit<ConnectivityResult?> {
//   // final /*Connectivity*/ _connectivity = Connectivity();
//   // StreamSubscription<ConnectivityResult>? _connectivitySubscription;

//   ConnectivityBloc() : super(null) {
//     checkConnection();
//     _connectivitySubscription =
//         _connectivity.onConnectivityChanged.listen(setConnection);
//   }

//   // Platform messages are asynchronous, so we initialize in an async method.
//   Future<void> checkConnection() async {
//     // ConnectivityResult result;
//     // // Platform messages may fail, so we use a try/catch PlatformException.
//     // try {
//     //   result = await _connectivity.checkConnectivity();
//     //   if (this.state != result) {
//     //     setConnection(result);
//     //   } else if (result == ConnectivityResult.none) {
//     //     scheduleFutureConnectivityCheck();
//     //   }
//     // } on PlatformException catch (e) {
//     //   print(e.toString());
//     // }
//   }

//   Future<void> setConnection(ConnectivityResult result) async {
//     if (result != this.state) {
//       // if (this.state != null) {
//       //   ApiClient.reset();
//       // }
//       emit(result);
//     }
//     if (result == ConnectivityResult.none) {
//       scheduleFutureConnectivityCheck();
//     }
//   }

//   scheduleFutureConnectivityCheck() {
//     Future.delayed(const Duration(seconds: 2), () async {
//       await checkConnection();
//     });
//   }
// }
