import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nova/firebase_options.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          foregroundColor: const Color.fromARGB(255, 255, 255, 255),
          backgroundColor: const Color.fromARGB(255, 65, 9, 150),
          title: const Text("Register for Existentialism"),
        ),
        body: FutureBuilder(
            future: Firebase.initializeApp(
              options: DefaultFirebaseOptions.currentPlatform,
            ),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  return Column(children: [
                    TextField(
                      decoration: const InputDecoration(
                          hintText: "Enter your E-mail here broski"),
                      controller: _email,
                      keyboardType: TextInputType.emailAddress,
                      enableSuggestions: false,
                      autocorrect: false,
                    ),
                    TextField(
                      decoration: const InputDecoration(
                          hintText:
                              "Enter your password... it's totally safe uwu"),
                      controller: _password,
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                    ),
                    TextButton(
                        onPressed: () async {
                          final email = _email.text;
                          final password = _password.text;
                          try {
                            await Firebase.initializeApp(
                              options: DefaultFirebaseOptions.currentPlatform,
                            );
                            // ignore: unused_local_variable
                            final userCredential = FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                                    email: email, password: password);
                            print(userCredential);
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {
                              print('Weak Password');
                            } else if (e.code == 'email-already-in-use') {
                              print('E-mail is already in use');
                            } else if (e.code == 'invalid-email') {
                              print("are you stoopid? Invalid E-mail");
                            }
                            print(e.code);
                          }
                        },
                        child: const Text("click to Register"))
                  ]);
                default:
                  return const Text("Loading...");
              }
            }));
  }
}

              // TODO: Handle this case.
  
          