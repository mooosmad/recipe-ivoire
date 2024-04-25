import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_recipee_app/loader/loading.dart';
import 'package:flutter_recipee_app/utils/constante.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ResetPage extends StatefulWidget {
  ResetPage({key}) : super(key: key);

  @override
  _ResetPageState createState() => _ResetPageState();
}

class _ResetPageState extends State<ResetPage> {
  late String _email;
  bool loading = false;
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return loading
        ? Loading()
        : Scaffold(
            body: Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: Colors.black87,
                image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.5), BlendMode.dstATop),
                  image: AssetImage('assets/images/img2.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(150.0),
                      child: Center(
                        child: Icon(
                          Icons.food_bank,
                          color: Colors.white,
                          size: 100.0,
                        ),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 40.0),
                            child: RichText(
                              text: TextSpan(
                                text: 'EMAIL',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 15.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(
                          left: 40.0, right: 40.0, top: 10.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              color: Colors.white,
                              width: 2,
                              style: BorderStyle.solid),
                        ),
                      ),
                      padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: TextFormField(
                              onChanged: (value) {
                                setState(() {
                                  _email = value.trim();
                                });
                              },
                              obscureText: false,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.left,
                              keyboardType: TextInputType.emailAddress,
                              decoration: textInputDecoration.copyWith(
                                  hintText: 'recipeivoire@email.com'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 24.0,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(
                          left: 30.0, right: 30.0, top: 10.0),
                      alignment: Alignment.center,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            // ignore: deprecated_member_use
                            child: OutlinedButton(
                              onPressed: () {
                                auth.sendPasswordResetEmail(email: _email);
                                Fluttertoast.showToast(
                                    msg: "Email de renitialisation envoyé",
                                    gravity: ToastGravity.TOP,
                                    backgroundColor: Colors.white,
                                    textColor: Colors.black,
                                    timeInSecForIosWeb: 5);
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 20.0,
                                  horizontal: 20.0,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                      child: Text(
                                        "Envoyer une demande",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
