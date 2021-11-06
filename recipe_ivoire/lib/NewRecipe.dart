import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_recipee_app/data/database.dart';
import 'package:flutter_recipee_app/model/Recipe.dart';
import 'package:icon_animator/icon_animator.dart';

class RecipeCard extends StatefulWidget {
  final Recipe recipe;
  RecipeCard({
    @required this.recipe,
  });

  @override
  _RecipeCardState createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {
  bool loved = false;
  bool saved = false;
  List<Recipe> recipe = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Hero(
                  tag: widget.recipe.imgPath,
                  child: Stack(
                    children: [
                      GestureDetector(
                        onLongPress: () async {
                          recipe = await RecipeDataBase.instance
                              .oneRecipe(int.parse(widget.recipe.id));
                          // voir si la recette existe deja ou pas dans la base de donne
                          if (recipe.isEmpty) {
                            setState(() {
                              loved = true;
                              Future.delayed(Duration(seconds: 1), () {
                                setState(() {
                                  loved = false;
                                });
                              });
                              RecipeDataBase.instance.insertRecipe(
                                widget.recipe,
                              );
                            });
                          } else {
                            SnackBar snackBar = SnackBar(
                              content: Text("ce plat à déja été liké"),
                            );
                            ScaffoldMessenger.of(context)
                              ..removeCurrentSnackBar()
                              ..showSnackBar(snackBar);
                          }
                        },
                        child: Image(
                          height: 320,
                          width: 320,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, widget, check) {
                            if (check == null) return widget;
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.grey.shade300,
                              ),
                              width: 320,
                              height: 320,
                            );
                          },
                          image:
                              CachedNetworkImageProvider(widget.recipe.imgPath),
                        ),
                      ),
                      if (loved)
                        Positioned(
                          left: 120,
                          top: 120,
                          child: IconAnimator(
                            loop: 0,
                            icon: Icons.favorite,
                            children: [
                              AnimationFrame(size: 0, duration: 100),
                              AnimationFrame(
                                  size: 18, color: Colors.white, duration: 100),
                              AnimationFrame(
                                  size: 20, color: Colors.white, duration: 100),
                              AnimationFrame(
                                  size: 30, color: Colors.white, duration: 100),
                              AnimationFrame(
                                  size: 40, color: Colors.white, duration: 150),
                              AnimationFrame(
                                  size: 50, color: Colors.white, duration: 200),
                              AnimationFrame(
                                  size: 60, color: Colors.white, duration: 250),
                              AnimationFrame(
                                  size: 100,
                                  color: Colors.white,
                                  duration: 300),
                            ],
                          ),
                          // child: Icon(
                          //   FlutterIcons.heart_circle_mco,
                          //   size: 100,
                          //   color: Colors.white,
                          // ),
                        )
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 20,
              right: 40,
              child: InkWell(
                onTap: () {
                  setState(() {
                    saved = !saved;
                  });
                },
                child: Icon(
                  saved
                      ? FlutterIcons.bookmark_check_mco
                      : FlutterIcons.bookmark_outline_mco,
                  color: Colors.white,
                  size: 38,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.recipe.title,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              ),
              // Spacer(),
              Flexible(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 20,
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
                    Spacer(),
                    // InkWell(
                    //   onTap: () {
                    //     setState(() {
                    //       loved = !loved;
                    //       if (loved = true) {
                    //         RecipeDataBase.instance.insertRecipe(widget.recipe);
                    //       }
                    //     });
                    //   },
                    //   child: Icon(
                    //     FlutterIcons.heart_circle_mco,
                    //     color: loved ? Colors.red : Colors.black,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
