// To parse this JSON data, do
//
//     final googleNearbyPlaceModel = googleNearbyPlaceModelFromJson(jsonString);

class GoogleNearbyAPIModel {
  GoogleNearbyAPIModel({
    this.results,
  });
  List<Result>? results;
  factory GoogleNearbyAPIModel.fromJson(Map<String, dynamic> str) =>
      GoogleNearbyAPIModel.fromMap(str);

  static fromMap(Map<String, dynamic> json) => GoogleNearbyAPIModel(
        results:
            List<Result>.from(json["results"].map((x) => Result.fromMap(x))),
      );
}

class Result {
  Result({
    this.name,
    this.lat,
    this.lng,
  });
  String? name;
  double? lat;
  double? lng;

  static fromMap(Map<String, dynamic> json) => Result(
        name: json["name"],
        lat: json["geometry"]["location"]["lat"],
        lng: json["geometry"]["location"]["lng"],
      );
}
