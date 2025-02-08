part of 'general_cubit.dart';

class GeneralState extends Equatable {
  const GeneralState({
    this.exception,
    this.incomeStatus = WidgetStatus.initial,
    this.paymentMethodStatus = WidgetStatus.initial,
    this.stadisticsStatus = WidgetStatus.initial,
    this.income,
    this.stadistics,
    this.payment,
  });

  // General
  final DataException? exception;

  // Home
  final WidgetStatus incomeStatus;
  final WidgetStatus paymentMethodStatus;
  final WidgetStatus stadisticsStatus;

  final IncomeResponseModel? income;
  final StadisticsResponseModel? stadistics;
  final List<PaymentStadisticsResponseModel>? payment;

  @override
  List<Object?> get props => [
        exception,
        incomeStatus,
        paymentMethodStatus,
        stadisticsStatus,
        income,
        stadistics,
        payment,
      ];

  GeneralState copyWith({
    DataException? exception,
    WidgetStatus? incomeStatus,
    WidgetStatus? paymentMethodStatus,
    WidgetStatus? stadisticsStatus,
    Wrapped<IncomeResponseModel?>? income,
    Wrapped<StadisticsResponseModel?>? stadistics,
    Wrapped<List<PaymentStadisticsResponseModel>?>? payment,
  }) {
    return GeneralState(
      exception: exception ?? this.exception,
      incomeStatus: incomeStatus ?? this.incomeStatus,
      paymentMethodStatus: paymentMethodStatus ?? this.paymentMethodStatus,
      stadisticsStatus: stadisticsStatus ?? this.stadisticsStatus,
      income: income != null ? income.value : this.income,
      stadistics: stadistics != null ? stadistics.value : this.stadistics,
      payment: payment != null ? payment.value : this.payment,
    );
  }
}
