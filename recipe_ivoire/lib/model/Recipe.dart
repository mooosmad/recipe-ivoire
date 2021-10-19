class Recipe {
  String id, title, imgPath, time;
  Recipe({this.id, this.title, this.imgPath, this.time});
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
