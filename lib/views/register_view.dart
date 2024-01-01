import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nova/constants/routes.dart';
import 'package:nova/firebase_options.dart';
import 'dart:developer' as devtools show log;

import 'package:nova/utilities/show_error_dialog.dart';

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
                await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: email,
                  password: password,
                );
                final user = FirebaseAuth.instance.currentUser;
                await user?.sendEmailVerification();
                Navigator.of(context).pushNamed(verifyemailRoute);
              } on FirebaseAuthException catch (e) {
                devtools.log(e.code.toString());

                if (e.code == 'weak-password') {
                  await showErrorDialog(
                    context,
                    'Weak Password \n Tip: minimum length is only 6 characters!',
                  );
                  devtools.log('weak Password');
                } else if (e.code == 'email-already-in-use') {
                  await showErrorDialog(
                    context,
                    'E mail already in use.',
                  );
                } else if (e.code == 'invalid-email') {
                  await showErrorDialog(
                    context,
                    'Invalid E-mail \n Make sure you\'ve entered your correct E-mail',
                  );
                } else {
                  showErrorDialog(context, 'Error ${e.code}');
                }
              } catch (e) {
                showErrorDialog(context, e.toString());
              }
            },
            child: const Text("click to Register")),
        TextButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(loginRoute, (route) => false);
            },
            child: const Text("Already Registered? Login here!"))
      ]),
    );
  }
}
