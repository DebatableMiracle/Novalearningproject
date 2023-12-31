import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nova/firebase_options.dart';
import 'package:nova/views/login_view.dart';
import 'package:nova/views/register_view.dart';
// Import the Firebase Core package

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 22, 210, 110)),
        useMaterial3: true,
        primarySwatch: Colors.indigo,
      ),
      home: const HomePage(),
      routes: {
        '/login/': (context) => const LoginView(),
        '/register/': (context) => const RegisterView(),
      }));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              // final user = FirebaseAuth.instance.currentUser;
              // if (user?.emailVerified ?? false) {
              //   return const Text(
              //       "You're already Verified, chill out mate");
              // } else {
              //   print(user);
              //   return const VerifyEmailView();
              // }
              return const LoginView();

            default:
              return const Text("Loading...");
          }
        });
  }
}

