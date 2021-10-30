class Recipe {
  String id, title, imgPath, time;
  bool isFavorite;
  int isfavoriteCount;
  Recipe(
      {this.id,
      this.title,
      this.imgPath,
      this.time,
      this.isFavorite,
      this.isfavoriteCount});
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "imgPath": imgPath,
      "time": time,
      "isFavorite": isFavorite,
      "isfavoriteCount": isfavoriteCount,
    };
  }

  factory Recipe.fromMap(Map<String, dynamic> map) {
    return Recipe(
      id: map["id"],
      title: map["title"],
      imgPath: map["imgPath"],
      time: map["time"],
      isFavorite: map["isFavorite"] == 1,
      isfavoriteCount: map["isfavoriteCount"],
    );
  }
}

class RecipeModel {
  Recipe recipe;
  String instructions, video;
  List<String> ingredients = [];
  List<String> mesures = [];
  RecipeModel({
    this.recipe,
    this.instructions,
    this.video,
    this.ingredients,
    this.mesures,
  });
}
