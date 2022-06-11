import 'dart:io';

import 'package:admin_v2/Data/services/notification.service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationBloc extends Cubit<NotificationState> {
  NotificationBloc()
      : super(NotificationState(status: NotificationStatus.idle)) {
    flutterLocalNotificationsPlugin.cancelAll();
  }

  presentActiveTime(activeLog, int? teamId) async {
    if (Platform.isIOS) {
      var canShow = await Permission.notification.isGranted;
      if (!canShow) return;
    }

    // await NotificationService.initActiveTimer(activeLog, teamId);

    emit(
      state.copyWith(
        status: NotificationStatus.active,
        activeLog: activeLog,
      ),
    );
  }

  clearNotifications() {
    NotificationService.clearNotifications();
    emit(state.copyWith(status: NotificationStatus.idle, activeLog: null));
  }
}

enum NotificationStatus { idle, active }

class NotificationState {
  final NotificationStatus? status;
  final activeLog;

  NotificationState({this.status, this.activeLog});
  NotificationState copyWith({NotificationStatus? status, activeLog}) {
    return NotificationState(
      status: status ?? this.status,
      activeLog: activeLog ?? this.activeLog,
    );
  }
}
