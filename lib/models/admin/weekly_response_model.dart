class WeeklyResponseModel {
  final int? users;
  final int? trips;
  final String? nameDay;

  WeeklyResponseModel({this.users, this.trips, this.nameDay});

  factory WeeklyResponseModel.fromJson(Map<String, dynamic> json) =>
      WeeklyResponseModel(
        users: json["users"],
        trips: json["trips"],
        nameDay: json["name_day"],
      );
}
