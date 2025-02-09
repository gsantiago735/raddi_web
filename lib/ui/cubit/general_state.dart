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
    this.isGross = true,
    this.period = 1,
    this.weeklyStadistics,
    this.weeklyStatus = WidgetStatus.initial,
    this.user,
  });

  // General
  final DataException? exception;

  // Home
  final User? user;
  final WidgetStatus incomeStatus;
  final WidgetStatus paymentMethodStatus;
  final WidgetStatus stadisticsStatus;
  final WidgetStatus weeklyStatus;

  final bool isGross;
  final int period;

  final IncomeResponseModel? income;
  final StadisticsResponseModel? stadistics;
  final List<PaymentStadisticsResponseModel>? payment;
  final List<WeeklyResponseModel>? weeklyStadistics;

  @override
  List<Object?> get props => [
        exception,
        incomeStatus,
        paymentMethodStatus,
        stadisticsStatus,
        income,
        stadistics,
        payment,
        isGross,
        period,
        weeklyStadistics,
        weeklyStatus,
        user,
      ];

  GeneralState copyWith({
    DataException? exception,
    WidgetStatus? incomeStatus,
    WidgetStatus? paymentMethodStatus,
    WidgetStatus? stadisticsStatus,
    Wrapped<IncomeResponseModel?>? income,
    Wrapped<StadisticsResponseModel?>? stadistics,
    Wrapped<List<PaymentStadisticsResponseModel>?>? payment,
    bool? isGross,
    int? period,
    Wrapped<List<WeeklyResponseModel>?>? weeklyStadistics,
    WidgetStatus? weeklyStatus,
    Wrapped<User?>? user,
  }) {
    return GeneralState(
      exception: exception ?? this.exception,
      incomeStatus: incomeStatus ?? this.incomeStatus,
      paymentMethodStatus: paymentMethodStatus ?? this.paymentMethodStatus,
      stadisticsStatus: stadisticsStatus ?? this.stadisticsStatus,
      income: income != null ? income.value : this.income,
      stadistics: stadistics != null ? stadistics.value : this.stadistics,
      payment: payment != null ? payment.value : this.payment,
      isGross: isGross ?? this.isGross,
      period: period ?? this.period,
      weeklyStadistics: weeklyStadistics != null
          ? weeklyStadistics.value
          : this.weeklyStadistics,
      weeklyStatus: weeklyStatus ?? this.weeklyStatus,
      user: user != null ? user.value : this.user,
    );
  }
}
