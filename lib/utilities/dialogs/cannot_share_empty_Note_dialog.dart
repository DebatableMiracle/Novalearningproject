import 'package:flutter/material.dart';
import 'package:nova/utilities/dialogs/generic_dialog.dart';

Future<void> showCannotShareEmptyNoteDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: 'Sharing Error',
    content: 'You cannot share an empty Note',
    optionsBuilder: () => {
      'Cool': Null,
    },
  );
}
