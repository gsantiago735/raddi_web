class StadisticsResponseModel {
  final GeneralStadistic? general;
  final PeriodStadistic? period;

  StadisticsResponseModel({this.general, this.period});

  StadisticsResponseModel copyWith({
    GeneralStadistic? general,
    PeriodStadistic? period,
  }) =>
      StadisticsResponseModel(
        general: general ?? this.general,
        period: period ?? this.period,
      );

  factory StadisticsResponseModel.fromJson(Map<String, dynamic> json) =>
      StadisticsResponseModel(
        general: json["general"] == null
            ? null
            : GeneralStadistic.fromJson(json["general"]),
        period: json["period"] == null
            ? null
            : PeriodStadistic.fromJson(json["period"]),
      );
}

class GeneralStadistic {
  final GeneralDataGeneral? dataGeneral;
  final GeneralDataDriver? dataCars;
  final GeneralDataDriver? dataBikes;

  GeneralStadistic({this.dataGeneral, this.dataCars, this.dataBikes});

  GeneralStadistic copyWith({
    GeneralDataGeneral? dataGeneral,
    GeneralDataDriver? dataCars,
    GeneralDataDriver? dataBikes,
  }) =>
      GeneralStadistic(
        dataGeneral: dataGeneral ?? this.dataGeneral,
        dataCars: dataCars ?? this.dataCars,
        dataBikes: dataBikes ?? this.dataBikes,
      );

  factory GeneralStadistic.fromJson(Map<String, dynamic> json) =>
      GeneralStadistic(
        dataGeneral: json["data_general"] == null
            ? null
            : GeneralDataGeneral.fromJson(json["data_general"]),
        dataCars: json["data_cars"] == null
            ? null
            : GeneralDataDriver.fromJson(json["data_cars"]),
        dataBikes: json["data_bikes"] == null
            ? null
            : GeneralDataDriver.fromJson(json["data_bikes"]),
      );
}

class GeneralDataDriver {
  final DataDrivers? dataUbers;
  final DataTrips? dataTrips;

  GeneralDataDriver({this.dataUbers, this.dataTrips});

  GeneralDataDriver copyWith({
    DataDrivers? dataUbers,
    DataTrips? dataTrips,
  }) =>
      GeneralDataDriver(
        dataUbers: dataUbers ?? this.dataUbers,
        dataTrips: dataTrips ?? this.dataTrips,
      );

  factory GeneralDataDriver.fromJson(Map<String, dynamic> json) =>
      GeneralDataDriver(
        dataUbers: json["data_ubers"] == null
            ? null
            : DataDrivers.fromJson(json["data_ubers"]),
        dataTrips: json["data_trips"] == null
            ? null
            : DataTrips.fromJson(json["data_trips"]),
      );
}

class DataTrips {
  final int? ongoingTrips;
  final int? completedTrips;
  final int? cancelledTrips;
  final int? freeTrips;

  DataTrips({
    this.ongoingTrips,
    this.completedTrips,
    this.cancelledTrips,
    this.freeTrips,
  });

  DataTrips copyWith({
    int? ongoingTrips,
    int? completedTrips,
    int? cancelledTrips,
    int? freeTrips,
  }) =>
      DataTrips(
        ongoingTrips: ongoingTrips ?? this.ongoingTrips,
        completedTrips: completedTrips ?? this.completedTrips,
        cancelledTrips: cancelledTrips ?? this.cancelledTrips,
        freeTrips: freeTrips ?? this.freeTrips,
      );

  factory DataTrips.fromJson(Map<String, dynamic> json) => DataTrips(
        ongoingTrips: json["ongoing_trips"],
        completedTrips: json["completed_trips"],
        cancelledTrips: json["cancelled_trips"],
        freeTrips: json["free_trips"],
      );
}

class DataDrivers {
  final int? totalUbersRegister;
  final int? ubersNotVerified;
  final int? ubersOnline;
  final int? rejectedTrips;

  DataDrivers({
    this.totalUbersRegister,
    this.ubersNotVerified,
    this.ubersOnline,
    this.rejectedTrips,
  });

