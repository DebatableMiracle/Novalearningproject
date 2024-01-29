import 'package:flutter/material.dart';
import 'package:nova/constants/routes.dart';
import 'package:nova/services/auth/auth_service.dart';
import 'package:nova/views/login_view.dart';
import 'package:nova/views/notes/create_update_note_view.dart';
import 'package:nova/views/notes/notes_view.dart';
import 'package:nova/views/register_view.dart';
import 'package:nova/views/verify_email_view.dart';
// import 'package:path/path.dart';
//import 'dart:developer' as devtools show log;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.blueGrey,
          ),
          scaffoldBackgroundColor: const Color(0xFFFFF8E1),
          appBarTheme: const AppBarTheme(
              backgroundColor: Color.fromARGB(255, 255, 125, 125))),
      home: const HomePage(),
      routes: {
        notesRoute: (context) => const NotesView(),
        loginRoute: (context) => const LoginView(),
        registerRoute: (context) => const RegisterView(),
        verifyemailRoute: (context) => const VerifyEmailView(),
        createOrUpdateNoteRoute: (context) => const CreateUpdateNoteView(),
      }));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthService.firebase().initialize(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = AuthService.firebase().currentUser;
            if (user != null) {
              if (user.isEmailVerified) {
                return const NotesView();
              } else {
                return const VerifyEmailView();
              }
            } else {
              return const LoginView();
            }
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}
