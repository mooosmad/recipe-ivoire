import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_recipee_app/model/Recipe.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import "package:http/http.dart" as http;
import 'package:url_launcher/url_launcher.dart';

class RecipeDetails extends StatefulWidget {
  final Recipe recipe;
  const RecipeDetails({Key key, this.recipe}) : super(key: key);

  @override
  _RecipeDetailsState createState() => _RecipeDetailsState();
}

class _RecipeDetailsState extends State<RecipeDetails> {
  RecipeModel recipeModel =
      RecipeModel(ingredients: [], mesures: [], instructions: "", video: "");
  getDetailsMeals(String id) async {
    try {
      var url =
          Uri.parse("https://www.themealdb.com/api/json/v1/1/lookup.php?i=$id");
      var req = await http.get(url);
      if (req.statusCode == 200) {
        final result = jsonDecode(req.body);
        List<String> ingrediants = [];
        List<String> mesures = [];
        for (var i = 1; i <= 20; i++) {
          if (result["meals"][0]["strIngredient$i"] != "") {
            if (result["meals"][0]["strIngredient$i"] != null) {
              ingrediants.add(result["meals"][0]["strIngredient$i"]);
            }
          }
          if (result["meals"][0]["strMeasure$i"].trim() != "") {
            mesures.add(result["meals"][0]["strMeasure$i"]);
          }
        }
        // print(result);
        // print(ingrediants.length);
        // print(mesures.length);
        setState(() {
          recipeModel = RecipeModel(
            recipe: widget.recipe,
            instructions: result["meals"][0]["strInstructions"],
            video:
                result["meals"][0]["strYoutube"].replaceAll(RegExp(r"\\"), ""),
            ingredients: ingrediants,
            mesures: mesures,
          );
        });
      } else {
        print(req.statusCode);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    getDetailsMeals(widget.recipe.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final _textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SlidingUpPanel(
        parallaxEnabled: true,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 12,
        ),
        minHeight: (size.height / 2),
        maxHeight: size.height / 1.2,
        panel: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: 5,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                widget.recipe.title,
                style: _textTheme.headline6,
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Icon(
                    FlutterIcons.heart_circle_mco,
                    color: Colors.red,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "198",
                    // style: _textTheme.caption,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    FlutterIcons.timer_mco,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    widget.recipe.time.toString() + '\'',
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: 2,
                    height: 30,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                color: Colors.black.withOpacity(0.3),
              ),
              Expanded(
                child: DefaultTabController(
                  length: 2,
                  initialIndex: 0,
                  child: Column(
                    children: [
                      TabBar(
                        isScrollable: true,
                        indicatorColor: Colors.red,
                        tabs: [
                          Tab(
                            text: "Ingredients".toUpperCase(),
                          ),
                          Tab(
                            text: "Instructions".toUpperCase(),
                          ),
                        ],
                        labelColor: Colors.black,
                        indicator: DotIndicator(
                          color: Colors.black,
                          distanceFromCenter: 16,
                          radius: 3,
                          paintingStyle: PaintingStyle.fill,
                        ),
                        unselectedLabelColor: Colors.black.withOpacity(0.3),
                        labelStyle: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                        labelPadding: EdgeInsets.symmetric(
                          horizontal: 32,
                        ),
                      ),
                      Divider(
                        color: Colors.black.withOpacity(0.3),
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            recipeModel.ingredients == []
                                ? Center(
                                    child: CircularProgressIndicator(
                                        color: Colors.amber))
                                : Ingredients(recipeModel: recipeModel),
                            recipeModel.instructions == ""
                                ? Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.amber,
                                    ),
                                  )
                                : Instruction(text: recipeModel.instructions),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Hero(
                    tag: widget.recipe.imgPath,
                    child: ClipRRect(
                      child: Image(
                        loadingBuilder: (context, widget, check) {
                          if (check == null) return widget;
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.grey.shade300,
                            ),
                            width: double.infinity,
                            height: (size.height / 2) + 50,
                          );
                        },
                        width: double.infinity,
                        height: (size.height / 2) + 50,
                        fit: BoxFit.cover,
                        image:
                            CachedNetworkImageProvider(widget.recipe.imgPath),
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 40,
                right: 20,
                child: recipeModel.video != ""
                    ? IconButton(
                        tooltip: "play video",
                        onPressed: () async {
                          var mysnack = SnackBar(
                            content: Text("impossible de lire la video"),
                            duration: Duration(seconds: 1),
                          );
                          await canLaunch(recipeModel.video)
                              ? launch(recipeModel.video)
                              : ScaffoldMessenger.of(context)
                                  .showSnackBar(mysnack);
                        },
                        icon: Icon(
                          Icons.play_circle_filled_rounded,
                          color: Colors.white,
                          size: 40,
                        ),
                      )
                    : Container(),
              ),
              Positioned(
                top: 40,
                left: 20,
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    CupertinoIcons.back,
                    color: Colors.white,
                    size: 38,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class Ingredients extends StatelessWidget {
  const Ingredients({
    Key key,
    @required this.recipeModel,
  }) : super(key: key);

  final RecipeModel recipeModel;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: Column(
          children: [
            ListView.separated(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: recipeModel.ingredients.length,
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 2.0,
                      ),
                      child: Text('⚫️ ' + recipeModel.ingredients[index]),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 2.0,
                        horizontal: 20,
                      ),
                      child: Text(
                        recipeModel.mesures[index],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider(color: Colors.black.withOpacity(0.3));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Mesure extends StatelessWidget {
  final List mesures;
  const Mesure({Key key, this.mesures}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: Column(
          children: [
            ListView.separated(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: mesures.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 2.0,
                  ),
                  child: Text('👍 ' + mesures[index]),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider(color: Colors.black.withOpacity(0.3));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Instruction extends StatelessWidget {
  final String text;
  const Instruction({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Text(
          text,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
      ),
    );
  }
}
