import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raddi_web/models/admin/admin.dart';
import 'package:raddi_web/models/generic/wrapped.dart';
import 'package:raddi_web/providers/admin_provider.dart';
import 'package:raddi_web/models/generic/generic_enums.dart';
import 'package:raddi_web/providers/auth_local_provider.dart';
import 'package:raddi_web/models/generic/data_exception_model.dart';

part 'general_state.dart';

class GeneralCubit extends Cubit<GeneralState> {
  GeneralCubit() : super(const GeneralState());

  final _adminProvider = AdminProvider();
  final _authLocalProvider = AuthLocalProvider();

  void clean() => emit(const GeneralState());

  void setGross(bool value) => emit(state.copyWith(isGross: value));

  void setPeriod(int value) => emit(state.copyWith(period: value));

  String showIncome() {
    if (state.isGross) {
      switch (state.period) {
        case 0:
          return state.income?.period?.gross?.today?.general.toString() ??
              "N/A";
        case 1:
          return state.income?.period?.gross?.week?.general.toString() ?? "N/A";
        case 2:
          return state.income?.period?.gross?.month?.general.toString() ??
              "N/A";
        default:
          return "";
      }
    } else {
      switch (state.period) {
        case 0:
          return state.income?.period?.net?.today?.general.toString() ?? "N/A";
        case 1:
          return state.income?.period?.net?.week?.general.toString() ?? "N/A";
        case 2:
          return state.income?.period?.net?.month?.general.toString() ?? "N/A";
        default:
          return "";
      }
    }
  }

  // ========================================================================
  // Home
  // ========================================================================

  void getUser() {
    emit(state.copyWith(
        user: Wrapped.value(_authLocalProvider.getCurrentUser())));
  }

  Future<void> getIncome() async {
    if (state.incomeStatus == WidgetStatus.loading) return;
    emit(state.copyWith(incomeStatus: WidgetStatus.loading));

    final response = await _adminProvider.getIncome();

    return response.fold((l) {
      emit(state.copyWith(incomeStatus: WidgetStatus.error, exception: l));
    }, (r) {
      emit(state.copyWith(
          incomeStatus: WidgetStatus.success, income: Wrapped.value(r)));
    });
  }

  Future<void> getPaymentStadistics() async {
    if (state.paymentMethodStatus == WidgetStatus.loading) return;
    emit(state.copyWith(paymentMethodStatus: WidgetStatus.loading));

    final response = await _adminProvider.getPaymentStadistics();

    return response.fold((l) {
      emit(state.copyWith(
          paymentMethodStatus: WidgetStatus.error, exception: l));
    }, (r) {
      emit(state.copyWith(
          paymentMethodStatus: WidgetStatus.success,
          payment: Wrapped.value(r)));
    });
  }

  Future<void> getStadistic() async {
    if (state.stadisticsStatus == WidgetStatus.loading) return;
    emit(state.copyWith(stadisticsStatus: WidgetStatus.loading));

    final response = await _adminProvider.getStadistic();

    return response.fold((l) {
      emit(state.copyWith(stadisticsStatus: WidgetStatus.error, exception: l));
    }, (r) {
      emit(state.copyWith(
          stadisticsStatus: WidgetStatus.success,
          stadistics: Wrapped.value(r)));
    });
  }

  Future<void> getWeeklyStadistics() async {
    if (state.weeklyStatus == WidgetStatus.loading) return;
    emit(state.copyWith(weeklyStatus: WidgetStatus.loading));

    final response = await _adminProvider.getWeeklyStadistics();

    return response.fold((l) {
      emit(state.copyWith(weeklyStatus: WidgetStatus.error, exception: l));
    }, (r) {
      emit(state.copyWith(
          weeklyStatus: WidgetStatus.success,
          weeklyStadistics: Wrapped.value(r)));
    });
  }

  Future<void> getTripsOfWeek() async {
    if (state.tripsOfWeekStatus == WidgetStatus.loading) return;
    emit(state.copyWith(tripsOfWeekStatus: WidgetStatus.loading));

    final response = await _adminProvider.getTripsOfWeek();

    return response.fold((l) {
      emit(state.copyWith(tripsOfWeekStatus: WidgetStatus.error, exception: l));
    }, (r) {
      emit(state.copyWith(
          tripsOfWeekStatus: WidgetStatus.success,
          tripsOfWeek: Wrapped.value(r)));
    });
  }
}
