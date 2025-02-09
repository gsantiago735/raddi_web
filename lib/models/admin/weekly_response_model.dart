class WeeklyResponseModel {
  final int? users;
  final int? trips;

  WeeklyResponseModel({this.users, this.trips});

  factory WeeklyResponseModel.fromJson(Map<String, dynamic> json) =>
      WeeklyResponseModel(
        users: json["users"],
        trips: json["trips"],
      );
}
