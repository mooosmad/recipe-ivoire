// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, sized_box_for_whitespace

import 'package:carousel_slider/carousel_slider.dart';
import "package:flutter/material.dart";
import 'package:flutter_recipee_app/Screens/wrapper.dart';
import 'package:flutter_recipee_app/constant/animation.dart';
import "package:shared_preferences/shared_preferences.dart";
import 'package:lottie/lottie.dart';

class Description extends StatefulWidget {
  const Description({Key? key}) : super(key: key);

  @override
  _DescriptionState createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  int initialPage = 0;
  TextStyle style = TextStyle(color: Colors.white);
  bool showFAB = false;
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: showFAB
          ? FloatingActionButton(
              backgroundColor: Colors.orange,
              heroTag: "FAB",
              onPressed: () {
                setState(() {
                  prefs.then((_prefs) {
                    _prefs.setBool("isFirst", false);
                  });
                });
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => AuthenticationWrapper(),
                  ),
                );
              },
              child: Icon(Icons.arrow_forward_rounded),
            )
          : null,
      body: Stack(
        children: [
          Container(
            child: CarouselSlider(
              items: [
                Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimationWidget(
                        second: 10,
                        depart: Depart.top,
                        child: Text(
                          "Bienvenue Chef 👨‍🍳",
                          textAlign: TextAlign.center,
                          style: style.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Container(
                        child: Lottie.asset(
                          "assets/lottie/53023-online-cooking-lecture.json",
                          height: 300,
                        ),
                      ),
                      Text(
                        " La cuisine à domicile",
                        textAlign: TextAlign.center,
                        style: style.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Choisissez votre recette puis Cuisinez...",
                        textAlign: TextAlign.center,
                        style: style.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                      Container(
                        child: Lottie.asset(
                            "assets/lottie/45728-cooking-news-animation.json"),
                        height: 200,
                      ),
                      AnimationWidget(
                        second: 10,
                        depart: Depart.bottom,
                        child: Text(
                          "Vous pouvez voir les astuces recette sur la video",
                          textAlign: TextAlign.center,
                          style: style.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Colors.black,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimationWidget(
                        second: 10,
                        depart: Depart.top,
                        child: Text(
                          "Ainsi que garder vos recettes favorites",
                          textAlign: TextAlign.center,
                          style: style.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              color: Colors.black),
                        ),
                      ),
                      Container(
                        height: 230,
                        child: Lottie.asset(
                          "assets/lottie/recipes.json",
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              options: CarouselOptions(
                  initialPage: initialPage,
                  viewportFraction: 1,
                  height: size.height,
                  onPageChanged: (int page, reason) {
                    setState(() {
                      initialPage = page;
                      if (initialPage != 2) {
                        setState(() {
                          showFAB = false;
                        });
                      } else {
                        setState(() {
                          showFAB = true;
                        });
                      }
                    });
                  }),
            ),
          ),
          Positioned(
            bottom: 30,
            left: (size.width / 2) - 20,
            child: Container(
              child: LayoutBuilder(builder: (context, c) {
                return Row(
                  children: [
                    Container(
                      width: initialPage == 0 ? 25 : 10,
                      height: 8,
                      decoration: BoxDecoration(
                        color: initialPage == 0 ? Colors.orange : Colors.black,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    SizedBox(width: 6),
                    Container(
                      width: initialPage == 1 ? 25 : 10,
                      height: 8,
                      decoration: BoxDecoration(
                        color: initialPage == 1 ? Colors.orange : Colors.black,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    SizedBox(width: 6),
                    Container(
                      width: initialPage == 2 ? 25 : 10,
                      height: 8,
                      decoration: BoxDecoration(
                        color: initialPage == 2 ? Colors.orange : Colors.black,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ],
                );
              }),
            ),
          )
        ],
      ),
    );
  }

  mycontainer(int page) {}
}
