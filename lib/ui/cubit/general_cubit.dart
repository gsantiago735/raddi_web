import 'package:raddi_web/models/admin/admin.dart';
import 'package:raddi_web/models/generic/wrapped.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raddi_web/providers/admin_provider.dart';
import 'package:raddi_web/models/generic/generic_enums.dart';
import 'package:raddi_web/models/generic/data_exception_model.dart';

part 'general_state.dart';

class GeneralCubit extends Cubit<GeneralState> {
  GeneralCubit() : super(const GeneralState());

  final _adminProvider = AdminProvider();

  void clean() => emit(const GeneralState());

  // ========================================================================
  // Home
  // ========================================================================

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
}
