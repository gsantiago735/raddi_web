import 'package:raddi_web/models/generic/wrapped.dart';

class PaymentStadisticsResponseModel {
  final PaymentMethod? typePayment; //efe, tra, pmo
  final int? totalUsed;
  final double? percentagUsed;

  PaymentStadisticsResponseModel(
      {this.typePayment, this.totalUsed, this.percentagUsed});

  PaymentStadisticsResponseModel copyWith({
    PaymentMethod? typePayment,
    int? totalUsed,
    double? percentagUsed,
  }) =>
      PaymentStadisticsResponseModel(
        typePayment: typePayment ?? this.typePayment,
        totalUsed: totalUsed ?? this.totalUsed,
        percentagUsed: percentagUsed ?? this.percentagUsed,
      );

  factory PaymentStadisticsResponseModel.fromJson(Map<String, dynamic> json) =>
      PaymentStadisticsResponseModel(
        typePayment: (json["type_payment"] != null)
            ? paymentMethodValues.map[json["type_payment"]]
            : null,
        totalUsed: json["total_used"],
        percentagUsed: json["percentag_used"]?.toDouble(),
      );
}

/// [cash] Efectivo, [bankTransfer] Transferencia, [bankMovil] Pago Movil
enum PaymentMethod {
  cash,
  bankTransfer,
  bankMovil;

  String get getText {
    switch (this) {
      case cash:
        return "Efectivo";
      case bankTransfer:
        return "Transferencia";
      case bankMovil:
        return "Pago Móvil";
    }
  }

  String get toJsonValue {
    switch (this) {
      case PaymentMethod.cash:
        return "EFE";
      case PaymentMethod.bankTransfer:
        return "TRA";
      case PaymentMethod.bankMovil:
        return "PMO";
    }
  }
}

final paymentMethodValues = EnumValues({
  "EFE": PaymentMethod.cash,
  "TRA": PaymentMethod.bankTransfer,
  "PMO": PaymentMethod.bankMovil
});
