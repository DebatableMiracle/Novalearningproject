import 'package:flutter/material.dart';
import 'package:nova/constants/routes.dart';
//import 'dart:developer' as devtools show log;
import 'package:nova/services/auth/auth_exceptions.dart';
import 'package:nova/services/auth/auth_service.dart';
import 'package:nova/utilities/dialogs/error_dialog.dart';

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
        title: const Text("Login"),
        backgroundColor: const Color.fromARGB(255, 255, 120, 120),
      ),
      body: Column(children: [
        TextField(
          decoration:
              const InputDecoration(hintText: "Enter your E-mail here "),
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
              try {
                await AuthService.firebase().logIn(
                  email: email,
                  password: password,
                );
               final user = AuthService.firebase().currentUser;
              if (user?.isEmailVerified ?? false) {
                  //User's email is verified
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    notesRoute,
                    (route) => false,
                  );
                } else {
                  // User's email is not verified
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    verifyemailRoute,
                    (route) => false,
                  );
                }
              } on UserNotFoundAuthException {
                // ignore: use_build_context_synchronously
                await showErrorDialog(
                    context,
                    'User not found!',);
              } on InvalidCredentialAuthException {
                 // ignore: use_build_context_synchronously
                 await showErrorDialog(
                    context,
                    'Invalid credentials!',
                  );
              } on GenericAuthException {
                // ignore: use_build_context_synchronously
                await showErrorDialog(
                  context,
                  'Authentication Error',
                );
              }
            },
            child: const Text("click to Login")),
        TextButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                registerRoute,
                (route) => false,
              );
            },
            child: const Text('Not registered yet? Register now'))
      ]),
    );
  }
}
