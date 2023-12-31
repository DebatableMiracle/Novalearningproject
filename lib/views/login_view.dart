import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nova/firebase_options.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
          backgroundColor: const Color.fromARGB(255, 33, 69, 228),
          title: const Text("It's Login' Time"),
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
                          hintText: "Enter your E-mail here "),
                      controller: _email,
                      keyboardType: TextInputType.emailAddress,
                      enableSuggestions: false,
                      autocorrect: false,
                    ),
                    TextField(
                      decoration: const InputDecoration(
                          hintText: "Enter your password, totally safe uwu"),
                      controller: _password,
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                    ),
                    TextButton(
                        onPressed: () async {
                          final email = _email.text;
                          final password = _password.text;
                          await Firebase.initializeApp(
                            options: DefaultFirebaseOptions.currentPlatform,
                          );
                          // ignore: unused_local_variable
                          try {
                            final userCredential = FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: email, password: password);
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              print('User not found');
                            } else if (e.code == 'wrong-password') {
                              print('Wrong password bruh try harder');
                            }
                          } catch (e) {
                            debugPrint(
                                "Bruh something happened and I'm not really optimistic about it");
                            print(e.runtimeType);
                            print(e);
                          }

                          //  print(userCredential);
                        },
                        child: const Text("click to Login"))
                  ]);
                default:
                  return const Text("Loading...");
              }
            }));
  }
}
 

              // TODO: Handle this case.
  
          