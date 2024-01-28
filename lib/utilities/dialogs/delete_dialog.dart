import 'package:flutter/material.dart';
import 'package:nova/utilities/dialogs/generic_dialog.dart';

Future<bool> showDeleteDialog(BuildContext context) {
  return showGenericDialog<bool>(
      context: context,
      title: 'You are about Delete the note',
      content: 'Do you really hate it so much you wanna delete this?',
      optionsBuilder: () => {
        'Cancel': false,
        "Yes, I'm heartless": true,
      },
      ).then((value) => value ?? false,
    );
}
