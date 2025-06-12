class Flatt {

  List<dynamic> flats;
  Flatt(this.flats);

  factory Flatt.fromJson(Map<String, dynamic> json) {
    return Flatt(json["flats"]);
  }
}
