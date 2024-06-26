import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_recipee_app/Screens/RecipeDetails.dart';
import 'package:flutter_recipee_app/Screens/wrapper.dart';
import 'package:flutter_recipee_app/data/database.dart';
import 'package:flutter_recipee_app/model/CategoriesModel.dart';
import 'package:flutter_recipee_app/model/Recipe.dart';
import "package:http/http.dart" as http;
import 'package:flutter_recipee_app/NewRecipe.dart';
import 'package:provider/src/provider.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  List<Categories> categories = [];
  List<Recipe> recettes = [];
  late Recipe recipe;
  late bool loadCategories;
  bool loadRecettes = true;
  late String categorieSelectioner;
  final auth = FirebaseAuth.instance;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String errorMessage = '';
  void _openEndDrawer() {
    _scaffoldKey.currentState!.openEndDrawer();
  }

  getRecettes(String categori) async {
    var url = Uri.parse(
        "https://www.themealdb.com/api/json/v1/1/filter.php?c=$categori");
    try {
      setState(() {
        loadRecettes = true;
      });
      var requete = await http.get(url);
      if (requete.statusCode == 200) {
        final result = jsonDecode(requete.body);

        setState(() {
          recettes = List.generate(result["meals"].length, (index) {
            return Recipe(
              id: result["meals"][index]["idMeal"],
              title: result["meals"][index]["strMeal"],
              imgPath: result["meals"][index]["strMealThumb"]
                  .replaceAll(RegExp(r"\\"), ""),
              time: "10",
              isfavoriteCount: 15,
              isFavorite: false,
            );
          });
          loadRecettes = false;
        });
      } else {
        print(requete.statusCode);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  getCategories() async {
    var url = Uri.parse(
      'https://www.themealdb.com/api/json/v1/1/categories.php',
    );
    try {
      setState(() {
        loadCategories = true;
      });
      var requete = await http.get(url);
      if (requete.statusCode == 200) {
        final result = jsonDecode(requete.body);

        setState(() {
          categories = List.generate(result["categories"].length, (index) {
            return Categories(
              nom: result["categories"][index]["strCategory"],
              image: result["categories"][index]["strCategoryThumb"]
                  .replaceAll(RegExp(r"\\"), ""),
              description: result["categories"][index]
                  ["strCategoryDescription"],
            );
          });
          loadCategories = false;
          categorieSelectioner = categories[0].nom;
          getRecettes(categorieSelectioner);
        });
      } else {
        print(requete.statusCode);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  String firstLetterEmail(String email) {
    String upper = '';
    if (email.isNotEmpty) {
      return upper = email[0].toUpperCase();
    }
    return upper;
  }

  @override
  void initState() {
    getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    return Scaffold(
      key: _scaffoldKey,
      bottomNavigationBar: Container(
        // color: Colors.grey[300],
        height: 60,
        child: loadCategories
            ? Center(
                child: CircularProgressIndicator(
                  color: Colors.amber,
                  strokeWidth: 2,
                ),
              )
            : ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, i) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        categorieSelectioner = categories[i].nom;
                        getRecettes(categorieSelectioner);
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Row(
                        children: [
                          Container(
                            width: 30,
                            height: 30,
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            child: Image.network(
                              categories[i].image,
                              width: 30,
                              height: 30,
                            ),
                          ),
                          Text(
                            categories[i].nom,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: categorieSelectioner == categories[i].nom
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: categorieSelectioner == categories[i].nom
                            ? Colors.amber
                            : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                },
                itemCount: categories.length,
              ),
      ),
      body: SafeArea(
        bottom: false,
        child: DefaultTabController(
          length: 2,
          initialIndex: 0,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(right: 10, top: 10),
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: _openEndDrawer,
                  child: firebaseUser != null
                      ? CircleAvatar(
                          radius: 26,
                          backgroundImage: firebaseUser.photoURL != null
                              ? NetworkImage(firebaseUser.photoURL!)
                              : null,
                          child: firebaseUser.photoURL == null
                              ? Text(
                                  "${firstLetterEmail(firebaseUser.email!)}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 26,
                                  ),
                                )
                              : null)
                      : Container(),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TabBar(
                isScrollable: true,
                indicatorColor: Colors.red,
                tabs: [
                  Tab(
                    text: "Nouvelles recettes".toUpperCase(),
                  ),
                  Tab(
                    text: "Favories".toUpperCase(),
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
                  horizontal: 24,
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: <Widget>[
                    !loadRecettes
                        ? ListView.builder(
                            itemCount: recettes.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 12,
                                ),
                                child: InkWell(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => RecipeDetails(
                                          recipe: recettes[index],
                                        ),
                                      )),
                                  child: RecipeCard(
                                    recipe: recettes[index],
                                  ),
                                ),
                              );
                            },
                          )
                        : Center(
                            child:
                                CircularProgressIndicator(color: Colors.amber),
                          ),
                    Container(
                      child: FutureBuilder<List<Recipe>>(
                        future: RecipeDataBase.instance.recipes(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState !=
                              ConnectionState.waiting) {
                            if (snapshot.hasData) {
                              final data = snapshot.data;
                              return ListView.builder(
                                  itemCount: data!.length,
                                  itemBuilder: (context, i) {
                                    return RecipeCard(recipe: data[i]);
                                  });
                            } else {
                              return Text("no favoris add");
                            }
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      endDrawer: Drawer(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  DrawerHeader(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          firebaseUser != null
                              ? CircleAvatar(
                                  radius: 50,
                                  backgroundImage: firebaseUser.photoURL != null
                                      ? NetworkImage(firebaseUser.photoURL!)
                                      : null,
                                  child: firebaseUser.photoURL == null
                                      ? Text(
                                          "${firstLetterEmail(firebaseUser.email!)}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 26,
                                          ),
                                        )
                                      : null)
                              : Container(),
                          SizedBox(height: 15),
                          Text(firebaseUser.email!),
                        ]),
                  ),
                  SizedBox(height: 15),
                  ListTile(
                    title: Text("Partager l'application"),
                    leading: Icon(Icons.share),
                  ),
                  ListTile(
                    title: Text("Evaluez nous"),
                    leading: Icon(Icons.star),
                  ),
                  ListTile(
                    title: Text("Vos favoris"),
                    leading: Icon(Icons.favorite),
                  ),
                  ListTile(
                    title: Text("Nous contacter"),
                    onTap: () {},
                    leading: Icon(Icons.mail),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: OutlinedButton(
                  onPressed: () {
                    auth.signOut();
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => AuthenticationWrapper(),
                      ),
                    );
                  },
                  child: Text(
                    "Deconnexion",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  )),
            ),
            Container(
              margin: EdgeInsets.all(20),
              child: Text(
                "version 1.1.5",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  // endDrawer: Drawer(
  //   child: Container(
  //     child: Column(
  //       children: [
  //         DrawerHeader(
  //           decoration: BoxDecoration(
  //             color: Colors.transparent,
  //           ),
  //           child: null,
  //         ),
  //         Center(
  //           child: Padding(
  //             padding: const EdgeInsets.only(bottom: 10),
  //             child: OutlinedButton(
  //                 onPressed: () {
  //                   auth.signOut();
  //                   Navigator.of(context).pushReplacement(
  //                     MaterialPageRoute(
  //                       builder: (context) => AuthenticationWrapper(),
  //                     ),
  //                   );
  //                 },
  //                 child: Text("Deconnexion")),
  //           ),
  //         ),
  //       ],
  //     ),
  //   ),
  // ),
}
