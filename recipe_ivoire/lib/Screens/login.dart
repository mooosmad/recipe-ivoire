import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_recipee_app/Screens/reset.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_recipee_app/Screens/signup.dart';
import 'package:flutter_recipee_app/loader/loading.dart';
import 'package:flutter_recipee_app/services/authentification_service.dart';
import 'package:flutter_recipee_app/utils/constante.dart';
import 'package:provider/src/provider.dart';

import '../main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({key}) : super(key: key);
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email, _password;
  bool loading = false;
  String errorMessage;
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
                  image: AssetImage('assets/images/img3.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(60.0),
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
                            child: Text(
                              "EMAIL",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 15.0,
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
                                _email = value.trim();
                              },
                              obscureText: false,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.left,
                              keyboardType: TextInputType.emailAddress,
                              decoration: textInputDecoration.copyWith(
                                hintText: 'recipeivoire@email.com',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 24.0,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 40.0),
                            child: Text(
                              "MOT DE PASSE",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 15.0,
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
                                _password = value.trim();
                              },
                              obscureText: true,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.left,
                              decoration: textInputDecoration.copyWith(
                                  hintText: '********'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 24.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          // ignore: deprecated_member_use
                          child: FlatButton(
                            child: Text(
                              "Mot de passe Oublié ?",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 15.0,
                              ),
                              textAlign: TextAlign.end,
                            ),
                            onPressed: () => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ResetPage()),
                              ),
                            },
                          ),
                        ),
                      ],
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
                            child: FlatButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              color: Colors.white,
                              onPressed: () {
                                setState(() {
                                  loading = true;
                                });
                                _signin(_email, _password);
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
                                        "CONNEXION",
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
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(
                          left: 30.0, right: 30.0, top: 10.0),
                      alignment: Alignment.center,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  border: Border.all(width: 0.25)),
                            ),
                          ),
                          Text(
                            "OU SE CONNECTER AVEC",
                            style: TextStyle(
                              color: Colors.white54,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  border: Border.all(width: 0.25)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(
                          left: 30.0, right: 30.0, top: 20.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(right: 8.0),
                              alignment: Alignment.center,
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    // ignore: deprecated_member_use
                                    child: FlatButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                      ),
                                      color: Colors.white,
                                      onPressed: () => {},
                                      child: Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Expanded(
                                              // ignore: deprecated_member_use
                                              child: FlatButton(
                                                onPressed: () {
                                                  {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              SignupPage()),
                                                    );
                                                  }
                                                },
                                                padding: EdgeInsets.only(
                                                  top: 20.0,
                                                  bottom: 20.0,
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: <Widget>[
                                                    // Icon(
                                                    //   const IconData(0xea90,
                                                    //       fontFamily: 'icomoon'),
                                                    //   color: Colors.white,
                                                    //   size: 15.0,
                                                    // ),
                                                    Text(
                                                      "S'INSCRIRE ?",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
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
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(left: 8.0),
                              alignment: Alignment.center,
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    // ignore: deprecated_member_use
                                    child: FlatButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                      ),
                                      color: Colors.white,
                                      onPressed: () => {},
                                      child: Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Expanded(
                                              // ignore: deprecated_member_use
                                              child: FlatButton(
                                                onPressed: () async {
                                                  context
                                                      .read<
                                                          AuthenticationService>()
                                                      .signInWithGoogle();
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          AuthenticationWrapper(),
                                                    ),
                                                  );
                                                },
                                                padding: EdgeInsets.only(
                                                  top: 20.0,
                                                  bottom: 20.0,
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: <Widget>[
                                                    Image.asset(
                                                      "assets/images/g.png",
                                                      height: 18,
                                                    ),
                                                    Text(
                                                      "GOOGLE",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
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
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }

  _signin(String _email, String _password) async {
    try {
      //Create Get Firebase Auth User
      await auth.signInWithEmailAndPassword(email: _email, password: _password);

      //Stop animation
      setState(() {
        loading = false;
      });

      //Success
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => AuthenticationWrapper()));
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case "ERROR_EMAIL_ALREADY_IN_USE":
        case "account-exists-with-different-credential":
        case "email-already-in-use":
          errorMessage =
              "Adresse e-Mail déjà utilisée. Accédez à la page de connexion.";
          Fluttertoast.showToast(
              msg: errorMessage,
              gravity: ToastGravity.TOP,
              backgroundColor: Colors.white,
              textColor: Colors.black,
              timeInSecForIosWeb: 5);
          //Stop animation
          setState(() {
            loading = false;
          });
          break;
        case "ERROR_WRONG_PASSWORD":
        case "wrong-password":
          errorMessage =
              "Mot de passe incorrect, Mauvaise combinaison e-mail/mot de passe.";
          Fluttertoast.showToast(
              msg: errorMessage,
              gravity: ToastGravity.TOP,
              backgroundColor: Colors.white,
              textColor: Colors.black,
              timeInSecForIosWeb: 5);
          //Stop animation
          setState(() {
            loading = false;
          });
          break;
        case "ERROR_USER_NOT_FOUND":
        case "user-not-found":
          errorMessage = "Aucun utilisateur trouvé avec cet e-mail.";
          Fluttertoast.showToast(
            msg: errorMessage,
            gravity: ToastGravity.TOP,
            backgroundColor: Colors.white,
            textColor: Colors.black,
            timeInSecForIosWeb: 5,
          );
          //Stop animation
          setState(() {
            loading = false;
          });
          break;
        case "ERROR_USER_DISABLED":
        case "user-disabled":
          errorMessage = "Utilisateur désactivé.";
          Fluttertoast.showToast(
              msg: errorMessage,
              gravity: ToastGravity.TOP,
              backgroundColor: Colors.white,
              textColor: Colors.black,
              timeInSecForIosWeb: 5);
          //Stop animation
          setState(() {
            loading = false;
          });
          break;
        case "ERROR_TOO_MANY_REQUESTS":
        case "operation-not-allowed":
          errorMessage = "Trop de demandes pour se connecter à ce compte.";
          Fluttertoast.showToast(
              msg: errorMessage,
              gravity: ToastGravity.TOP,
              backgroundColor: Colors.white,
              textColor: Colors.black,
              timeInSecForIosWeb: 5);
          //Stop animation
          setState(() {
            loading = false;
          });
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
        case "operation-not-allowed":
          errorMessage = "Erreur de serveur, veuillez réessayer plus tard.";
          Fluttertoast.showToast(
              msg: errorMessage,
              gravity: ToastGravity.TOP,
              backgroundColor: Colors.white,
              textColor: Colors.black,
              timeInSecForIosWeb: 5);
          //Stop animation
          setState(() {
            loading = false;
          });
          break;
        case "ERROR_INVALID_EMAIL":
        case "invalid-email":
          errorMessage = "Adresse email invalide.";
          Fluttertoast.showToast(
              msg: errorMessage,
              gravity: ToastGravity.TOP,
              backgroundColor: Colors.white,
              textColor: Colors.black,
              timeInSecForIosWeb: 5);
          //Stop animation
          setState(() {
            loading = false;
          });
          break;
        case 'There is no user record corresponding to this identifier. The user may have been deleted.':
          errorMessage =
              "Il n'y a pas de fiche utilisateur correspondant à cet identifiant. L'utilisateur a peut-être été supprimé.";
          Fluttertoast.showToast(
              msg: errorMessage,
              gravity: ToastGravity.TOP,
              backgroundColor: Colors.white,
              textColor: Colors.black,
              timeInSecForIosWeb: 5);
          //Stop animation
          setState(() {
            loading = false;
          });
          break;
        case 'The password is invalid or the user does not have a password.':
          errorMessage =
              "le mot de passe est invalide ou l'utilisateur n'a pas de mot de passe";
          Fluttertoast.showToast(
              msg: errorMessage,
              gravity: ToastGravity.TOP,
              backgroundColor: Colors.white,
              textColor: Colors.black,
              timeInSecForIosWeb: 5);
          //Stop animation
          setState(() {
            loading = false;
          });
          break;
        case 'A network error (such as timeout, interrupted connection or unreachable host) has occurred.':
          errorMessage =
              "le mot de passe est invalide ou l'utilisateur n'a pas de mot de passe";
          Fluttertoast.showToast(
              msg: errorMessage,
              gravity: ToastGravity.TOP,
              backgroundColor: Colors.white,
              textColor: Colors.black,
              timeInSecForIosWeb: 5);
          //Stop animation
          setState(() {
            loading = false;
          });
          break;
        default:
          errorMessage = "Échec de la connexion. Veuillez réessayer.";
          Fluttertoast.showToast(
              msg: errorMessage,
              gravity: ToastGravity.TOP,
              backgroundColor: Colors.white,
              textColor: Colors.black,
              timeInSecForIosWeb: 5);
          //Stop animation
          setState(() {
            loading = false;
          });
          break;
      }
    }
  }
}
