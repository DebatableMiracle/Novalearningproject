import 'package:flutter/material.dart';
import 'package:nova/constants/routes.dart';
import 'package:nova/services/auth/auth_service.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        backgroundColor: const Color.fromARGB(255, 255, 120, 120),
      ),
      body: Column(children: [
        const Text(
            'We\'ve sentyou an E-mail verification. Please open the link to verify the link'),
        const Text(
            'If you haven\'t received an E-mail verification mail then press the button below'),
        TextButton(
          onPressed: () async {
            await AuthService.firebase().sendEmailVerification();
          },
          child: const Text("Send the verification email"),
        ),
        TextButton(
            onPressed: () async {
              await AuthService.firebase().logOut();
              Navigator.of(context).pushNamedAndRemoveUntil(
                registerRoute,
                (route) => false,
              );
            },
            child: const Text('Go back to Sign in page'))
      ]),
    );
  }
}


              // TODO: Handle this case.
  
          