  DataDrivers copyWith({
    int? totalUbersRegister,
    int? ubersNotVerified,
    int? ubersOnline,
    int? rejectedTrips,
  }) =>
      DataDrivers(
        totalUbersRegister: totalUbersRegister ?? this.totalUbersRegister,
        ubersNotVerified: ubersNotVerified ?? this.ubersNotVerified,
        ubersOnline: ubersOnline ?? this.ubersOnline,
        rejectedTrips: rejectedTrips ?? this.rejectedTrips,
      );

  factory DataDrivers.fromJson(Map<String, dynamic> json) => DataDrivers(
        totalUbersRegister: json["total_ubers_register"],
        ubersNotVerified: json["ubers_not_verified"],
        ubersOnline: json["ubers_online"],
        rejectedTrips: json["rejected_trips"],
      );
}

class GeneralDataGeneral {
  final DataUser? dataUser;
  final DataDrivers? dataUbers;
  final DataTrips? dataTrips;

  GeneralDataGeneral({
    this.dataUser,
    this.dataUbers,
    this.dataTrips,
  });

  GeneralDataGeneral copyWith({
    DataUser? dataUser,
    DataDrivers? dataUbers,
    DataTrips? dataTrips,
  }) =>
      GeneralDataGeneral(
        dataUser: dataUser ?? this.dataUser,
        dataUbers: dataUbers ?? this.dataUbers,
        dataTrips: dataTrips ?? this.dataTrips,
      );

  factory GeneralDataGeneral.fromJson(Map<String, dynamic> json) =>
      GeneralDataGeneral(
        dataUser: json["data_user"] == null
            ? null
            : DataUser.fromJson(json["data_user"]),
        dataUbers: json["data_ubers"] == null
            ? null
            : DataDrivers.fromJson(json["data_ubers"]),
        dataTrips: json["data_trips"] == null
            ? null
            : DataTrips.fromJson(json["data_trips"]),
      );
}

class DataUser {
  final int? totalUserRegister;
  final int? usersNotVerified;

  DataUser({
    this.totalUserRegister,
    this.usersNotVerified,
  });

  DataUser copyWith({
    int? totalUserRegister,
    int? usersNotVerified,
  }) =>
      DataUser(
        totalUserRegister: totalUserRegister ?? this.totalUserRegister,
        usersNotVerified: usersNotVerified ?? this.usersNotVerified,
      );

  factory DataUser.fromJson(Map<String, dynamic> json) => DataUser(
        totalUserRegister: json["total_user_register"],
        usersNotVerified: json["users_not_verified"],
      );
}

class PeriodStadistic {
  final PeriodDataGeneral? dataGeneral;
  final PeriodDataDrivers? dataCars;
  final PeriodDataDrivers? dataBikes;

  PeriodStadistic({
    this.dataGeneral,
    this.dataCars,
    this.dataBikes,
  });

  PeriodStadistic copyWith({
    PeriodDataGeneral? dataGeneral,
    PeriodDataDrivers? dataCars,
    PeriodDataDrivers? dataBikes,
  }) =>
      PeriodStadistic(
        dataGeneral: dataGeneral ?? this.dataGeneral,
        dataCars: dataCars ?? this.dataCars,
        dataBikes: dataBikes ?? this.dataBikes,
      );

  factory PeriodStadistic.fromJson(Map<String, dynamic> json) =>
      PeriodStadistic(
        dataGeneral: json["data_general"] == null
            ? null
            : PeriodDataGeneral.fromJson(json["data_general"]),
        dataCars: json["data_cars"] == null
            ? null
            : PeriodDataDrivers.fromJson(json["data_cars"]),
        dataBikes: json["data_bikes"] == null
            ? null
            : PeriodDataDrivers.fromJson(json["data_bikes"]),
      );
}

class PeriodDataDrivers {
  final DataBikesMonth? yesterday;
  final DataBikesMonth? today;
  final DataBikesMonth? week;
  final DataBikesMonth? month;

  PeriodDataDrivers({
    this.yesterday,
    this.today,
    this.week,
    this.month,
  });

