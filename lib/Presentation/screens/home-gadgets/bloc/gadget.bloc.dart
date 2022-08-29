import 'package:admin_v2/Data/enums/gadget-type.dart';
import 'package:admin_v2/Data/models/gadget/gadget.model.dart';
import 'package:admin_v2/Data/models/gadget/update-gadget.model.dart';
import 'package:admin_v2/Data/models/product/pagination.model.dart';
import 'package:admin_v2/Data/services/gadget.service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum GadgetCreateStatus { idle, loading, error, success }

enum GadgetListStatus { idle, loading, error, success }

enum GetGadgetByIdStatus { idle, loading, error, success }

enum GadgetUpdatedStatus { idle, loading, error, success }

enum GadgetDeleteStatus { idle, loading, error, success }

class GadgetState {
  final List<GadgetEntity>? gadgets;
  final GadgetCreateStatus createStatus;
  final GadgetListStatus listStatus;
  final GadgetEntity? gadget;
  final GetGadgetByIdStatus getGadgetByIdStatus;
  final GadgetUpdatedStatus updatedStatus;
  final GadgetDeleteStatus deleteStatus;
  final List<GadgetEntity>? filteredGadgets;
  final String? errorMessage;

  GadgetState({
    this.gadgets,
    this.createStatus = GadgetCreateStatus.idle,
    this.listStatus = GadgetListStatus.idle,
    this.getGadgetByIdStatus = GetGadgetByIdStatus.idle,
    this.updatedStatus = GadgetUpdatedStatus.idle,
    this.deleteStatus = GadgetDeleteStatus.idle,
    this.gadget,
    this.errorMessage,
    this.filteredGadgets,
  });

  GadgetState copyWith({
    List<GadgetEntity>? gadgets,
    GadgetCreateStatus? createStatus,
    String? errorMessage,
    GadgetListStatus? listStatus,
    GetGadgetByIdStatus? getGadgetByIdStatus,
    GadgetEntity? gadget,
    GadgetUpdatedStatus? updatedStatus,
    GadgetDeleteStatus? deleteStatus,
    List<GadgetEntity>? filteredGadgets,
  }) {
    return GadgetState(
      createStatus: createStatus ?? this.createStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      listStatus: listStatus ?? this.listStatus,
      gadgets: gadgets ?? this.gadgets,
      getGadgetByIdStatus: getGadgetByIdStatus ?? this.getGadgetByIdStatus,
      deleteStatus: deleteStatus ?? this.deleteStatus,
      updatedStatus: updatedStatus ?? this.updatedStatus,
      gadget: gadget ?? this.gadget,
      filteredGadgets: filteredGadgets ?? this.filteredGadgets,
    );
  }
}

class GadgetBloc extends Cubit<GadgetState> {
  GadgetBloc() : super(GadgetState());

  createHomeGadget(
    List<FilePickerResult?> files,
    Map<String, String> fields,
  ) async {
    emit(state.copyWith(createStatus: GadgetCreateStatus.loading));
    try {
      var res = await GadgetService.createHomeGadget(files, fields);
      if (res.success == true) {
        emit(state.copyWith(createStatus: GadgetCreateStatus.success));
        getAllGadgets();
      }
    } catch (e) {
      print(e);
      emit(state.copyWith(
        createStatus: GadgetCreateStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  getGadgetById(int id) async {
    emit(state.copyWith(getGadgetByIdStatus: GetGadgetByIdStatus.loading));
    try {
      var res = await GadgetService.getGadgetById(id);
      emit(state.copyWith(
        getGadgetByIdStatus: GetGadgetByIdStatus.success,
        gadget: res,
      ));
    } catch (_) {
      emit(state.copyWith(
        getGadgetByIdStatus: GetGadgetByIdStatus.error,
        errorMessage: _.toString(),
      ));
      print(_);
    }
  }

  updateGadget(UpdateGadgetModel data) async {
    emit(state.copyWith(updatedStatus: GadgetUpdatedStatus.loading));
    try {
      var res = await GadgetService.upDateGadget(data);
      if (res.success == true) {
        emit(state.copyWith(
          updatedStatus: GadgetUpdatedStatus.success,
        ));
        getAllGadgets();
      }
    } catch (_) {
      emit(state.copyWith(
        updatedStatus: GadgetUpdatedStatus.error,
        errorMessage: _.toString(),
      ));
      print(_);
    }
  }

  deleteGadget(int id) async {
    emit(state.copyWith(deleteStatus: GadgetDeleteStatus.loading));
    try {
      var res = await GadgetService.deleteGadget(id);
      if (res.success == true) {
        emit(state.copyWith(
          deleteStatus: GadgetDeleteStatus.success,
        ));
        getAllGadgets();
      }
    } catch (_) {
      emit(state.copyWith(
        deleteStatus: GadgetDeleteStatus.error,
        errorMessage: _.toString(),
      ));
      print(_);
    }
  }

  getAllGadgets(
      {PaginationDTO? filter,
      bool subtle = false,
      String? location,
      String? status}) async {
    emit(state.copyWith(listStatus: GadgetListStatus.loading));

    if (filter == null) {
      filter = PaginationDTO();
    }
    try {
      var res = await GadgetService.getAllGadgets(filter.toJson());
      var filteredGadgets = getGadgetsByLocationAndStatus(
        res,
        location,
        status,
      );
      emit(state.copyWith(
        gadgets: res,
        filteredGadgets: filteredGadgets,
        listStatus: GadgetListStatus.idle,
      ));
    } catch (_) {
      print(_);
      emit(state.copyWith(listStatus: GadgetListStatus.error));
    }
  }
}

///
//* GET FILTERED GADGETS
///
getGadgetsByLocationAndStatus(
    List<GadgetEntity> gadgets, String? location, String? status) {
  return gadgets
      .where((el) => el.location == location && el.status == status)
      .toList();
}

// getGadgetsByLocationOfStatus(List<GadgetEntity> gadgets) {
//   List<GadgetEntity> activeGadgetsOfHome =
//       getGadgetsByLocation(gadgets, GadgetLocation.HOME, GadgetStatus.ACTIVE);
//   List<GadgetEntity> inActiveGadgetsOfHome =
//       getGadgetsByLocation(gadgets, GadgetLocation.HOME, GadgetStatus.INACTIVE);
//   List<GadgetEntity> activeGadgetsOfCategory = getGadgetsByLocation(
//       gadgets, GadgetLocation.CATEGORY, GadgetStatus.ACTIVE);
//   List<GadgetEntity> inActiveGadgetsOfCategory = getGadgetsByLocation(
//       gadgets, GadgetLocation.CATEGORY, GadgetStatus.INACTIVE);

//   return {
//     'Home': {
//       'active': activeGadgetsOfHome,
//       'in active': inActiveGadgetsOfHome,
//     },
//     'Category': {
//       'active': activeGadgetsOfCategory,
//       'in active': inActiveGadgetsOfCategory,
//     },
//   };
// }
