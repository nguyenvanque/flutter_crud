


import 'package:firebasedemo/listproduct_screen.dart';
import 'package:firebasedemo/login_page.dart';
import 'package:firebasedemo/register_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';


import 'package:firebase_auth/firebase_auth.dart';
import 'model/user.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseDatabase database = new FirebaseDatabase();
  database.setPersistenceEnabled(true);
  database.setPersistenceCacheSizeBytes(10000000);
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',

      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: login_page(),
    );
  }
}












