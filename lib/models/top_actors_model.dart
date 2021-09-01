class TopActorsModel {
  int id;
  String name;
  String profilePath;

  TopActorsModel({
    this.id,
    this.name,
    this.profilePath,
  });

  factory TopActorsModel.fromJson(Map<String, dynamic> json) {
    return TopActorsModel(
      id: json["id"],
      name: json["name"],
      profilePath: json["profile_path"],
    );
  }
}
