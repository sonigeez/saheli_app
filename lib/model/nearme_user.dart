class NearmeUser {
  final String username, firstname, lastname, shortDesc, distance, dest;
  final String id;

  NearmeUser(
    this.id,
    this.username,
    this.firstname,
    this.lastname,
    this.shortDesc,
    this.distance,
    this.dest,
  );

  factory NearmeUser.fromJson(Map<String, dynamic> json) => NearmeUser(
        json['id'],
        json['username'],
        json['firstName'],
        json['lastName'],
        json['shortDescription'],
        json['distance'],
        json['destination'],
      );
}
