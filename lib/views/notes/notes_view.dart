import 'package:flutter/material.dart';
import 'package:nova/constants/routes.dart';
import 'package:nova/enums/menu_action.dart';
import 'package:nova/services/auth/auth_service.dart';
import 'package:nova/services/cloud/cloud_note.dart';
import 'package:nova/services/cloud/firebase_cloud_storage.dart';
import 'package:nova/utilities/dialogs/logout_dialog.dart';
import 'package:nova/views/notes/notes_list_view.dart';

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  String get userId => AuthService.firebase().currentUser!.id;
  late final FirebaseCloudStorage _notesService;

  @override
  void initState() {
    _notesService = FirebaseCloudStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Notes'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(createOrUpdateNoteRoute);
              },
              icon: const Icon(Icons.add),
            ),
            PopupMenuButton<MenuAction>(onSelected: (value) async {
              switch (value) {
                case MenuAction.logout:
                  final shouldLogout = await showLogoutDialog(context);
                  if (shouldLogout) {
                    await AuthService.firebase().logOut();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      loginRoute,
                      (route) => false,
                    );
                  }
              }
            }, itemBuilder: (context) {
              return const [
                PopupMenuItem<MenuAction>(
                  value: MenuAction.logout,
                  child: Text("Log Out"),
                )
              ];
            })
          ],
        ),
        body: StreamBuilder(
                      stream: _notesService.allNotes(ownerUserId: userId),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                          case ConnectionState.active:
                            if (snapshot.hasData) {
                              final allNotes =
                                  snapshot.data as Iterable<CloudNote>;
                              print(allNotes);
                              return NotesListView(
                                notes: allNotes,
                                onDeleteNote: (note) async {
                                  await _notesService.deleteNote(documentId: note.documentId);
                                },
                                onTap: (note) {
                                  Navigator.of(context).pushNamed(
                                      createOrUpdateNoteRoute,
                                      arguments: note);
                                },
                              );
                            } else {
                              return const CircularProgressIndicator();
                            }

                          default:
                            return const CircularProgressIndicator();
                        }
                      }
                      ));
  }
}
