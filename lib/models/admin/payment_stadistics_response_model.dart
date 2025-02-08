class PaymentStadisticsResponseModel {
  final String? typePayment;
  final int? totalUsed;
  final double? percentagUsed;

  PaymentStadisticsResponseModel(
      {this.typePayment, this.totalUsed, this.percentagUsed});

  PaymentStadisticsResponseModel copyWith({
    String? typePayment,
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
        typePayment: json["type_payment"],
        totalUsed: json["total_used"],
        percentagUsed: json["percentag_used"]?.toDouble(),
      );
}
