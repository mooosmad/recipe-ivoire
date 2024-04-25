class Recipe {
  String id, title, imgPath, time;
  bool isFavorite;
  int isfavoriteCount;
  Recipe(
      {required this.id,
      required this.title,
      required this.imgPath,
      required this.time,
      required this.isFavorite,
      required this.isfavoriteCount});
  Map<String, dynamic> toMap() {
    return {
      "id": int.parse(id), // pour avoir un entier a mettre dans la bd
      "title": title,
      "imgPath": imgPath,
      "time": time,
      "isFavorite": isFavorite ? 1 : 0,
      "isfavoriteCount": isfavoriteCount,
    };
  }

  factory Recipe.fromMap(Map<String, dynamic> map) {
    return Recipe(
      id: map["id"].toString(),
      title: map["title"],
      imgPath: map["imgPath"],
      time: map["time"],
      isFavorite: map["isFavorite"] == 1 ? true : false,
      isfavoriteCount: map["isfavoriteCount"],
    );
  }
}

class RecipeModel {
  Recipe? recipe;
  String instructions, video;
  List<String> ingredients = [];
  List<String> mesures = [];
  RecipeModel({
    this.recipe,
    required this.instructions,
    required this.video,
    required this.ingredients,
    required this.mesures,
  });
}
