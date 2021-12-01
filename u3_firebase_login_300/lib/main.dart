import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:u3_firebase_login_300/constants.dart';
import 'package:u3_firebase_login_300/pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: theme.copyWith(
          colorScheme: theme.colorScheme
              .copyWith(primary: kPrimaryColor, secondary: kSecondaryColor, background: kBackgroundColor)),
      home: LoginPage(),
    );
  }
}
