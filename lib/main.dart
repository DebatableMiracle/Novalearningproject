import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nova/firebase_options.dart';
import 'views/register_view.dart';
// Import the Firebase Core package

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 22, 210, 110)),
      useMaterial3: true,
      //primarySwatch: Colors.indigo,
    ),
    home: const HomePage(),
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          foregroundColor: const Color.fromARGB(255, 255, 255, 255),
          backgroundColor: const Color.fromARGB(255, 13, 204, 150),
          title: const Text("Home page"),
        ),
        body: FutureBuilder(
            future: Firebase.initializeApp(
              options: DefaultFirebaseOptions.currentPlatform,
            ),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  final user = FirebaseAuth.instance.currentUser;

                  if (user?.emailVerified ?? false) {
                    print("You are a verified user");
                  } else {
                    print("You need to get your email verified broski");
                  }

                  return const Text("ding done");
                default:
                  return const Text("Loading...");
              }
            }));
  }
}
 

              // TODO: Handle this case.
  
          

