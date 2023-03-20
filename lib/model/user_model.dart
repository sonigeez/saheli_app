
class UserModel {
  final String id;
  final String username;
  final String sudoName;
  final String name;

  UserModel(
    this.id,
    this.username,
    this.sudoName,
    this.name,
  );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        json['id'],
        json['username'],
        json['psuedoAnonymous'],
        json['firstName'] + " " + json['lastName'],
      );
}
