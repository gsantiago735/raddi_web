class IncomeResponseModel {
  final General? general;
  final Period? period;

  IncomeResponseModel({this.general, this.period});

  IncomeResponseModel copyWith({
    General? general,
    Period? period,
  }) =>
      IncomeResponseModel(
        general: general ?? this.general,
        period: period ?? this.period,
      );

  factory IncomeResponseModel.fromJson(Map<String, dynamic> json) =>
      IncomeResponseModel(
        general:
            json["general"] == null ? null : General.fromJson(json["general"]),
        period: json["period"] == null ? null : Period.fromJson(json["period"]),
      );
}

class General {
  final TypeModel? gross;
  final TypeModel? net;

  General({this.gross, this.net});

  General copyWith({
    TypeModel? gross,
    TypeModel? net,
  }) =>
      General(
        gross: gross ?? this.gross,
        net: net ?? this.net,
      );

  factory General.fromJson(Map<String, dynamic> json) => General(
        gross: json["gross"] == null ? null : TypeModel.fromJson(json["gross"]),
        net: json["net"] == null ? null : TypeModel.fromJson(json["net"]),
      );
}

class TypeModel {
  final double? general;
  final double? cars;
  final double? bikes;

  TypeModel({this.general, this.cars, this.bikes});

  TypeModel copyWith({
    double? general,
    double? cars,
    double? bikes,
  }) =>
      TypeModel(
        general: general ?? this.general,
        cars: cars ?? this.cars,
        bikes: bikes ?? this.bikes,
      );

  factory TypeModel.fromJson(Map<String, dynamic> json) => TypeModel(
        general: json["general"]?.toDouble(),
        cars: json["cars"]?.toDouble(),
        bikes: json["bikes"]?.toDouble(),
      );
}

class Period {
  final PeriodModel? gross;
  final PeriodModel? net;

  Period({this.gross, this.net});

  Period copyWith({
    PeriodModel? gross,
    PeriodModel? net,
  }) =>
      Period(
        gross: gross ?? this.gross,
        net: net ?? this.net,
      );

  factory Period.fromJson(Map<String, dynamic> json) => Period(
        gross:
            json["gross"] == null ? null : PeriodModel.fromJson(json["gross"]),
        net: json["net"] == null ? null : PeriodModel.fromJson(json["net"]),
      );
}

class PeriodModel {
  final TypeModel? yesterday;
  final TypeModel? today;
  final TypeModel? week;
  final TypeModel? month;

  PeriodModel({this.yesterday, this.today, this.week, this.month});

  PeriodModel copyWith({
    TypeModel? yesterday,
    TypeModel? today,
    TypeModel? week,
    TypeModel? month,
  }) =>
      PeriodModel(
        yesterday: yesterday ?? this.yesterday,
        today: today ?? this.today,
        week: week ?? this.week,
        month: month ?? this.month,
      );

  factory PeriodModel.fromJson(Map<String, dynamic> json) => PeriodModel(
        yesterday: json["yesterday"] == null
            ? null
            : TypeModel.fromJson(json["yesterday"]),
        today: json["today"] == null ? null : TypeModel.fromJson(json["today"]),
        week: json["week"] == null ? null : TypeModel.fromJson(json["week"]),
        month: json["month"] == null ? null : TypeModel.fromJson(json["month"]),
      );
}
