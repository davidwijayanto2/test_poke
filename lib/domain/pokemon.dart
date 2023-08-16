import 'dart:convert';

class Pokemon {
  final String? firstName;
  final String? lastName;
  final String? url;
  final String? status;
  Pokemon({this.firstName, this.lastName, this.url, this.status});

  factory Pokemon.fromJson(Map<String, dynamic> json) => Pokemon(
      firstName: json["first_name"],
      lastName: json["last_name"],
      url: json["url"]);

  List<Pokemon> listPokemonFromJson(String str) =>
      List<Pokemon>.from(json.decode(str).map((x) => Pokemon.fromJson(x)));

  String getFullName() {
    return '$firstName $lastName';
  }
}
