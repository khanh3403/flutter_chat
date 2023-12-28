import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_chat/pages/signin.dart';
// import 'package:flutter_chat/pages/signin.dart';
import 'firebase_options.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/pages/signin.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_chat/pages/signup.dart';
// import 'package:demo_2/pages/home.dart';
// import 'package:demo_2/pages/chatPage.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('vi_VN', null);
  // if (kIsWeb) {
  //   await Firebase.initializeApp(
  //       options: FirebaseOptions(
  //           apiKey: "AIzaSyDygjxHSsG029hHGYsgpZhU52_mtTB_wJM",
  //           appId: "1:525877642260:web:c50cb7b7d1d086893cd301",
  //           messagingSenderId: "525877642260",
  //           projectId: "chatapp-905be"));
  // }
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // options: FirebaseOptions(
  //     apiKey: "AIzaSyAauzehziEr-IWwefzZTnDYfwFVW8LwVCs",
  //     appId: "1:525877642260:android:b7b52e91e1ce2fa13cd301",
  //     messagingSenderId: "525877642260",
  //     projectId: "chatapp-905be"));
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: signinView(),
    );
  }
}
