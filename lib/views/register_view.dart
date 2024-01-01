import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nova/firebase_options.dart';
import 'dart:developer' as devtools show log;

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
        title: const Text("Register!"),
        backgroundColor: const Color.fromARGB(255, 255, 120, 120),
      ),
      body: Column(children: [
        TextField(
          decoration:
              const InputDecoration(hintText: "Enter your E-mail here broski"),
          controller: _email,
          keyboardType: TextInputType.emailAddress,
          enableSuggestions: false,
          autocorrect: false,
        ),
        TextField(
          decoration: const InputDecoration(
              hintText: "Enter your password... it's totally safe uwu"),
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
                devtools.log(userCredential.toString());
              } on FirebaseAuthException catch (e) {
                if (e.code == 'weak-password') {
                  devtools.log('Weak Password');
                } else if (e.code == 'email-already-in-use') {
                  devtools.log('E-mail is already in use');
                } else if (e.code == 'invalid-email') {
                  devtools.log("are you stoopid? Invalid E-mail");
                }
                devtools.log(e.code);
              }
            },
            child: const Text("click to Register")),
        TextButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/login/', (route) => false);
            },
            child: const Text("Already Registered? Login here!"))
      ]),
    );
  }
}
