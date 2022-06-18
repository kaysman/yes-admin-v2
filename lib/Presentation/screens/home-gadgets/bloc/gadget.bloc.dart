import 'package:admin_v2/Data/services/gadget.service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum GadgetCreateStatus { idle, loading, error, success }

class GadgetState {
  final GadgetCreateStatus createStatus;
  final String? errorMessage;

  GadgetState({
    this.createStatus = GadgetCreateStatus.idle,
    this.errorMessage,
  });

  GadgetState copyWith({
    GadgetCreateStatus? createStatus,
    String? errorMessage,
  }) {
    return GadgetState(
      createStatus: createStatus ?? this.createStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class GadgetBloc extends Cubit<GadgetState> {
  GadgetBloc() : super(GadgetState());

  createHomeGadget(
    List<FilePickerResult> files,
    Map<String, String> fields,
  ) async {
    emit(state.copyWith(createStatus: GadgetCreateStatus.loading));
    try {
      var res = await GadgetService.createHomeGadget(files, fields);
      emit(state.copyWith(
        createStatus: res.success == true
            ? GadgetCreateStatus.success
            : GadgetCreateStatus.idle,
      ));
    } catch (e) {
      emit(state.copyWith(
        createStatus: GadgetCreateStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }
}