  PeriodDataDrivers copyWith({
    DataBikesMonth? yesterday,
    DataBikesMonth? today,
    DataBikesMonth? week,
    DataBikesMonth? month,
  }) =>
      PeriodDataDrivers(
        yesterday: yesterday ?? this.yesterday,
        today: today ?? this.today,
        week: week ?? this.week,
        month: month ?? this.month,
      );

  factory PeriodDataDrivers.fromJson(Map<String, dynamic> json) =>
      PeriodDataDrivers(
        yesterday: json["yesterday"] == null
            ? null
            : DataBikesMonth.fromJson(json["yesterday"]),
        today: json["today"] == null
            ? null
            : DataBikesMonth.fromJson(json["today"]),
        week:
            json["week"] == null ? null : DataBikesMonth.fromJson(json["week"]),
        month: json["month"] == null
            ? null
            : DataBikesMonth.fromJson(json["month"]),
      );
}

class DataBikesMonth {
  final int? completedTrips;
  final int? totalUbersRegister;
  final int? freeTrips;

  DataBikesMonth({
    this.completedTrips,
    this.totalUbersRegister,
    this.freeTrips,
  });

  DataBikesMonth copyWith({
    int? completedTrips,
    int? totalUbersRegister,
    int? freeTrips,
  }) =>
      DataBikesMonth(
        completedTrips: completedTrips ?? this.completedTrips,
        totalUbersRegister: totalUbersRegister ?? this.totalUbersRegister,
        freeTrips: freeTrips ?? this.freeTrips,
      );

  factory DataBikesMonth.fromJson(Map<String, dynamic> json) => DataBikesMonth(
        completedTrips: json["completed_trips"],
        totalUbersRegister: json["total_ubers_register"],
        freeTrips: json["free_trips"],
      );
}

class PeriodDataGeneral {
  final DataGeneralMonth? yesterday;
  final DataGeneralMonth? today;
  final DataGeneralMonth? week;
  final DataGeneralMonth? month;

  PeriodDataGeneral({
    this.yesterday,
    this.today,
    this.week,
    this.month,
  });

  PeriodDataGeneral copyWith({
    DataGeneralMonth? yesterday,
    DataGeneralMonth? today,
    DataGeneralMonth? week,
    DataGeneralMonth? month,
  }) =>
      PeriodDataGeneral(
        yesterday: yesterday ?? this.yesterday,
        today: today ?? this.today,
        week: week ?? this.week,
        month: month ?? this.month,
      );

  factory PeriodDataGeneral.fromJson(Map<String, dynamic> json) =>
      PeriodDataGeneral(
        yesterday: json["yesterday"] == null
            ? null
            : DataGeneralMonth.fromJson(json["yesterday"]),
        today: json["today"] == null
            ? null
            : DataGeneralMonth.fromJson(json["today"]),
        week: json["week"] == null
            ? null
            : DataGeneralMonth.fromJson(json["week"]),
        month: json["month"] == null
            ? null
            : DataGeneralMonth.fromJson(json["month"]),
      );
}

class DataGeneralMonth {
  final int? completedTrips;
  final int? totalUbersRegister;
  final int? totalUsersRegister;
  final int? freeTrips;
  final int? quotedTrips;

  DataGeneralMonth({
    this.completedTrips,
    this.totalUbersRegister,
    this.totalUsersRegister,
    this.freeTrips,
    this.quotedTrips,
  });

  DataGeneralMonth copyWith({
    int? completedTrips,
    int? totalUbersRegister,
    int? totalUsersRegister,
    int? freeTrips,
    int? quotedTrips,
  }) =>
      DataGeneralMonth(
        completedTrips: completedTrips ?? this.completedTrips,
        totalUbersRegister: totalUbersRegister ?? this.totalUbersRegister,
        totalUsersRegister: totalUsersRegister ?? this.totalUsersRegister,
        freeTrips: freeTrips ?? this.freeTrips,
        quotedTrips: quotedTrips ?? this.quotedTrips,
      );

  factory DataGeneralMonth.fromJson(Map<String, dynamic> json) =>
      DataGeneralMonth(
        completedTrips: json["completed_trips"],
        totalUbersRegister: json["total_ubers_register"],
        totalUsersRegister: json["total_users_register"],
        freeTrips: json["free_trips"],
        quotedTrips: json["quoted_trips"],
      );
}
