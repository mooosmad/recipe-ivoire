// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, sized_box_for_whitespace

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter_recipee_app/Screens/wrapper.dart';
import 'package:flutter_recipee_app/constant/animation.dart';
import 'package:flutter_recipee_app/constant/color.dart';
import "package:shared_preferences/shared_preferences.dart";
import 'package:lottie/lottie.dart';

class Description extends StatefulWidget {
  const Description({Key key}) : super(key: key);

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
              backgroundColor: Colors.yellowAccent,
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
                          "Bienvenue ",
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
                          "assets/lottie/cooking.json",
                          height: 300,
                        ),
                      ),
                      Text(
                        " Okay!",
                        textAlign: TextAlign.center,
                        style: style.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: mycolor2,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Choissisez votre langue puis parlez...",
                        textAlign: TextAlign.center,
                        style: style.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Container(
                        child: Lottie.asset("assets/lottie/animation.json"),
                        height: 200,
                      ),
                      AnimationWidget(
                        second: 10,
                        depart: Depart.bottom,
                        child: Text(
                          "Vous pouvez aussi saisir votre phrase au clavier",
                          textAlign: TextAlign.center,
                          style: style.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  color: mycolor1,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimationWidget(
                        second: 10,
                        depart: Depart.top,
                        child: Text(
                          "Avec l'intelligence artificiel , vous avez la possibilité de traduire le text sur les photos",
                          textAlign: TextAlign.center,
                          style: style.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
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
                        color: initialPage == 0 ? Colors.purple : Colors.grey,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    SizedBox(width: 6),
                    Container(
                      width: initialPage == 1 ? 25 : 10,
                      height: 8,
                      decoration: BoxDecoration(
                        color: initialPage == 1 ? Colors.purple : Colors.grey,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    SizedBox(width: 6),
                    Container(
                      width: initialPage == 2 ? 25 : 10,
                      height: 8,
                      decoration: BoxDecoration(
                        color: initialPage == 2 ? Colors.purple : Colors.grey,
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
