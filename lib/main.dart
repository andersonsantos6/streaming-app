import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_project_update/src/components/home/hot_channels.dart';
import 'package:tv_project_update/src/pages/home/home_page.dart';
import 'package:tv_project_update/src/pages/player/player_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      // options: const FirebaseOptions(g
      //     apiKey: "AIzaSyB13HXU7yp2s1DDGSwG55DVHuMX8e4FXIE",
      //     authDomain: "tvproject-247d8.firebaseapp.com",
      //     projectId: "tvproject-247d8",
      //     storageBucket: "tvproject-247d8.appspot.com",
      //     messagingSenderId: "306425384930",
      //     appId: "1:306425384930:web:db0e01331ec865972033bb",
      //     measurementId: "G-2R34783ZPH"),
      );

  runApp(ChangeNotifierProvider(
      create: (context) => HotChannels(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 50, 73, 140),
        accentColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      routes: {
        '/home': (context) => const HomePage(),
        '/player': (context) => VideoApp(),
      },
    );
  }
}
