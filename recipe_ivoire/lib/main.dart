import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_recipee_app/Screens/onboarding.dart';
import 'package:flutter_recipee_app/Screens/wrapper.dart';
import 'package:flutter_recipee_app/services/authentification_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<AuthenticationService>(
            create: (_) => AuthenticationService(FirebaseAuth.instance),
          ),
          StreamProvider(
            create: (context) =>
                context.read<AuthenticationService>().authStateChanges,
            initialData: null,
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Recette Ivoire',
          theme: ThemeData(
              primarySwatch: Colors.blue, brightness: Brightness.light),
          home: Wrapeer(),
        ));
  }
}

class Wrapeer extends StatefulWidget {
  const Wrapeer({Key key}) : super(key: key);

  @override
  _WrapeerState createState() => _WrapeerState();
}

class _WrapeerState extends State<Wrapeer> {
  Future<SharedPreferences> pref = SharedPreferences.getInstance();
  bool isFirst;
  @override
  void initState() {
    pref.then((SharedPreferences _prefs) {
      setState(() {
        isFirst = _prefs.getBool("isFirst") ?? true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isFirst == null)
      return Container(
        color: Colors.white,
      );
    return SplashScreenView(
      navigateRoute: isFirst ? Description() : AuthenticationWrapper(),
      backgroundColor: Colors.white,
      imageSrc: "assets/images/logo.png",
      text: "Recipe Ivoire",
      textType: TextType.ScaleAnimatedText,
      textStyle: TextStyle(
        color: Colors.orange,
        fontWeight: FontWeight.bold,
        fontSize: 25,
      ),
      imageSize: 260,
    );
  }
}
