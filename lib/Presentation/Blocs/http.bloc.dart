import 'dart:async';

import 'package:bloc/bloc.dart';

class HttpRequestState {
  final List<String> requests;
  HttpRequestState(this.requests);
}

class HttpRequestBloc extends Cubit<HttpRequestState> {
  HttpRequestBloc() : super(HttpRequestState([]));

  add(String uri) {
    // print('adding uri $uri');
    emit(HttpRequestState([uri, ...state.requests]));
    print(state.requests);
  }

  remove(String uri) {
    // print('removing uri $uri');
    emit(HttpRequestState(state.requests.where((r) => r != uri).toList()));
    print(state.requests);
  }

  clear() {
    emit(HttpRequestState([]));
  }
}
