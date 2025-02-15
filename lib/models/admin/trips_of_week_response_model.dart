class TripsOfWeekResponseModel {
  final int? cars;
  final int? bikes;
  final String? nameDay;

  TripsOfWeekResponseModel({this.cars, this.bikes, this.nameDay});

  factory TripsOfWeekResponseModel.fromJson(Map<String, dynamic> json) =>
      TripsOfWeekResponseModel(
        cars: json["cars"],
        bikes: json["bikes"],
        nameDay: json["name_day"],
      );
}
